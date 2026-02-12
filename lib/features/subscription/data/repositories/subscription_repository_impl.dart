import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:bizzie/features/subscription/data/interfaces/i_subscription_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/subscription_error_mapper.dart';

final _logger = BizzieLogger('SubscriptionRepositoryImpl');

final Map<String, DateTime> _stickyOverrideVerdict = {};

@LazySingleton(as: ISubscriptionRepository)
class SubscriptionRepositoryImpl implements ISubscriptionRepository {
  final ISubscriptionRemoteDataSource _remoteDataSource;

  SubscriptionRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> initialize() async {
    _logger.info('Initializing subscription service...');
    try {
      await _remoteDataSource.initialize();
      _logger.info('Subscription service initialized successfully.');
    } catch (e, s) {
      _logger.severe('Subscription initialization failed', e, s);
    }
  }

  @override
  Stream<SubscriptionStatus> watchSubscriptionStatus(String userId) {
    _logger.info('Starting subscription status watch for user: $userId');
    return _remoteDataSource.watchSubscriptionStatus().asyncMap((dto) async {
      var domainStatus = dto.toDomain();

      if (domainStatus.isSubscribed) {
        final offeringsResult = await getOfferings();

        await offeringsResult.fold(
          (f) async => _logger.warning(
            'Failed to fetch offerings for stream verification',
            f,
          ),
          (offering) async {
            final packages = offering.availablePackages;

            // Identity of active packages from our offering
            final activePackages = packages
                .where(
                  (p) => domainStatus.activeProductIds.contains(p.productId),
                )
                .toList();

            _logger.info(
              'Repo Override Check (Stream): Subscribed=${domainStatus.isSubscribed}, '
              'ActivePackagesInOffering=${activePackages.map((e) => e.productId).toList()}, '
              'PurchaseDate=${domainStatus.latestPurchaseDate}',
            );

            bool shouldOverride = false;
            String? overrideProductId;

            final isAnyTrialEligible = packages.any(
              (p) => p.isEligibleForTrial,
            );

            // Group-Level Ghost Detection Logic:
            // In an Apple Subscription Group, you cannot be eligible for ANY trial
            // if you have an active subscription in that group.
            if (isAnyTrialEligible && activePackages.isNotEmpty) {
              // 5-Minute Grace Period:
              // Sandbox (and sometimes Prod) has a "Race Condition" where the
              // Eligibility Bits don't flip to false immediately after a purchase.
              // If the purchase happened in the last 5 minutes, we trust RC implicitly.
              final now = DateTime.now().toUtc();
              final purchaseDate = domainStatus.latestPurchaseDate;
              final isFreshPurchase =
                  purchaseDate != null &&
                  now.difference(purchaseDate).inMinutes < 5;

              if (!isFreshPurchase) {
                final ghost = activePackages.first;
                _logger.warning(
                  'Ghost Sub detected! (Aggregate Group Trial Eligible: ${ghost.productId})',
                );
                shouldOverride = true;
                overrideProductId = ghost.productId;
              } else {
                _logger.info(
                  'Ghost check skipped due to Fresh Purchase grace period.',
                );
              }
            }

            // Persistent Sticky Override check:
            if (!shouldOverride) {
              for (final p in activePackages) {
                if (_stickyOverrideVerdict.containsKey(p.productId)) {
                  final cachedDate = _stickyOverrideVerdict[p.productId];
                  if (cachedDate == domainStatus.latestPurchaseDate) {
                    _logger.info(
                      'Persistent Sticky override maintained for ${p.productId} (Purchase Date Lock)',
                    );
                    shouldOverride = true;
                    overrideProductId = p.productId;
                    break;
                  } else {
                    _logger.info(
                      'Clearing sticky override for ${p.productId} (New Purchase detected)',
                    );
                    _stickyOverrideVerdict.remove(p.productId);
                  }
                }
              }
            }

            // Cache the verdict if detected for first time (or re-confirming)
            if (shouldOverride &&
                overrideProductId != null &&
                domainStatus.latestPurchaseDate != null) {
              _stickyOverrideVerdict[overrideProductId] =
                  domainStatus.latestPurchaseDate!;
            }

            if (shouldOverride) {
              _logger.warning(
                'Overriding isSubscribed to false due to Persistent Sticky/Aggregate detection.',
              );
              domainStatus = domainStatus.copyWith(isSubscribed: false);
            } else if (domainStatus.isSubscribed &&
                domainStatus.periodType == SubscriptionPeriodType.normal) {
              // Refined Trial Inference:
              // Only Infer "Trial" if:
              // 1. The active product actually HAS a free trial (hasFreeTrial).
              // 2. StoreKit says the user is NOT eligible for a trial of that product.
              // 3. We didn't already override it as a Ghost.

              for (final p in activePackages) {
                if (p.hasFreeTrial && !p.isEligibleForTrial) {
                  _logger.info('Inferred Trial state for ${p.productId}.');
                  domainStatus = domainStatus.copyWith(
                    periodType: SubscriptionPeriodType.trial,
                  );
                  break;
                }
              }
            }
          },
        );
      }

      _logger.info(
        'Subscription update received in repo for $userId (Active: ${domainStatus.isSubscribed})',
      );
      return domainStatus;
    }).asBroadcastStream();
  }

