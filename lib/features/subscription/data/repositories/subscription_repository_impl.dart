import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:bizzie/features/subscription/data/interfaces/i_subscription_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/subscription_error_mapper.dart';

final _logger = BizzieLogger('SubscriptionRepositoryImpl');

@LazySingleton(as: ISubscriptionRepository)
class SubscriptionRepositoryImpl implements ISubscriptionRepository {
  final ISubscriptionRemoteDataSource _remoteDataSource;

  SubscriptionRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> initialize() async {
    try {
      await _remoteDataSource.initialize();
    } catch (e, s) {
      _logger.severe('Subscription initialization failed', e, s);
    }
  }

  @override
  Stream<SubscriptionStatus> watchSubscriptionStatus(String userId) {
    _logger.info('Starting subscription status watch for user: $userId');
    return _remoteDataSource.watchSubscriptionStatus().map((dto) {
      _logger.info(
        'Subscription update received in repo for $userId (Active: ${dto.isSubscribed})',
      );
      return dto.toDomain();
    }).asBroadcastStream();
  }

  @override
  Future<void> refreshSubscriptionStatus() async {
    try {
      await _remoteDataSource.refreshSubscriptionStatus();
    } catch (e, s) {
      _logger.severe('Failed to refresh subscription status (repo)', e, s);
    }
  }

  @override
  Future<Either<Failure, SubscriptionStatus>> getSubscriptionStatus() async {
    _logger.info('Fetching current subscription status...');
    try {
      final dto = await _remoteDataSource.getSubscriptionStatus();
      _logger.info(
        'Successfully retrieved subscription status (Active: ${dto.isSubscribed})',
      );
      return Right(dto.toDomain());
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
    try {
      final dto = await _remoteDataSource.restorePurchases();
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
    try {
      await _remoteDataSource.logIn(uid);
      return const Right(null);
    } catch (e, s) {
      return Left(
        _handleError(e, s, 'Login to subscription service failed for $uid'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await _remoteDataSource.logOut();
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
