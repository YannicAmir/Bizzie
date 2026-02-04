import 'package:freezed_annotation/freezed_annotation.dart';
import 'subscription_package.dart';

part 'subscription_offering.freezed.dart';

@freezed
abstract class SubscriptionOffering with _$SubscriptionOffering {
  const factory SubscriptionOffering({
    required String identifier,
    required String serverDescription,
    required List<SubscriptionPackage> availablePackages,
  }) = _SubscriptionOffering;
}
