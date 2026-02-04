import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:bizzie/features/subscription/domain/extensions/subscription_offering_extensions.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tAnnualPackage = SubscriptionPackage(
    id: 'annual_id',
    identifier: 'annual_plus',
    productId: 'prod_annual',
    packageType: SubscriptionPackageType.annual,
    title: 'Annual',
    description: 'desc',
    priceString: '\$99',
    price: 99.0,
    currencyCode: 'USD',
  );

  final tMonthlyPackage = SubscriptionPackage(
    id: 'monthly_id',
    identifier: 'monthly_plus',
    productId: 'prod_monthly',
    packageType: SubscriptionPackageType.monthly,
    title: 'Monthly',
    description: 'desc',
    priceString: '\$9.99',
    price: 9.99,
    currencyCode: 'USD',
  );

  final tDiscountAnnualPackage = SubscriptionPackage(
    id: 'discount_id',
    identifier: 'annual_plus_discount',
    productId: 'prod_annual_discount',
    packageType: SubscriptionPackageType.annual,
    title: 'Discount Annual',
    description: 'desc',
    priceString: '\$49',
    price: 49.0,
    currencyCode: 'USD',
  );

  group('SubscriptionOfferingX', () {
    test('annualPackage_withMultiplePackages_prioritizesNonDiscounted', () {
      // arrange
      final offering = SubscriptionOffering(
        identifier: 'default',
        serverDescription: 'desc',
        availablePackages: [tDiscountAnnualPackage, tAnnualPackage],
      );

      // act
      final result = offering.annualPackage;

      // assert
      expect(result, equals(tAnnualPackage));
    });

    test('annualPackage_withOnlyDiscounted_returnsDiscountedAsFallback', () {
      // arrange
      final offering = SubscriptionOffering(
        identifier: 'default',
        serverDescription: 'desc',
        availablePackages: [tDiscountAnnualPackage],
      );

      // act
      final result = offering.annualPackage;

      // assert
      expect(result, equals(tDiscountAnnualPackage));
    });

    test('annualPackage_withNoMatches_returnsNull', () {
      // arrange
      final offering = SubscriptionOffering(
        identifier: 'default',
        serverDescription: 'desc',
        availablePackages: [tMonthlyPackage],
      );

      // act
      final result = offering.annualPackage;

      // assert
      expect(result, isNull);
    });

    test('monthlyPackage_success_returnsMonthlyPackage', () {
      // arrange
      final offering = SubscriptionOffering(
        identifier: 'default',
        serverDescription: 'desc',
        availablePackages: [tMonthlyPackage, tAnnualPackage],
      );

      // act
      final result = offering.monthlyPackage;

      // assert
      expect(result, equals(tMonthlyPackage));
    });

    test('discountAnnualPackage_withMatches_returnsDiscountedPackage', () {
      // arrange
      final offering = SubscriptionOffering(
        identifier: 'default',
        serverDescription: 'desc',
        availablePackages: [tDiscountAnnualPackage, tAnnualPackage],
      );

      // act
      final result = offering.discountAnnualPackage;

      // assert
      expect(result, equals(tDiscountAnnualPackage));
    });

    test('discountAnnualPackage_withoutMatches_returnsNull', () {
      // arrange
      final offering = SubscriptionOffering(
        identifier: 'default',
        serverDescription: 'desc',
        availablePackages: [tAnnualPackage],
      );

      // act
      final result = offering.discountAnnualPackage;

      // assert
      expect(result, isNull);
    });
  });
}
