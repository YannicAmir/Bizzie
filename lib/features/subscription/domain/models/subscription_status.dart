import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';

part 'subscription_status.freezed.dart';

@freezed
abstract class SubscriptionStatus with _$SubscriptionStatus {
  const factory SubscriptionStatus({
    required bool isSubscribed,
    required Set<String> activeEntitlements,
    required Set<String> activeProductIds,
    DateTime? expirationDate,
    DateTime? latestPurchaseDate,
    String? managementURL,
    String? activePlanId,
    @Default(SubscriptionPeriodType.unknown) SubscriptionPeriodType periodType,
  }) = _SubscriptionStatus;

  factory SubscriptionStatus.initial() => const SubscriptionStatus(
    isSubscribed: false,
    activeEntitlements: {},
    activeProductIds: {},
    activePlanId: null,
  );
}
