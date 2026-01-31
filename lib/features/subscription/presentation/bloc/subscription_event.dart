import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';

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
  const factory SubscriptionEvent.userIdentityChanged(String? uid) =
      SubscriptionUserIdentityChanged;
  const factory SubscriptionEvent.offeringsRequested() =
      SubscriptionOfferingsRequested;
}
