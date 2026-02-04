import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';

extension SubscriptionPackageX on SubscriptionPackage {
  bool get isAnnual => packageType == SubscriptionPackageType.annual;
  bool get isMonthly => packageType == SubscriptionPackageType.monthly;

  bool get isDiscount =>
      identifier.toLowerCase().contains('discount') ||
      productId.toLowerCase().contains('discount');

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
