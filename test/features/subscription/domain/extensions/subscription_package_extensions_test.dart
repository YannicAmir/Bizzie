import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:bizzie/features/subscription/domain/extensions/subscription_package_extensions.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tAnnualPackage = SubscriptionPackage(
    id: 'annual_id',
    identifier: 'annual_plus',
    productId: 'prod_annual',
    packageType: SubscriptionPackageType.annual,
    title: 'Annual Plus',
    description: 'desc',
    priceString: '\$99.99',
    price: 99.99,
    currencyCode: 'USD',
    isEligibleForTrial: false,
  );

  const tMonthlyPackage = SubscriptionPackage(
    id: 'monthly_id',
    identifier: 'monthly_plus',
    productId: 'prod_monthly',
    packageType: SubscriptionPackageType.monthly,
    title: 'Monthly Plus',
    description: 'desc',
    priceString: '\$9.99',
    price: 9.99,
    currencyCode: 'USD',
    isEligibleForTrial: true,
  );

  group('SubscriptionPackageX', () {
    test('isAnnual_annualType_returnsTrue', () {
      // arrange
      const package = tAnnualPackage;

      // act
      final result = package.isAnnual;

      // assert
      expect(result, isTrue);
    });

    test('isAnnual_monthlyType_returnsFalse', () {
      // arrange
      const package = tMonthlyPackage;

      // act
      final result = package.isAnnual;

      // assert
      expect(result, isFalse);
    });

    test('isMonthly_monthlyType_returnsTrue', () {
      // arrange
      const package = tMonthlyPackage;

      // act
      final result = package.isMonthly;

      // assert
      expect(result, isTrue);
    });

    test('pricePerMonthString_annualPackage_returnsDividedPrice', () {
      // arrange
      const package = SubscriptionPackage(
        id: 'id',
        identifier: 'id',
        productId: 'prod',
        packageType: SubscriptionPackageType.annual,
        title: 'Title',
        description: 'desc',
        priceString: '\$120.00',
        price: 120.0,
        currencyCode: 'USD',
      );

      // act
      final result = package.pricePerMonthString;

      // assert
      expect(result, equals('\$10.00'));
    });

    test('pricePerMonthString_monthlyPackage_returnsSamePrice', () {
      // arrange
      const package = tMonthlyPackage;

      // act
      final result = package.pricePerMonthString;

      // assert
      expect(result, equals('\$9.99'));
    });

    test('renewalDisclaimer_annualWithTrial_returnsCorrectText', () {
      // arrange
      final package = tAnnualPackage.copyWith(isEligibleForTrial: true);

      // act
      final result = package.renewalDisclaimer;

      // assert
      expect(result, equals('7 days free, then \$99.99/year. Cancel anytime.'));
    });

    test('renewalDisclaimer_monthlyWithTrial_returnsCorrectText', () {
      // arrange
      final package = tMonthlyPackage; // already has isEligibleForTrial: true

      // act
      final result = package.renewalDisclaimer;

      // assert
      expect(result, equals('7 days free, then \$9.99/month. Cancel anytime.'));
    });

    test('renewalDisclaimer_annualNoTrial_returnsCorrectText', () {
      // arrange
      const package = tAnnualPackage;

      // act
      final result = package.renewalDisclaimer;

      // assert
      expect(result, equals('Auto-renews for \$99.99/year. Cancel anytime.'));
    });

    test('renewalDisclaimer_monthlyNoTrial_returnsCorrectText', () {
      // arrange
      final package = tMonthlyPackage.copyWith(isEligibleForTrial: false);

      // act
      final result = package.renewalDisclaimer;

      // assert
      expect(result, equals('Auto-renews for \$9.99/month. Cancel anytime.'));
    });
  });
}
