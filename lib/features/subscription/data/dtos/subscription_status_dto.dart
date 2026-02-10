import 'package:flutter/foundation.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:bizzie/features/subscription/domain/constants/subscription_constants.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:logging/logging.dart';

part 'subscription_status_dto.freezed.dart';
part 'subscription_status_dto.g.dart';

@freezed
abstract class SubscriptionStatusDto with _$SubscriptionStatusDto {
  const SubscriptionStatusDto._();
  const factory SubscriptionStatusDto({
    required bool isSubscribed,
    required Set<String> activeEntitlements,
    required Set<String> activeProductIds,
    DateTime? expirationDate,
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

  static final _logger = Logger('SubscriptionStatusDto');

  factory SubscriptionStatusDto.fromRevenueCat(CustomerInfo info) {
    bool isSubscribed = false;
    final activeEntitlements = info.entitlements.active.keys.toSet();
    final activeProductIds = info.activeSubscriptions.toSet();
    DateTime? expirationDate;
    String? periodType;
    String? activePlanId;

    final plusEntitlement =
        info.entitlements.active[SubscriptionConstants.entitlementPlus];

    if (plusEntitlement != null) {
      isSubscribed = true;

      if (plusEntitlement.periodType == PeriodType.trial) {
        periodType = 'trial';
      } else if (plusEntitlement.periodType == PeriodType.intro) {
        periodType = 'intro';
      } else {
        periodType = 'normal';
      }

      activePlanId = plusEntitlement.productIdentifier;
      expirationDate = DateTime.tryParse(plusEntitlement.expirationDate ?? '');
      // Diagnostic Logging (Purest Gold Observability)
      debugPrint(
        '[SubscriptionStatusDto] RAW PeriodType: ${plusEntitlement.periodType}',
      );
      debugPrint('[SubscriptionStatusDto] MAPPED PeriodType: $periodType');
      debugPrint(
        '[SubscriptionStatusDto] activePlanId: ${plusEntitlement.productIdentifier}',
      );

      _logger.info(
        'Processing Active Entitlement: ${plusEntitlement.productIdentifier} '
        '| PeriodType: ${plusEntitlement.periodType} '
        '| MappedAs: $periodType',
      );

      if (expirationDate != null && expirationDate.isBefore(DateTime.now())) {
        isSubscribed = false;
        _logger.warning('Entitlement detected but already expired!');
      }
    } else {
      _logger.info('No active "plus" entitlement found in CustomerInfo.');
    }

    if (expirationDate == null && info.latestExpirationDate != null) {
      expirationDate = DateTime.tryParse(info.latestExpirationDate!);
    }

    return SubscriptionStatusDto(
      isSubscribed: isSubscribed,
      activeEntitlements: activeEntitlements,
      activeProductIds: activeProductIds,
      expirationDate: expirationDate,
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
      managementURL: managementURL,
      periodType: SubscriptionPeriodType.fromString(periodType),
      activePlanId: activePlanId,
    );
  }
}
