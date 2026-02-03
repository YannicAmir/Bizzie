import 'dart:async';
import 'dart:io';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:bizzie/env/app_env.dart';
import 'package:bizzie/features/subscription/data/dtos/subscription_status_dto.dart';
import 'package:bizzie/features/subscription/data/dtos/subscription_offering_dto.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/data/interfaces/i_subscription_remote_data_source.dart';

import 'package:injectable/injectable.dart';

import 'package:rxdart/rxdart.dart';

import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('SubscriptionRemoteDataSource');

@LazySingleton(as: ISubscriptionRemoteDataSource, env: ['prod', 'qa', 'dev'])
class SubscriptionRemoteDataSource implements ISubscriptionRemoteDataSource {
  final AppEnv _env;

  final Map<String, Package> _cachedRcPackages = {};

  SubscriptionRemoteDataSource(this._env);

  @override
  Future<void> initialize() async {
    try {
      _logger.info('Initializing Subscription SDK...');
      await Purchases.setLogLevel(LogLevel.debug);
      if (Platform.isIOS) {
        await Purchases.configure(
          PurchasesConfiguration(_env.revenueCatApiKeyIos),
        );
      }
    } catch (e, s) {
      _logger.severe('Subscription initialization failed', e, s);
      rethrow;
    }
  }

  @override
  Future<void> logIn(String uid) async {
    await Purchases.logIn(uid);
  }

  @override
  Future<void> logOut() async {
    await Purchases.logOut();
  }

  @override
  Future<SubscriptionOfferingDto> getOfferings() async {
    try {
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
        _logger.info(
          'Package: ${package.identifier}, Product: ${package.storeProduct.identifier}, Trial: ${package.storeProduct.introductoryPrice != null}',
        );
      }

      return SubscriptionOfferingDto.fromRevenueCat(current);
    } catch (e, s) {
      _logger.severe('Failed to fetch offerings', e, s);
      rethrow;
    }
  }

  @override
  Future<Map<String, bool>> checkTrialEligibility(
    List<String> productIds,
  ) async {
    try {
      final eligibilityMap =
          await Purchases.checkTrialOrIntroductoryPriceEligibility(productIds);

      _logger.info('Trial Eligibility Check Results:');
      eligibilityMap.forEach((key, value) {
        _logger.info('Product: $key, Status: ${value.status}');
      });

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
    try {
      _logger.info('Initiating purchase for package: ${package.identifier}');
      final rcPackage = _cachedRcPackages[package.identifier];

      if (rcPackage == null) {
        final error = 'Package ${package.identifier} not found in cache';
        _logger.severe(error);
        throw Exception(
          '$error. Ensure getOfferings() was called before purchasing.',
        );
      }

      final params = PurchaseParams.package(rcPackage);
      final purchaseResult = await Purchases.purchase(params);

      _logger.info('Purchase successful for ${package.identifier}');
      return SubscriptionStatusDto.fromRevenueCat(purchaseResult.customerInfo);
    } catch (e, s) {
      _logger.severe('Purchase failed for ${package.identifier}', e, s);
      rethrow;
    }
  }

  @override
  Future<SubscriptionStatusDto> restorePurchases() async {
    try {
      _logger.info('Restoring purchases...');
      final customerInfo = await Purchases.restorePurchases();
      return SubscriptionStatusDto.fromRevenueCat(customerInfo);
    } catch (e, s) {
      _logger.severe('Restore purchases failed', e, s);
      rethrow;
    }
  }

  @override
  Future<SubscriptionStatusDto> getSubscriptionStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return SubscriptionStatusDto.fromRevenueCat(customerInfo);
    } catch (e, s) {
      _logger.severe('Failed to get customer info', e, s);
      rethrow;
    }
  }

  final _statusSubject = BehaviorSubject<SubscriptionStatusDto>();
  bool _isListening = false;

  @override
  Stream<SubscriptionStatusDto> watchSubscriptionStatus() {
    if (!_isListening) {
      _isListening = true;

      getSubscriptionStatus().then((dto) {
        if (!_statusSubject.isClosed) {
          _statusSubject.add(dto);
        }
      });

      Purchases.addCustomerInfoUpdateListener((info) {
        _logger.info(
          'CustomerInfo updated from RevenueCat listener. Active Entitlements: ${info.entitlements.active.keys}',
        );
        if (!_statusSubject.isClosed) {
          _statusSubject.add(SubscriptionStatusDto.fromRevenueCat(info));
        }
      });
    }

    return _statusSubject.stream;
  }

  @override
  Future<void> refreshSubscriptionStatus() async {
    try {
      _logger.info('Manually refreshing subscription status...');
      await Purchases.invalidateCustomerInfoCache();
      final customerInfo = await Purchases.getCustomerInfo();
      _logger.info(
        'Manual refresh complete. Active Entitlements: ${customerInfo.entitlements.active.keys}',
      );
      if (!_statusSubject.isClosed) {
        _statusSubject.add(SubscriptionStatusDto.fromRevenueCat(customerInfo));
      }
    } catch (e, s) {
      _logger.severe('Failed to refresh subscription status', e, s);
    }
  }
}