  @override
  Future<Either<Failure, void>> refreshSubscriptionStatus() async {
    _logger.info('Manually refreshing subscription status...');
    try {
      await _remoteDataSource.refreshSubscriptionStatus();
      _logger.info('Subscription status refresh command sent successfully.');
      return const Right(null);
    } catch (e, s) {
      return Left(_handleError(e, s, 'Failed to refresh subscription status'));
    }
  }

  @override
  Future<Either<Failure, SubscriptionStatus>> getSubscriptionStatus() async {
    _logger.info('Fetching current subscription status...');
    try {
      final dto = await _remoteDataSource.getSubscriptionStatus();
      var domainStatus = dto.toDomain();

      bool shouldOverride = false;
      for (final id in domainStatus.activeProductIds) {
        if (_stickyOverrideVerdict.containsKey(id)) {
          final cachedDate = _stickyOverrideVerdict[id];
          if (cachedDate == domainStatus.latestPurchaseDate) {
            _logger.info(
              'Persistent sticky verdict cached for $id. Applying defensive override.',
            );
            shouldOverride = true;
            break;
          }
        }
      }

      if (shouldOverride) {
        domainStatus = domainStatus.copyWith(isSubscribed: false);
      }

      _logger.info(
        'Successfully retrieved subscription status (Active: ${domainStatus.isSubscribed})',
      );
      return Right(domainStatus);
    } catch (e, s) {
      return Left(_handleError(e, s, 'Failed to get subscription status'));
    }
  }

  @override
  Future<Either<Failure, SubscriptionOffering>> getOfferings() async {
    _logger.info('Retrieving subscription offerings...');
    try {
      final dto = await _remoteDataSource.getOfferings();
      final domain = dto.toDomain();

      final productIds = domain.availablePackages
          .map((e) => e.productId)
          .toList();

      _logger.info('Checking trial eligibility for products: $productIds');
      final eligibilityMap = await _remoteDataSource.checkTrialEligibility(
        productIds,
      );

      final updatedPackages = domain.availablePackages.map((package) {
        final isDynamicallyEligible =
            eligibilityMap[package.productId] ?? false;

        bool finalEligibility = isDynamicallyEligible;

        return package.copyWith(isEligibleForTrial: finalEligibility);
      }).toList();

      _logger.info(
        'Offerings retrieved successfully with trial eligibility data.',
      );
      return Right(domain.copyWith(availablePackages: updatedPackages));
    } catch (e, s) {
      return Left(_handleError(e, s, 'Failed to get offerings'));
    }
  }

  @override
  Future<Either<Failure, SubscriptionStatus>> purchasePackage(
    SubscriptionPackage package,
  ) async {
    _logger.info(
      'Attempting to purchase package: ${package.identifier} (Product: ${package.productId})',
    );
    try {
      final dto = await _remoteDataSource.purchasePackage(package);
      _stickyOverrideVerdict.remove(package.productId);
      _logger.info(
        'Purchase flow completed successfully for ${package.identifier}',
      );
      return Right(dto.toDomain());
    } catch (e, s) {
      return Left(
        _handleError(e, s, 'Purchase failed for ${package.identifier}'),
      );
    }
  }

  @override
  Future<Either<Failure, SubscriptionStatus>> restorePurchases() async {
    _logger.info('Restoring purchases...');
    try {
      final dto = await _remoteDataSource.restorePurchases();
      _logger.info(
        'Restore purchases completed. Status: Subscribed=${dto.isSubscribed}',
      );
      return Right(dto.toDomain());
    } catch (e, s) {
      return Left(_handleError(e, s, 'Restore purchases failed'));
    }
  }

  @override
  Future<Either<Failure, void>> syncIdentity(String? uid) async {
    if (uid != null) {
      return logIn(uid);
    } else {
      return logOut();
    }
  }

  @override
  Future<Either<Failure, void>> logIn(String uid) async {
    _logger.info('Logging in to subscription service for uid: $uid');
    try {
      await _remoteDataSource.logIn(uid);
      _logger.info('Successfully logged in to subscription service for $uid');
      return const Right(null);
    } catch (e, s) {
      return Left(
        _handleError(e, s, 'Login to subscription service failed for $uid'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    _logger.info('Logging out of subscription service...');
    try {
      await _remoteDataSource.logOut();
      _logger.info('Successfully logged out of subscription service.');
      return const Right(null);
    } catch (e, s) {
      return Left(
        _handleError(e, s, 'Logout from subscription service failed'),
      );
    }
  }

  Failure _handleError(dynamic error, StackTrace stackTrace, String message) {
    final failure = SubscriptionErrorMapper.map(error);

    failure.maybeMap(
      cancel: (_) {
        _logger.info('$message: User cancelled.');
      },
      payment: (f) {
        _logger.warning('$message: Payment issue - ${f.message}');
      },
      orElse: () {
        _logger.severe(message, error, stackTrace);
      },
    );

    return failure;
  }
}
