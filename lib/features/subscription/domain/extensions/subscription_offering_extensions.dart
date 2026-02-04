import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:bizzie/features/subscription/domain/extensions/subscription_package_extensions.dart';
import 'package:collection/collection.dart';

extension SubscriptionOfferingX on SubscriptionOffering {
  SubscriptionPackage? get annualPackage =>
      _findPackage(SubscriptionPackageType.annual);
  SubscriptionPackage? get monthlyPackage =>
      _findPackage(SubscriptionPackageType.monthly);

  SubscriptionPackage? get discountAnnualPackage {
    return availablePackages.firstWhereOrNull(
      (p) =>
          (p.packageType == SubscriptionPackageType.annual ||
              p.packageType == SubscriptionPackageType.custom ||
              p.packageType == SubscriptionPackageType.unknown) &&
          p.isDiscount,
    );
  }

  SubscriptionPackage? _findPackage(SubscriptionPackageType type) {
    if (availablePackages.isEmpty) return null;

    final matches = availablePackages
        .where((p) => p.packageType == type)
        .toList();

    if (matches.isEmpty) return null;

    return matches.firstWhereOrNull((p) => !p.isDiscount);
  }

  int get annualSavingsPercentage {
    final annual = annualPackage;
    final monthly = monthlyPackage;

    if (annual == null || monthly == null) return 0;
    if (annual.price <= 0 || monthly.price <= 0) return 0;

    final monthlyTotal = monthly.price * 12;
    if (monthlyTotal <= annual.price) return 0;

    final savings = (monthlyTotal - annual.price) / monthlyTotal;
    return (savings * 100).round();
  }

  int get discountSavingsPercentage {
    final standard = annualPackage;
    final discount = discountAnnualPackage;

    if (standard == null || discount == null) return 0;
    if (standard.price <= 0 || discount.price <= 0) return 0;

    if (standard.price <= discount.price) return 0;

    final savings = (standard.price - discount.price) / standard.price;
    return (savings * 100).round();
  }
}
