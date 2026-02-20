import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/enums/paywall_type.dart';

import 'package:bizzie/core/enums/paywall_source.dart';

part 'subscription_event.freezed.dart';

@freezed
abstract class SubscriptionEvent with _$SubscriptionEvent {
  const factory SubscriptionEvent.initialized() = SubscriptionEventInitialized;
  const factory SubscriptionEvent.statusUpdated(SubscriptionStatus status) =
      SubscriptionStatusUpdated;
  const factory SubscriptionEvent.purchaseRequested(
    SubscriptionPackage package,
  ) = SubscriptionPurchaseRequested;
  const factory SubscriptionEvent.restoreRequested() =
      SubscriptionRestoreRequested;
  const factory SubscriptionEvent.purchaseUICompleted() =
      SubscriptionPurchaseUICompleted;
  const factory SubscriptionEvent.userIdentityChanged(String? uid) =
      SubscriptionUserIdentityChanged;
  const factory SubscriptionEvent.offeringsRequested() =
      SubscriptionOfferingsRequested;
  const factory SubscriptionEvent.refreshRequested() =
      SubscriptionRefreshRequested;
  const factory SubscriptionEvent.planToggled({required bool isAnnual}) =
      SubscriptionPlanToggled;
  const factory SubscriptionEvent.appResumed() = SubscriptionAppResumed;
  const factory SubscriptionEvent.expirationReached() =
      SubscriptionExpirationReached;
  const factory SubscriptionEvent.resetPurchaseState() =
      SubscriptionResetPurchaseState;
  const factory SubscriptionEvent.viewed({
    required PaywallSource source,
    required PaywallType paywallType,
  }) = SubscriptionViewed;
  const factory SubscriptionEvent.giftViewed({required PaywallSource source}) =
      SubscriptionGiftViewed;
  const factory SubscriptionEvent.giftClaimed({required PaywallSource source}) =
      SubscriptionGiftClaimed;
  const factory SubscriptionEvent.giftDismissed({
    required PaywallSource source,
  }) = SubscriptionGiftDismissed;
}
