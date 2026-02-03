import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_package.freezed.dart';
part 'subscription_package.g.dart';

@freezed
abstract class SubscriptionPackage with _$SubscriptionPackage {
  const factory SubscriptionPackage({
    required String id,
    required String identifier,
    required String productId,
    required String packageType,
    required String title,
    required String description,
    required String priceString,
    required double price,
    required String currencyCode,
    @Default(false) bool isEligibleForTrial,
  }) = _SubscriptionPackage;
  factory SubscriptionPackage.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPackageFromJson(json);
}

extension SubscriptionPackageX on SubscriptionPackage {
  bool get isAnnual => packageType.toLowerCase().contains('annual');
  bool get isMonthly => packageType.toLowerCase().contains('monthly');

  String get pricePerMonthString {
    final monthlyPrice = isAnnual ? price / 12 : price;
    return '\$${monthlyPrice.toStringAsFixed(2)}';
  }

  String get renewalDisclaimer {
    if (isEligibleForTrial) {
      if (isAnnual) {
        return '7 days free, then $priceString/year. Cancel anytime.';
      }
      return '7 days free, then $priceString/month. Cancel anytime.';
    }

    if (isAnnual) {
      return 'Auto-renews for $priceString/year. Cancel anytime.';
    }
    return 'Auto-renews for $priceString/month. Cancel anytime.';
  }
}
