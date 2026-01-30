import 'dart:io';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:bizzie/env/app_env.dart';
import 'package:bizzie/features/subscription/data/dtos/subscription_status_dto.dart';
import 'package:bizzie/features/subscription/data/dtos/subscription_offering_dto.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('SubscriptionRemoteDataSource');

@LazySingleton(as: ISubscriptionRemoteDataSource)
class SubscriptionRemoteDataSource implements ISubscriptionRemoteDataSource {
  final AppEnv _env;

  final Map<String, Package> _cachedRcPackages = {};

  SubscriptionRemoteDataSource(this._env);

  @override
  Future<void> initialize() async {
    try {
      _logger.info('Initializing Subscription SDK...');
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
        _logger.warning('No current offering found in RevenueCat');
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
    } catch (e, s) {
      _logger.severe('Failed to fetch offerings', e, s);
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
}
