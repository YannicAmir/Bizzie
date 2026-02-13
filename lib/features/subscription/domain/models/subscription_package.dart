import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_package.freezed.dart';
part 'subscription_package.g.dart';

@freezed
abstract class SubscriptionPackage with _$SubscriptionPackage {
  const factory SubscriptionPackage({
    required String id,
    required String identifier,
    required String productId,
    required SubscriptionPackageType packageType,
    required String title,
    required String description,
    required String priceString,
    required double price,
    required String currencyCode,
    @Default(false) bool isEligibleForTrial,
    @Default(false) bool hasFreeTrial,
  }) = _SubscriptionPackage;
  factory SubscriptionPackage.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPackageFromJson(json);
}
