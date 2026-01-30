import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_package.freezed.dart';

@freezed
abstract class SubscriptionPackage with _$SubscriptionPackage {
  const factory SubscriptionPackage({
    required String id,
    required String identifier,
    required String packageType,
    required String title,
    required String description,
    required String priceString,
    required double price,
    required String currencyCode,
  }) = _SubscriptionPackage;
}
