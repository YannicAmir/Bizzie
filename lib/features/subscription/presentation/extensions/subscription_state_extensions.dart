import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/extensions/subscription_package_extensions.dart';
import 'package:bizzie/features/subscription/domain/extensions/subscription_offering_extensions.dart';

extension SubscriptionStateX on SubscriptionState {
  bool get isLoading => this is SubscriptionStateLoading;

  Failure? get failure =>
      maybeMap(failure: (f) => f.failure, orElse: () => null);

  SubscriptionPackage? get annualPackage =>
      maybeMap(loaded: (s) => s.annualPackage, orElse: () => null);

  SubscriptionPackage? get monthlyPackage =>
      maybeMap(loaded: (s) => s.monthlyPackage, orElse: () => null);

  SubscriptionPackage? get discountAnnualPackage =>
      maybeMap(loaded: (s) => s.discountAnnualPackage, orElse: () => null);

  bool get isPurchasing =>
      maybeMap(loaded: (s) => s.isPurchasing, orElse: () => false);

  String get discountPercentageText {
    return maybeMap(
      loaded: (s) => '-${s.offerings.discountSavingsPercentage}%',
      orElse: () => '',
    );
  }

  String get annualSavingsText {
    return maybeMap(
      loaded: (s) => 'Save ${s.offerings.annualSavingsPercentage}%',
      orElse: () => '',
    );
  }

  String get totalDiscountSavingsText {
    return maybeMap(
      loaded: (s) {
        final annual = s.annualPackage;
        final discount = s.discountAnnualPackage;
        if (annual == null || discount == null) return '';
        final savings = annual.price - discount.price;
        return '\$${savings.toStringAsFixed(0)}';
      },
      orElse: () => '',
    );
  }

  String? get standardAnnualPriceText {
    return maybeMap(
      loaded: (s) => s.annualPackage?.priceString,
      orElse: () => null,
    );
  }

  String get renewalDisclaimerText {
    return maybeMap(
      loaded: (s) {
        final isAnnual = s.isAnnualSelection;
        final package = isAnnual ? s.annualPackage : s.monthlyPackage;
        return _buildDisclaimer(s, package, isAnnual);
      },
      orElse: () => '',
    );
  }

  String get discountRenewalDisclaimerText {
    return maybeMap(
      loaded: (s) {
        return _buildDisclaimer(s, s.discountAnnualPackage, true);
      },
      orElse: () => '',
    );
  }

  String _buildDisclaimer(
    SubscriptionStateLoaded s,
    SubscriptionPackage? package,
    bool isAnnual,
  ) {
    if (package?.renewalDisclaimer != null) return package!.renewalDisclaimer;

    if (isAnnual) {
      final price = s.annualPackage?.priceString ?? '\$240';
      return 'Auto-renews for $price/year. Cancel anytime.';
    } else {
      final price = s.monthlyPackage?.priceString ?? '\$34.95';
      return 'Auto-renews for $price/month. Cancel anytime.';
    }
  }
}
