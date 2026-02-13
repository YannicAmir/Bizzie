import 'package:flutter/foundation.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:bizzie/features/subscription/domain/constants/subscription_constants.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:bizzie/core/logging/bizzie_logger.dart';

part 'subscription_status_dto.freezed.dart';
part 'subscription_status_dto.g.dart';

final _logger = BizzieLogger('SubscriptionStatusDto');

@freezed
abstract class SubscriptionStatusDto with _$SubscriptionStatusDto {
  const SubscriptionStatusDto._();
  const factory SubscriptionStatusDto({
    required bool isSubscribed,
    required Set<String> activeEntitlements,
    required Set<String> activeProductIds,
    DateTime? expirationDate,
    DateTime? latestPurchaseDate,
    String? managementURL,
    String? periodType,
    String? activePlanId,
  }) = _SubscriptionStatusDto;

  factory SubscriptionStatusDto.initial() => const SubscriptionStatusDto(
    isSubscribed: false,
    activeEntitlements: {},
    activeProductIds: {},
    activePlanId: null,
  );

  factory SubscriptionStatusDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionStatusDtoFromJson(json);

  factory SubscriptionStatusDto.fromRevenueCat(CustomerInfo info) {
    bool isSubscribed = false;
    final activeEntitlements = info.entitlements.active.keys.toSet();
    final activeProductIds = info.activeSubscriptions.toSet();
    DateTime? expirationDate;
    DateTime? latestPurchaseDate;
    String? periodType;
    String? activePlanId;

    final plusEntitlement =
        info.entitlements.active[SubscriptionConstants.entitlementPlus];

    if (plusEntitlement != null) {
      final expStr = plusEntitlement.expirationDate;
      if (expStr != null) {
        expirationDate = DateTime.tryParse(expStr)?.toUtc();
      }

      final purStr = plusEntitlement.latestPurchaseDate;
      latestPurchaseDate = DateTime.tryParse(purStr)?.toUtc();

      final isExpired =
          expirationDate != null &&
          expirationDate.isBefore(DateTime.now().toUtc());

      _logger.info(
        'RC Entitlement Debug: Product=${plusEntitlement.productIdentifier}, '
        'PeriodType=${plusEntitlement.periodType}, Exp=$expirationDate, '
        'Pur=$latestPurchaseDate, IsExpired=$isExpired, Now=${DateTime.now().toUtc()}',
      );

      if (!isExpired) {
        isSubscribed = true;
        activePlanId = plusEntitlement.productIdentifier;

        if (plusEntitlement.periodType == PeriodType.trial) {
          periodType = 'trial';
        } else if (plusEntitlement.periodType == PeriodType.intro) {
          periodType = 'intro';
        } else {
          periodType = 'normal';
        }
      }
    }

    if (expirationDate == null && info.latestExpirationDate != null) {
      expirationDate = DateTime.tryParse(info.latestExpirationDate!)?.toUtc();
    }

    return SubscriptionStatusDto(
      isSubscribed: isSubscribed,
      activeEntitlements: activeEntitlements,
      activeProductIds: activeProductIds,
      expirationDate: expirationDate,
      latestPurchaseDate: latestPurchaseDate,
      managementURL: info.managementURL,
      periodType: periodType,
      activePlanId: activePlanId,
    );
  }

  SubscriptionStatus toDomain() {
    return SubscriptionStatus(
      isSubscribed: isSubscribed,
      activeEntitlements: activeEntitlements,
      activeProductIds: activeProductIds,
      expirationDate: expirationDate,
      latestPurchaseDate: latestPurchaseDate,
      managementURL: managementURL,
      periodType: SubscriptionPeriodType.fromString(periodType),
      activePlanId: activePlanId,
    );
  }
}
