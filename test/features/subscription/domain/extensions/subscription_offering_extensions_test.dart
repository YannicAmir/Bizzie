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

  final tCustomDiscountPackage = SubscriptionPackage(
    id: 'custom_discount_id',
    identifier: 'custom_pro_discount',
    productId: 'prod_custom_discount',
    packageType: SubscriptionPackageType.custom,
    title: 'Custom Discount',
    description: 'desc',
    priceString: '\$39',
    price: 39.0,
    currencyCode: 'USD',
  );

  final tUnknownDiscountPackage = SubscriptionPackage(
    id: 'unknown_discount_id',
    identifier: 'unknown_pro_discount',
    productId: 'prod_unknown_discount',
    packageType: SubscriptionPackageType.unknown,
    title: 'Unknown Discount',
    description: 'desc',
    priceString: '\$29',
    price: 29.0,
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

    test('annualPackage_withOnlyDiscountedAnnual_returnsNull', () {
      // arrange
      final offering = SubscriptionOffering(
        identifier: 'default',
        serverDescription: 'desc',
        availablePackages: [tDiscountAnnualPackage],
      );

      // act
      final result = offering.annualPackage;

      // assert
      expect(result, isNull);
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

    test('monthlyPackage_withMultiplePackages_returnsMonthlyPackage', () {
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

    test('monthlyPackage_withOnlyDiscountedMonthly_returnsNull', () {
      // arrange
      final tDiscountMonthly = tMonthlyPackage.copyWith(
        identifier: 'monthly_discount',
      );
      final offering = SubscriptionOffering(
        identifier: 'default',
        serverDescription: 'desc',
        availablePackages: [tDiscountMonthly],
      );

      // act
      final result = offering.monthlyPackage;

      // assert
      expect(result, isNull);
    });

    test(
      'discountAnnualPackage_withStandardAnnualMatch_returnsDiscountPackage',
      () {
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
      },
    );

    test('discountAnnualPackage_withCustomPackage_returnsDiscountPackage', () {
      // arrange
      final offering = SubscriptionOffering(
        identifier: 'default',
        serverDescription: 'desc',
        availablePackages: [tCustomDiscountPackage],
      );

      // act
      final result = offering.discountAnnualPackage;

      // assert
      expect(result, equals(tCustomDiscountPackage));
    });

    test('discountAnnualPackage_withUnknownPackage_returnsDiscountPackage', () {
      // arrange
      final offering = SubscriptionOffering(
        identifier: 'default',
        serverDescription: 'desc',
        availablePackages: [tUnknownDiscountPackage],
      );

      // act
      final result = offering.discountAnnualPackage;

      // assert
      expect(result, equals(tUnknownDiscountPackage));
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

    group('annualSavingsPercentage', () {
      test(
        'calculates correct savings (e.g. 100 annual vs 10 monthly -> 120 vs 100 -> 17% savings)',
        () {
          // arrange
          final annual = tAnnualPackage.copyWith(price: 100.0);
          final monthly = tMonthlyPackage.copyWith(price: 10.0);
          final offering = SubscriptionOffering(
            identifier: 'default',
            serverDescription: 'desc',
            availablePackages: [annual, monthly],
          );

          // act
          final result = offering.annualSavingsPercentage;

          // assert
          expect(result, equals(17));
        },
      );

      test('returns 0 if monthly total is less than or equal to annual', () {
        // arrange
        final annual = tAnnualPackage.copyWith(price: 120.0);
        final monthly = tMonthlyPackage.copyWith(price: 10.0);
        final offering = SubscriptionOffering(
          identifier: 'default',
          serverDescription: 'desc',
          availablePackages: [annual, monthly],
        );

        // act
        final result = offering.annualSavingsPercentage;

        // assert
        expect(result, equals(0));
      });

      test('returns 0 if either package is missing', () {
        // arrange
        final offering = SubscriptionOffering(
          identifier: 'default',
          serverDescription: 'desc',
          availablePackages: [tAnnualPackage],
        );

        // act
        final result = offering.annualSavingsPercentage;

        // assert
        expect(result, equals(0));
      });

      test('annualSavingsPercentage_withZeroPrice_returnsZero', () {
        // arrange
        final annual = tAnnualPackage.copyWith(price: 0.0);
        final monthly = tMonthlyPackage.copyWith(price: 10.0);
        final offering = SubscriptionOffering(
          identifier: 'default',
          serverDescription: 'desc',
          availablePackages: [annual, monthly],
        );

        // act
        final result = offering.annualSavingsPercentage;

        // assert
        expect(result, equals(0));
      });
    });

    group('discountSavingsPercentage', () {
      test(
        'calculates correct savings (e.g. 240 annual vs 144 discount -> 40% savings)',
        () {
          // arrange
          final annual = tAnnualPackage.copyWith(price: 240.0);
          final discount = tDiscountAnnualPackage.copyWith(price: 144.0);
          final offering = SubscriptionOffering(
            identifier: 'default',
            serverDescription: 'desc',
            availablePackages: [annual, discount],
          );

          // act
          final result = offering.discountSavingsPercentage;

          // assert
          expect(result, equals(40));
        },
      );

      test('returns 0 if discount is more expensive than standard', () {
        // arrange
        final annual = tAnnualPackage.copyWith(price: 100.0);
        final discount = tDiscountAnnualPackage.copyWith(price: 110.0);
        final offering = SubscriptionOffering(
          identifier: 'default',
          serverDescription: 'desc',
          availablePackages: [annual, discount],
        );

        // act
        final result = offering.discountSavingsPercentage;

        // assert
        expect(result, equals(0));
      });

      test('returns 0 if either package is missing', () {
        // arrange
        final offering = SubscriptionOffering(
          identifier: 'default',
          serverDescription: 'desc',
          availablePackages: [tAnnualPackage],
        );

        // act
        final result = offering.discountSavingsPercentage;

        // assert
        expect(result, equals(0));
      });

      test('discountSavingsPercentage_withZeroPrice_returnsZero', () {
        // arrange
        final annual = tAnnualPackage.copyWith(price: 0.0);
        final discount = tDiscountAnnualPackage.copyWith(price: 144.0);
        final offering = SubscriptionOffering(
          identifier: 'default',
          serverDescription: 'desc',
          availablePackages: [annual, discount],
        );

        // act
        final result = offering.discountSavingsPercentage;

        // assert
        expect(result, equals(0));
      });
    });
  });
}
