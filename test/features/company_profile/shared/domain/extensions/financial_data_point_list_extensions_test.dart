import 'package:bizzie/features/company_profile/shared/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:flutter_test/flutter_test.dart';

const tPoint2021 = FinancialDataPoint(
  date: '2021-12-31',
  period: 'FY',
  value: 2.0,
);
const tPoint2022 = FinancialDataPoint(
  date: '2022-12-31',
  period: 'FY',
  value: 4.0,
);
const tPoint2023 = FinancialDataPoint(
  date: '2023-12-31',
  period: 'FY',
  value: 6.0,
);
const tPoint2024 = FinancialDataPoint(
  date: '2024-12-31',
  period: 'FY',
  value: 8.0,
);

List<FinancialDataPoint> quartersNewestFirst(List<double> values) {
  return [
    for (var i = 0; i < values.length; i++)
      FinancialDataPoint(
        date: '${2100 - i}-01-01',
        period: 'Q',
        value: values[i],
      ),
  ];
}

void main() {
  group('FinancialDataPointListX', () {
    group('averageValue', () {
      test('averageValue_emptyList_returnsZero', () {
        // arrange
        final sut = <FinancialDataPoint>[];

        // act
        final result = sut.averageValue;

        // assert
        expect(result, 0.0);
      });

      test('averageValue_multipleItems_returnsArithmeticMean', () {
        // arrange
        final sut = [tPoint2021, tPoint2022, tPoint2023];

        // act
        final result = sut.averageValue;

        // assert
        expect(result, 4.0);
      });
    });

    group('sortedByDateDescending', () {
      test('sortedByDateDescending_unsortedList_returnsNewestFirst', () {
        // arrange
        final sut = [tPoint2022, tPoint2024, tPoint2021, tPoint2023];

        // act
        final result = sut.sortedByDateDescending();

        // assert
        expect(result, [tPoint2024, tPoint2023, tPoint2022, tPoint2021]);
      });

      test('sortedByDateDescending_unsortedList_doesNotMutateOriginal', () {
        // arrange
        final sut = [tPoint2022, tPoint2024, tPoint2021];

        // act
        sut.sortedByDateDescending();

        // assert
        expect(sut, [tPoint2022, tPoint2024, tPoint2021]);
      });

      test('sortedByDateDescending_emptyList_returnsEmptyList', () {
        // arrange
        final sut = <FinancialDataPoint>[];

        // act
        final result = sut.sortedByDateDescending();

        // assert
        expect(result, isEmpty);
      });
    });

    group('sortedUniqueByDateDescending', () {
      test('sortedUniqueByDateDescending_duplicateDates_keepsOnePerDate', () {
        // arrange — a second point shares 2023-12-31
        const tDuplicate2023 = FinancialDataPoint(
          date: '2023-12-31',
          period: 'FY',
          value: 99.0,
        );
        final sut = [tPoint2022, tPoint2023, tDuplicate2023, tPoint2024];

        // act
        final result = sut.sortedUniqueByDateDescending();

        // assert — one entry per date, still newest-first
        expect(
          result.map((point) => point.date),
          ['2024-12-31', '2023-12-31', '2022-12-31'],
        );
      });

      test('sortedUniqueByDateDescending_noDuplicates_matchesSortedByDate', () {
        // arrange
        final sut = [tPoint2022, tPoint2024, tPoint2021, tPoint2023];

        // act
        final result = sut.sortedUniqueByDateDescending();

        // assert
        expect(result, [tPoint2024, tPoint2023, tPoint2022, tPoint2021]);
      });
    });

    group('getAverageOfLatest', () {
      test('getAverageOfLatest_countExceedsLength_returnsNull', () {
        // arrange
        final sut = [tPoint2023, tPoint2024];

        // act
        final result = sut.getAverageOfLatest(3);

        // assert
        expect(result, isNull);
      });

      test(
        'getAverageOfLatest_countWithinLength_returnsAverageOfLatestByDate',
        () {
          // arrange
          final sut = [tPoint2024, tPoint2021, tPoint2023, tPoint2022];

          // act
          final result = sut.getAverageOfLatest(2);

          // assert
          expect(result, 7.0);
        },
      );

      test('getAverageOfLatest_countEqualsLength_returnsAverageOfAll', () {
        // arrange
        final sut = [tPoint2021, tPoint2022, tPoint2023, tPoint2024];

        // act
        final result = sut.getAverageOfLatest(4);

        // assert
        expect(result, 5.0);
      });

      test('getAverageOfLatest_duplicateInWindow_averagesUniqueDatesOnly', () {
        // arrange — 2024 appears twice; without de-duplication it would fill
        // both requested slots and wrongly exclude 2023.
        const tDuplicate2024 = FinancialDataPoint(
          date: '2024-12-31',
          period: 'FY',
          value: 8.0,
        );
        final sut = [tPoint2024, tDuplicate2024, tPoint2023];

        // act — newest two unique by date: 2024 (8.0), 2023 (6.0)
        final result = sut.getAverageOfLatest(2);

        // assert
        expect(result, 7.0);
      });

      test('getAverageOfLatest_duplicatesReduceUniqueBelowCount_returnsNull', () {
        // arrange — two points but only one unique date
        const tDuplicate2024 = FinancialDataPoint(
          date: '2024-12-31',
          period: 'FY',
          value: 8.0,
        );
        final sut = [tPoint2024, tDuplicate2024];

        // act
        final result = sut.getAverageOfLatest(2);

        // assert
        expect(result, isNull);
      });
    });

    group('trailingTwelveMonthsTotal', () {
      test('trailingTwelveMonthsTotal_fewerThanFourQuarters_returnsNull', () {
        // arrange
        final sut = quartersNewestFirst([10, 20, 30]);

        // act & assert
        expect(sut.trailingTwelveMonthsTotal(), isNull);
      });

      test('trailingTwelveMonthsTotal_sumsOnlyNewestFourByDate', () {
        // arrange — oldest (last) carries a large value that must be excluded
        final sut = quartersNewestFirst([10, 20, 30, 40, 9999]);

        // act & assert
        expect(sut.trailingTwelveMonthsTotal(), 100.0);
      });

      test('trailingTwelveMonthsTotal_exactlyFourQuarters_returnsSum', () {
        // arrange — the boundary at which a full TTM window first exists
        final sut = quartersNewestFirst([10, 20, 30, 40]);

        // act & assert
        expect(sut.trailingTwelveMonthsTotal(), 100.0);
      });

      test('trailingTwelveMonthsTotal_duplicateQuarterDate_doesNotDoubleCount', () {
        // arrange — the newest quarter is duplicated; without de-duplication
        // take(4) would consume the duplicate and drop the oldest quarter,
        // summing 10 + 10 + 20 + 30 = 70 instead of the correct 100.
        const newestDate = '2100-01-01';
        final sut = [
          const FinancialDataPoint(date: newestDate, period: 'Q', value: 10.0),
          const FinancialDataPoint(date: newestDate, period: 'Q', value: 10.0),
          const FinancialDataPoint(date: '2099-01-01', period: 'Q', value: 20.0),
          const FinancialDataPoint(date: '2098-01-01', period: 'Q', value: 30.0),
          const FinancialDataPoint(date: '2097-01-01', period: 'Q', value: 40.0),
        ];

        // act — unique newest four: 10 + 20 + 30 + 40
        final result = sut.trailingTwelveMonthsTotal();

        // assert
        expect(result, 100.0);
      });
    });

    group('trailingTwelveMonthsCagr', () {
      test('trailingTwelveMonthsCagr_fewerThanTwelveQuarters_returnsNull', () {
        // arrange — a 2Y CAGR compares TTM now vs TTM 2 years ago (12 quarters)
        final sut = quartersNewestFirst(List<double>.filled(11, 100));

        // act & assert
        expect(sut.trailingTwelveMonthsCagr(), isNull);
      });

      test('trailingTwelveMonthsCagr_twelveQuarters_returnsTwoYearRate', () {
        // arrange — end TTM 400, start TTM (2y ago) 100 -> (4)^(1/2) - 1 = 100%
        final sut = quartersNewestFirst([
          100, 100, 100, 100, // TTM now = 400
          50, 50, 50, 50, // intervening year
          25, 25, 25, 25, // TTM 2y ago = 100
        ]);

        // act
        final result = sut.trailingTwelveMonthsCagr();

        // assert
        expect(result?.years, 2);
        expect(result?.percentage, closeTo(100.0, 1e-9));
      });

      test(
        'trailingTwelveMonthsCagr_incompleteStartWindow_doesNotUsePartialSpan',
        () {
          // arrange — 13 quarters. A naive floor(length/4)=3 would build a 3Y
          // span whose start window is the single oldest quarter (index 12),
          // yielding a wildly inflated rate. The guard must fall back to 2Y.
          final sut = quartersNewestFirst([
            100, 100, 100, 100, // TTM now = 400
            50, 50, 50, 50, // intervening year
            25, 25, 25, 25, // TTM 2y ago = 100
            1, // lone oldest quarter — must not seed a 3Y start window
          ]);

          // act
          final result = sut.trailingTwelveMonthsCagr();

          // assert — resolves to the valid 2Y span, never a partial 3Y span
          expect(result?.years, 2);
          expect(result?.percentage, closeTo(100.0, 1e-9));
        },
      );

      test('trailingTwelveMonthsCagr_nonPositiveStart_walksToShorterSpan', () {
        // arrange — 16 quarters. The 3Y start TTM is negative and must be
        // skipped, resolving to the positive 2Y span.
        final sut = quartersNewestFirst([
          100, 100, 100, 100, // TTM now = 400
          50, 50, 50, 50, // year -1
          25, 25, 25, 25, // TTM 2y ago = 100 (valid start)
          -10, -10, -10, -10, // TTM 3y ago = -40 (invalid start)
        ]);

        // act
        final result = sut.trailingTwelveMonthsCagr();

        // assert
        expect(result?.years, 2);
        expect(result?.percentage, closeTo(100.0, 1e-9));
      });

      test('trailingTwelveMonthsCagr_moreThanFiveYears_capsSpanAtFiveYears', () {
        // arrange — 24 quarters (6Y of data) all equal. maxYears is 6, but the
        // span must clamp to 5Y; a flat series yields a 0% rate at that span.
        final sut = quartersNewestFirst(List<double>.filled(24, 100));

        // act
        final result = sut.trailingTwelveMonthsCagr();

        // assert — never reports the full 6Y span the data would allow
        expect(result?.years, 5);
        expect(result?.percentage, closeTo(0.0, 1e-9));
      });

      test('trailingTwelveMonthsCagr_noPositiveStartWindow_returnsNull', () {
        // arrange — enough quarters to attempt a 2Y span, but its start TTM is
        // non-positive, so every candidate span is skipped and none resolves.
        final sut = quartersNewestFirst([
          100, 100, 100, 100, // TTM now = 400
          50, 50, 50, 50, // intervening year
          -25, -25, -25, -25, // TTM 2y ago = -100 (invalid start)
        ]);

        // act & assert
        expect(sut.trailingTwelveMonthsCagr(), isNull);
      });
    });

    group('trailingTwelveMonthsGrowth', () {
      test('trailingTwelveMonthsGrowth_fewerThanEightQuarters_returnsNull', () {
        // arrange
        final sut = quartersNewestFirst(List<double>.filled(7, 100));

        // act & assert
        expect(sut.trailingTwelveMonthsGrowth(), isNull);
      });

      test('trailingTwelveMonthsGrowth_positiveBase_returnsNumericPercentage', () {
        // arrange — current 400 vs previous 200 -> +100%
        final sut = quartersNewestFirst([
          100, 100, 100, 100, // current TTM = 400
          50, 50, 50, 50, // previous TTM = 200
        ]);

        // act
        final result = sut.trailingTwelveMonthsGrowth();

        // assert
        expect(result?.outcome, TtmGrowthOutcome.numeric);
        expect(result?.percentage, closeTo(100.0, 1e-9));
      });

      test('trailingTwelveMonthsGrowth_nonPositiveBaseThenPositive_turnsPositive', () {
        // arrange — previous TTM negative, current TTM positive
        final sut = quartersNewestFirst([
          100, 100, 100, 100, // current TTM = 400
          -10, -10, -10, -10, // previous TTM = -40
        ]);

        // act
        final result = sut.trailingTwelveMonthsGrowth();

        // assert
        expect(result?.outcome, TtmGrowthOutcome.turnedPositive);
      });

      test('trailingTwelveMonthsGrowth_positiveBaseThenNegative_turnsNegative', () {
        // arrange — previous TTM positive, current TTM negative
        final sut = quartersNewestFirst([
          -5, -5, -5, -5, // current TTM = -20
          50, 50, 50, 50, // previous TTM = 200
        ]);

        // act
        final result = sut.trailingTwelveMonthsGrowth();

        // assert
        expect(result?.outcome, TtmGrowthOutcome.turnedNegative);
      });

      test('trailingTwelveMonthsGrowth_bothWindowsNonPositive_isNotMeaningful', () {
        // arrange
        final sut = quartersNewestFirst([
          -5, -5, -5, -5, // current TTM = -20
          -10, -10, -10, -10, // previous TTM = -40
        ]);

        // act
        final result = sut.trailingTwelveMonthsGrowth();

        // assert
        expect(result?.outcome, TtmGrowthOutcome.notMeaningful);
      });

      test('trailingTwelveMonthsGrowth_currentZeroWithPositiveBase_isNumeric', () {
        // arrange — current TTM exactly zero. Zero is treated as profit
        // (>= 0), so this stays numeric at -100% rather than turning negative.
        final sut = quartersNewestFirst([
          0, 0, 0, 0, // current TTM = 0
          50, 50, 50, 50, // previous TTM = 200
        ]);

        // act
        final result = sut.trailingTwelveMonthsGrowth();

        // assert
        expect(result?.outcome, TtmGrowthOutcome.numeric);
        expect(result?.percentage, closeTo(-100.0, 1e-9));
      });

      test('trailingTwelveMonthsGrowth_previousZeroThenPositive_turnsPositive', () {
        // arrange — previous TTM exactly zero. Zero is not a profit base
        // (> 0), so a positive current is a turn to positive, not numeric.
        final sut = quartersNewestFirst([
          100, 100, 100, 100, // current TTM = 400
          0, 0, 0, 0, // previous TTM = 0
        ]);

        // act
        final result = sut.trailingTwelveMonthsGrowth();

        // assert
        expect(result?.outcome, TtmGrowthOutcome.turnedPositive);
      });
    });
  });
}
