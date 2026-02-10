import 'dart:async';
import 'dart:io';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:bizzie/env/app_env.dart';
import 'package:bizzie/features/subscription/data/dtos/subscription_status_dto.dart';
import 'package:bizzie/features/subscription/data/dtos/subscription_offering_dto.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/data/interfaces/i_subscription_remote_data_source.dart';

import 'package:injectable/injectable.dart';

import 'package:rxdart/rxdart.dart';

import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/utils/retry_util.dart';

final _logger = BizzieLogger('SubscriptionRemoteDataSource');

@LazySingleton(as: ISubscriptionRemoteDataSource, env: ['prod', 'qa', 'dev'])
class SubscriptionRemoteDataSource implements ISubscriptionRemoteDataSource {
  final AppEnv _env;

  final Map<String, Package> _cachedRcPackages = {};
  bool _isInitialized = false;

  SubscriptionRemoteDataSource(this._env);

  @override
  Future<void> initialize() async {
    if (_isInitialized) {
      _logger.info('Subscription SDK already initialized. Skipping.');
      return;
    }

    try {
      _logger.info('Initializing Subscription SDK...');
      await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.error);
      if (Platform.isIOS) {
        await Purchases.configure(
          PurchasesConfiguration(_env.revenueCatApiKeyIos),
        );
        _isInitialized = true;
      }
    } catch (e, s) {
      _logger.severe('Subscription initialization failed', e, s);
      rethrow;
    }
  }

  @override
  Future<void> logIn(String uid) async {
    _logger.info('Logging in user to RevenueCat: $uid');
    try {
      await Purchases.logIn(uid);
      _logger.info('RevenueCat logIn successful for: $uid');

      await refreshSubscriptionStatus();
    } catch (e, s) {
      _logger.severe('RevenueCat logIn failed for uid: $uid', e, s);
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    _logger.info('Logging out user from RevenueCat');
    try {
      await Purchases.logOut();

      _cachedRcPackages.clear();
      if (!_statusSubject.isClosed) {
        _statusSubject.add(SubscriptionStatusDto.initial());
      }

      _logger.info('RevenueCat logOut successful');
    } catch (e, s) {
      _logger.severe('RevenueCat logOut failed', e, s);
      rethrow;
    }
  }

  @override
  Future<SubscriptionOfferingDto> getOfferings() async {
    return RetryUtil.retry(
      task: () async {
        _logger.info('Fetching offerings from RevenueCat...');
        final offerings = await Purchases.getOfferings();

        final current = offerings.current;

        if (current == null) {
          _logger.warning(
            'No current offering found in RevenueCat. Available identifiers: ${offerings.all.keys}',
          );
          return const SubscriptionOfferingDto(
            identifier: 'none',
            serverDescription: 'No offerings found',
            availablePackages: [],
          );
        }

        _cachedRcPackages.clear();
        for (final package in current.availablePackages) {
          _cachedRcPackages[package.identifier] = package;
        }

        return SubscriptionOfferingDto.fromRevenueCat(current);
      },
    ).catchError((e, s) {
      _logger.severe('Failed to fetch offerings after retries', e, s);
      throw e;
    });
  }

  @override
  Future<Map<String, bool>> checkTrialEligibility(
    List<String> productIds,
  ) async {
    _logger.info('Checking trial eligibility for products: $productIds');
    try {
      final eligibilityMap =
          await Purchases.checkTrialOrIntroductoryPriceEligibility(productIds);
      _logger.info('Trial eligibility check complete');

      return eligibilityMap.map(
        (key, value) => MapEntry(
          key,
          value.status == IntroEligibilityStatus.introEligibilityStatusEligible,
        ),
      );
    } catch (e, s) {
      _logger.severe('Failed to check trial eligibility', e, s);
      rethrow;
    }
  }

  @override
  Future<SubscriptionStatusDto> purchasePackage(
    SubscriptionPackage package,
  ) async {
    return RetryUtil.retry(
      maxRetries: 2,
      retryIf: (e) {
        final error = e.toString().toLowerCase();
        return error.contains('timeout') || error.contains('socket');
      },
      task: () async {
        _logger.info('Initiating purchase for package: ${package.identifier}');
        final rcPackage = _cachedRcPackages[package.identifier];

        if (rcPackage == null) {
          final error = 'Package ${package.identifier} not found in cache';
          _logger.severe(error);
          throw SubscriptionException(
            message:
                '$error. Ensure getOfferings() was called before purchasing.',
          );
        }

        final params = PurchaseParams.package(rcPackage);
        final purchaseResult = await Purchases.purchase(params);

        _logger.info('Purchase successful for ${package.identifier}');
        return SubscriptionStatusDto.fromRevenueCat(
          purchaseResult.customerInfo,
        );
      },
    ).catchError((e, s) {
      _logger.severe('Purchase failed for ${package.identifier}', e, s);
      throw e;
    });
  }

  @override
  Future<SubscriptionStatusDto> restorePurchases() async {
    return RetryUtil.retry(
      task: () async {
        _logger.info('Restoring purchases...');
        final customerInfo = await Purchases.restorePurchases();
        return SubscriptionStatusDto.fromRevenueCat(customerInfo);
      },
    ).catchError((e, s) {
      _logger.severe('Restore purchases failed after retries', e, s);
      throw e;
    });
  }

  @override
  Future<SubscriptionStatusDto> getSubscriptionStatus() async {
    return RetryUtil.retry(
      task: () async {
        _logger.info('Fetching current subscription status...');
        final customerInfo = await Purchases.getCustomerInfo();
        _logger.info('Fetched subscription status successfully');
        return SubscriptionStatusDto.fromRevenueCat(customerInfo);
      },
    ).catchError((e, s) {
      _logger.severe('Failed to get customer info after retries', e, s);
      throw e;
    });
  }

  final _statusSubject = BehaviorSubject<SubscriptionStatusDto>();
  bool _isListening = false;
  CustomerInfoUpdateListener? _rcListener;

  @override
  Stream<SubscriptionStatusDto> watchSubscriptionStatus() {
    if (!_isListening) {
      _logger.info('Starting subscription status listener');
      _isListening = true;

      getSubscriptionStatus()
          .then((dto) {
            if (!_statusSubject.isClosed) {
              _statusSubject.add(dto);
            }
          })
          .catchError((e, s) {
            _logger.severe(
              'Failed to get initial subscription status in watch stream',
              e,
              s,
            );
            if (!_statusSubject.isClosed && !_statusSubject.hasValue) {
              _statusSubject.add(SubscriptionStatusDto.initial());
            }
          });

      _rcListener = (info) {
        _logger.info('Subscription update received from RevenueCat');
        if (!_statusSubject.isClosed) {
          _statusSubject.add(SubscriptionStatusDto.fromRevenueCat(info));
        }
      };
      Purchases.addCustomerInfoUpdateListener(_rcListener!);
    }

    return _statusSubject.stream;
  }

  @override
  Future<void> refreshSubscriptionStatus() async {
    return RetryUtil.retry(
      task: () async {
        _logger.info('Manually refreshing subscription status...');
        try {
          await Purchases.syncPurchases();
        } catch (e) {
          _logger.warning(
            'Sync purchases failed (expected in Simulator/Offline)',
            e,
          );
        }

        await Purchases.invalidateCustomerInfoCache();
        final customerInfo = await Purchases.getCustomerInfo();
        if (!_statusSubject.isClosed) {
          _statusSubject.add(
            SubscriptionStatusDto.fromRevenueCat(customerInfo),
          );
        }
      },
    ).catchError((e, s) {
      _logger.severe(
        'Failed to refresh subscription status after retries',
        e,
        s,
      );
    });
  }

  @override
  Future<void> dispose() async {
    _logger.info('Disposing SubscriptionRemoteDataSource...');
    if (_rcListener != null) {
      Purchases.removeCustomerInfoUpdateListener(_rcListener!);
      _rcListener = null;
    }
    await _statusSubject.close();
  }
}
