import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_status.freezed.dart';

@freezed
abstract class SubscriptionStatus with _$SubscriptionStatus {
  const factory SubscriptionStatus({
    required bool isSubscribed,
    required Set<String> activeEntitlements,
    required Set<String> activeProductIds,
    DateTime? expirationDate,
  }) = _SubscriptionStatus;

  factory SubscriptionStatus.initial() => const SubscriptionStatus(
    isSubscribed: false,
    activeEntitlements: {},
    activeProductIds: {},
  );
}
