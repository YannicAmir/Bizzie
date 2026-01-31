import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';

extension SubscriptionOfferingX on SubscriptionOffering {
  SubscriptionPackage? get annualPackage {
    if (availablePackages.isEmpty) return null;
    return availablePackages.firstWhere(
      (p) =>
          p.packageType.contains('annual') &&
          !p.identifier.contains('discount'),
      orElse: () => availablePackages.firstWhere(
        (p) => p.packageType.contains('annual'),
        orElse: () => availablePackages.first,
      ),
    );
  }

  SubscriptionPackage? get monthlyPackage {
    if (availablePackages.isEmpty) return null;
    return availablePackages.firstWhere(
      (p) => p.packageType.contains('monthly'),
      orElse: () => availablePackages.last,
    );
  }

  SubscriptionPackage? get discountAnnualPackage {
    if (availablePackages.isEmpty) return null;
    return availablePackages.firstWhere(
      (p) =>
          p.packageType.contains('annual') && p.identifier.contains('discount'),
      orElse: () => availablePackages.first,
    );
  }
}
