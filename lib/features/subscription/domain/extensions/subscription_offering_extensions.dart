import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:collection/collection.dart';

extension SubscriptionOfferingX on SubscriptionOffering {
  SubscriptionPackage? get annualPackage =>
      _findPackage(SubscriptionPackageType.annual);
  SubscriptionPackage? get monthlyPackage =>
      _findPackage(SubscriptionPackageType.monthly);

  SubscriptionPackage? get discountAnnualPackage {
    return availablePackages.firstWhereOrNull(
      (p) =>
          p.packageType == SubscriptionPackageType.annual &&
          p.identifier.contains('discount'),
    );
  }

  SubscriptionPackage? _findPackage(SubscriptionPackageType type) {
    if (availablePackages.isEmpty) return null;

    final matches = availablePackages
        .where((p) => p.packageType == type)
        .toList();

    if (matches.isEmpty) return null;

    return matches.firstWhereOrNull(
          (p) => !p.identifier.contains('discount'),
        ) ??
        matches.first;
  }
}
