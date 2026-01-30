import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_status.freezed.dart';

@freezed
abstract class SubscriptionStatus with _$SubscriptionStatus {
  const factory SubscriptionStatus({
    required bool isSubscribed,
    required Set<String> activeEntitlements,
    DateTime? expirationDate,
  }) = _SubscriptionStatus;

  factory SubscriptionStatus.initial() =>
      const SubscriptionStatus(isSubscribed: false, activeEntitlements: {});
}
