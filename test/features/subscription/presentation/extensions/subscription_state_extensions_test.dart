import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/subscription/presentation/extensions/subscription_state_extensions.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tAnnualPackage = SubscriptionPackage(
    id: 'annual_id',
    identifier: 'annual_plus',
    productId: 'prod_annual',
    packageType: SubscriptionPackageType.annual,
    title: 'Annual',
    description: 'desc',
    priceString: '\$240',
    price: 240.0,
    currencyCode: 'USD',
  );

  final tMonthlyPackage = SubscriptionPackage(
    id: 'monthly_id',
    identifier: 'monthly_plus',
    productId: 'prod_monthly',
    packageType: SubscriptionPackageType.monthly,
    title: 'Monthly',
    description: 'desc',
    priceString: '\$34.95',
    price: 34.95,
    currencyCode: 'USD',
  );

  final tDiscountAnnualPackage = SubscriptionPackage(
    id: 'discount_id',
    identifier: 'annual_plus_discount',
    productId: 'prod_annual_discount',
    packageType: SubscriptionPackageType.annual,
    title: 'Discount Annual',
    description: 'desc',
    priceString: '\$144',
    price: 144.0,
    currencyCode: 'USD',
  );

  final tOffering = SubscriptionOffering(
    identifier: 'default',
    serverDescription: 'desc',
    availablePackages: [
      tAnnualPackage,
      tMonthlyPackage,
      tDiscountAnnualPackage,
    ],
  );

  final tInitialStatus = SubscriptionStatus.initial();

  final tLoadedState =
      SubscriptionState.loaded(
            status: tInitialStatus.copyWith(isSubscribed: true),
            offerings: tOffering,
            annualPackage: tAnnualPackage,
            monthlyPackage: tMonthlyPackage,
            discountAnnualPackage: tDiscountAnnualPackage,
          )
          as SubscriptionStateLoaded;

  group('SubscriptionStateX', () {
    group('isLoading', () {
      test('isLoading_onLoadingState_returnsTrue', () {
        // arrange
        final state = SubscriptionState.loading(status: tInitialStatus);

        // act
        final result = state.isLoading;

        // assert
        expect(result, isTrue);
      });

      test('isLoading_onOtherStates_returnsFalse', () {
        // arrange
        final state = SubscriptionState.initial(status: tInitialStatus);

        // act
        final result = state.isLoading;

        // assert
        expect(result, isFalse);
      });
    });

    group('failure', () {
      test('failure_onFailureState_returnsFailure', () {
        // arrange
        const tFailure = ServerFailure('error');
        final state = SubscriptionState.failure(
          status: tInitialStatus,
          failure: tFailure,
        );

        // act
        final result = state.failure;

        // assert
        expect(result, equals(tFailure));
      });

      test('failure_onLoadedState_returnsNull', () {
        // act
        final result = tLoadedState.failure;

        // assert
        expect(result, isNull);
      });
    });

    group('isPurchasing', () {
      test('isPurchasing_onLoadedStateWithPurchasingTrue_returnsTrue', () {
        // arrange
        final state = tLoadedState.copyWith(isPurchasing: true);

        // act
        final result = state.isPurchasing;

        // assert
        expect(result, isTrue);
      });

      test('isPurchasing_onInitialState_returnsFalse', () {
        // arrange
        final state = SubscriptionState.initial(status: tInitialStatus);

        // act
        final result = state.isPurchasing;

        // assert
        expect(result, isFalse);
      });
    });

    group('discountPercentageText', () {
      test('discountPercentageText_onLoadedState_returnsFormattedText', () {
        // act
        final result = tLoadedState.discountPercentageText;

        // assert
        expect(result, equals('-40%'));
      });

      test('discountPercentageText_onNonLoadedState_returnsEmptyString', () {
        // arrange
        final state = SubscriptionState.loading(status: tInitialStatus);

        // act
        final result = state.discountPercentageText;

        // assert
        expect(result, isEmpty);
      });
    });

    group('annualSavingsText', () {
      test('annualSavingsText_onLoadedState_returnsFormattedText', () {
        // act
        final result = tLoadedState.annualSavingsText;

        // assert
        expect(result, equals('Save 43%'));
      });
    });

    group('totalDiscountSavingsText', () {
      test('totalDiscountSavingsText_onLoadedState_returnsFormattedAmount', () {
        // act
        final result = tLoadedState.totalDiscountSavingsText;

        // assert
        expect(result, equals('\$96'));
      });

      test(
        'totalDiscountSavingsText_withMissingPackages_returnsEmptyString',
        () {
          // arrange
          final state = tLoadedState.copyWith(annualPackage: null);

          // act
          final result = state.totalDiscountSavingsText;

          // assert
          expect(result, isEmpty);
        },
      );
    });

    group('standardAnnualPriceText', () {
      test('standardAnnualPriceText_onLoadedState_returnsPriceString', () {
        // act
        final result = tLoadedState.standardAnnualPriceText;

        // assert
        expect(result, equals('\$240'));
      });

      test('standardAnnualPriceText_onNonLoadedState_returnsNull', () {
        // arrange
        final state = SubscriptionState.initial(status: tInitialStatus);

        // act
        final result = state.standardAnnualPriceText;

        // assert
        expect(result, isNull);
      });
    });

    group('renewalDisclaimerText', () {
      test('renewalDisclaimerText_onLoadedAnnual_returnsCorrectDisclaimer', () {
        // arrange
        final state = tLoadedState.copyWith(isAnnualSelection: true);

        // act
        final result = state.renewalDisclaimerText;

        // assert
        expect(result, contains('\$240/year'));
      });

      test(
        'renewalDisclaimerText_onLoadedMonthly_returnsCorrectDisclaimer',
        () {
          // arrange
          final state = tLoadedState.copyWith(isAnnualSelection: false);

          // act
          final result = state.renewalDisclaimerText;

          // assert
          expect(result, contains('\$34.95/month'));
        },
      );

      test(
        'renewalDisclaimerText_withTrialEligibility_returnsTrialDisclaimer',
        () {
          // arrange
          final packageWithTrial = tAnnualPackage.copyWith(
            isEligibleForTrial: true,
          );
          final state = tLoadedState.copyWith(
            isAnnualSelection: true,
            annualPackage: packageWithTrial,
          );

          // act
          final result = state.renewalDisclaimerText;

          // assert
          expect(result, contains('7 days free'));
        },
      );

      test('renewalDisclaimerText_onNonLoadedState_returnsEmptyString', () {
        // arrange
        final state = SubscriptionState.loading(status: tInitialStatus);

        // act
        final result = state.renewalDisclaimerText;

        // assert
        expect(result, isEmpty);
      });
    });

    group('discountRenewalDisclaimerText', () {
      test(
        'discountRenewalDisclaimerText_onLoaded_returnsCorrectDisclaimer',
        () {
          // act
          final result = tLoadedState.discountRenewalDisclaimerText;

          // assert
          expect(result, contains('\$144/year'));
        },
      );

      test(
        'discountRenewalDisclaimerText_onNonLoadedState_returnsEmptyString',
        () {
          // arrange
          final state = SubscriptionState.initial(status: tInitialStatus);

          // act
          final result = state.discountRenewalDisclaimerText;

          // assert
          expect(result, isEmpty);
        },
      );
    });

    group('Package Getters (annual/monthly/discount)', () {
      test('annualPackage_onLoaded_returnsPackage', () {
        expect(tLoadedState.annualPackage, equals(tAnnualPackage));
      });

      test('monthlyPackage_onLoaded_returnsPackage', () {
        expect(tLoadedState.monthlyPackage, equals(tMonthlyPackage));
      });

      test('discountAnnualPackage_onLoaded_returnsPackage', () {
        expect(
          tLoadedState.discountAnnualPackage,
          equals(tDiscountAnnualPackage),
        );
      });

      test('packageGetters_onFailure_returnNull', () {
        // arrange
        final state = SubscriptionState.failure(
          status: tInitialStatus,
          failure: const ServerFailure('error'),
        );

        // act & assert
        expect(state.annualPackage, isNull);
        expect(state.monthlyPackage, isNull);
        expect(state.discountAnnualPackage, isNull);
      });
    });
  });
}
