import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/growth_band.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_highlights_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

const tAnnualData = [
  FinancialDataPoint(date: '2025-12-31', period: 'FY', value: 100),
  FinancialDataPoint(date: '2024-12-31', period: 'FY', value: 90),
];
const tSingleAnnualData = [
  FinancialDataPoint(date: '2025-12-31', period: 'FY', value: 100),
];
const tLocale = 'en_US';
const tCurrency = 'USD';
const tTtmTitle = 'Revenue TTM';

List<FinancialDataPoint> tQuarters(List<double> yearlyQuarterValues) => [
  for (final (yearIndex, value) in yearlyQuarterValues.indexed)
    for (var quarter = 0; quarter < 4; quarter++)
      FinancialDataPoint(
        date:
            '${2025 - yearIndex}-${(12 - quarter * 3).toString().padLeft(2, '0')}-28',
        period: 'Q${4 - quarter}',
        value: value,
      ),
];

void main() {
  group('FinancialHighlightsResolver', () {
    group('resolveAnnualGrowth', () {
      test(
        'resolveAnnualGrowth_annualCagrNegative_returnsNegativeWithCagrYears',
        () {
          // arrange
          final tQuarterly = tQuarters([90, 95, 100]);

          // act
          final result = FinancialHighlightsResolver.resolveAnnualGrowth(
            annualData: tAnnualData,
            quarterlyData: tQuarterly,
          );

          // assert
          expect(result, (band: GrowthBand.negative, years: 2));
        },
      );

      test('resolveAnnualGrowth_annualCagrBelowSix_returnsLow', () {
        // arrange
        final tQuarterly = tQuarters([105, 100, 95]);

        // act
        final result = FinancialHighlightsResolver.resolveAnnualGrowth(
          annualData: tAnnualData,
          quarterlyData: tQuarterly,
        );

        // assert
        expect(result, (band: GrowthBand.low, years: 2));
      });

      test(
        'resolveAnnualGrowth_annualCagrBetweenSixAndThirteen_returnsModerate',
        () {
          // arrange
          final tQuarterly = tQuarters([121, 110, 100]);

          // act
          final result = FinancialHighlightsResolver.resolveAnnualGrowth(
            annualData: tAnnualData,
            quarterlyData: tQuarterly,
          );

          // assert
          expect(result, (band: GrowthBand.moderate, years: 2));
        },
      );

      test(
        'resolveAnnualGrowth_annualCagrAtLeastThirteen_returnsHighWithYears',
        () {
          // arrange
          final tQuarterly = tQuarters([200, 150, 120, 100]);

          // act
          final result = FinancialHighlightsResolver.resolveAnnualGrowth(
            annualData: tAnnualData,
            quarterlyData: tQuarterly,
          );

          // assert
          expect(result, (band: GrowthBand.high, years: 3));
        },
      );

      test('resolveAnnualGrowth_noCagrHistory_fallsBackToOneYearGrowth', () {
        // arrange
        final tQuarterly = tQuarters([110, 100]);

        // act
        final result = FinancialHighlightsResolver.resolveAnnualGrowth(
          annualData: tAnnualData,
          quarterlyData: tQuarterly,
        );

        // assert
        expect(result, (band: GrowthBand.moderate, years: 1));
      });

      test(
        'resolveAnnualGrowth_turnedPositive_returnsTurnedPositiveOverOneYear',
        () {
          // arrange
          final tQuarterly = tQuarters([10, -10]);

          // act
          final result = FinancialHighlightsResolver.resolveAnnualGrowth(
            annualData: tAnnualData,
            quarterlyData: tQuarterly,
          );

          // assert
          expect(result, (band: GrowthBand.turnedPositive, years: 1));
        },
      );

      test(
        'resolveAnnualGrowth_turnedNegative_returnsTurnedNegativeOverOneYear',
        () {
          // arrange
          final tQuarterly = tQuarters([-10, 10]);

          // act
          final result = FinancialHighlightsResolver.resolveAnnualGrowth(
            annualData: tAnnualData,
            quarterlyData: tQuarterly,
          );

          // assert
          expect(result, (band: GrowthBand.turnedNegative, years: 1));
        },
      );

      test('resolveAnnualGrowth_notMeaningful_returnsNull', () {
        // arrange
        final tQuarterly = tQuarters([-10, -20]);

        // act
        final result = FinancialHighlightsResolver.resolveAnnualGrowth(
          annualData: tAnnualData,
          quarterlyData: tQuarterly,
        );

        // assert
        expect(result, isNull);
      });

      test(
        'resolveAnnualGrowth_singleAnnualPoint_returnsNullLikeMissingCard',
        () {
          // arrange
          final tQuarterly = tQuarters([110, 100]);

          // act
          final result = FinancialHighlightsResolver.resolveAnnualGrowth(
            annualData: tSingleAnnualData,
            quarterlyData: tQuarterly,
          );

          // assert
          expect(result, isNull);
        },
      );

      test('resolveAnnualGrowth_lessThanOneYearOfQuarters_returnsNull', () {
        // arrange
        final tQuarterly = tQuarters([100]).take(3).toList();

        // act
        final result = FinancialHighlightsResolver.resolveAnnualGrowth(
          annualData: tAnnualData,
          quarterlyData: tQuarterly,
        );

        // assert
        expect(result, isNull);
      });
    });

    group('resolveAnnual', () {
      test(
        'resolveAnnual_cagrHigh_secondaryCardKeepsTitleAndSuccessColors',
        () {
          // arrange
          final tQuarterly = tQuarters([200, 150, 120, 100]);

          // act
          final result = FinancialHighlightsResolver.resolveAnnual(
            annualData: tAnnualData,
            quarterlyData: tQuarterly,
            ttmTitle: tTtmTitle,
            currency: tCurrency,
            locale: tLocale,
          );

          // assert
          expect(result?.secondary?.title, '3Y CAGR');
          expect(result?.secondary?.valueText, '+25.99%');
          expect(result?.secondary?.valueColor, AppColors.successText);
          expect(
            result?.secondary?.backgroundColor,
            AppColors.successIconBackground,
          );
        },
      );

      test('resolveAnnual_turnedNegative_secondaryCardShowsRedLabel', () {
        // arrange
        final tQuarterly = tQuarters([-10, 10]);

        // act
        final result = FinancialHighlightsResolver.resolveAnnual(
          annualData: tAnnualData,
          quarterlyData: tQuarterly,
          ttmTitle: tTtmTitle,
          currency: tCurrency,
          locale: tLocale,
        );

        // assert
        expect(result?.secondary, (
          title: '1Y Growth Rate',
          valueText: 'Turned Negative',
          valueColor: AppColors.red800,
          backgroundColor: AppColors.red100,
        ));
      });

      test('resolveAnnual_notMeaningful_secondaryCardShowsSlateNm', () {
        // arrange
        final tQuarterly = tQuarters([-10, -20]);

        // act
        final result = FinancialHighlightsResolver.resolveAnnual(
          annualData: tAnnualData,
          quarterlyData: tQuarterly,
          ttmTitle: tTtmTitle,
          currency: tCurrency,
          locale: tLocale,
        );

        // assert
        expect(result?.secondary, (
          title: '1Y Growth Rate',
          valueText: 'N/M',
          valueColor: AppColors.slate700,
          backgroundColor: AppColors.slate100,
        ));
      });

      test('resolveAnnual_lessThanOneYearOfQuarters_returnsNull', () {
        // arrange
        final tQuarterly = tQuarters([100]).take(3).toList();

        // act
        final result = FinancialHighlightsResolver.resolveAnnual(
          annualData: tAnnualData,
          quarterlyData: tQuarterly,
          ttmTitle: tTtmTitle,
          currency: tCurrency,
          locale: tLocale,
        );

        // assert
        expect(result, isNull);
      });
    });

    group('resolveQuarterly', () {
      test('resolveQuarterly_withCagrHistory_usesOneYearGrowth', () {
        // arrange
        final tQuarterly = tQuarters([103, 100, 50]);

        // act
        final result = FinancialHighlightsResolver.resolveQuarterly(
          quarterlyData: tQuarterly,
          ttmTitle: tTtmTitle,
          currency: tCurrency,
          locale: tLocale,
        );

        // assert
        expect(result?.secondary, (
          title: '1Y Growth Rate',
          valueText: '+3%',
          valueColor: AppColors.orange700,
          backgroundColor: AppColors.orange100,
        ));
      });
    });
  });
}
