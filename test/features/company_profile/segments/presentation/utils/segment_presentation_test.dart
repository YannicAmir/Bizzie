import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/segments/presentation/utils/segment_presentation.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

const tLocale = 'en_US';
const tCurrency = 'USD';

const tCurrentSegment = RevenueSegment(
  date: '2025-09-27',
  fiscalYear: 2025,
  period: 'FY',
  reportedCurrency: tCurrency,
  data: {'iPhone': 200.0, 'Mac': 50.0, 'Legacy': 0.0},
);

const tPreviousSegment = RevenueSegment(
  date: '2024-09-28',
  fiscalYear: 2024,
  period: 'FY',
  reportedCurrency: tCurrency,
  data: {'iPhone': 180.0, 'Mac': 60.0, 'iPod': 5.0},
);

const tColorIndices = {'iPhone': 0, 'Mac': 1, 'iPod': 2, 'Legacy': 3};

void main() {
  group('SegmentPresentation', () {
    group('colorFor', () {
      test('colorFor_knownTopic_returnsPooledColorAtIndex', () {
        // arrange - tColorIndices maps Mac to index 1

        // act
        final color = SegmentPresentation.colorFor('Mac', tColorIndices);

        // assert
        expect(color, AppColors.chartCategoricalPool[1]);
      });

      test('colorFor_unknownTopic_fallsBackToFirstPoolColor', () {
        // arrange - topic missing from tColorIndices

        // act
        final color = SegmentPresentation.colorFor('Unknown', tColorIndices);

        // assert
        expect(color, AppColors.chartCategoricalPool.first);
      });

      test('colorFor_indexBeyondPoolSize_wrapsAroundPool', () {
        // arrange
        final poolSize = AppColors.chartCategoricalPool.length;
        final indices = {'Overflow': poolSize + 2};

        // act
        final color = SegmentPresentation.colorFor('Overflow', indices);

        // assert
        expect(color, AppColors.chartCategoricalPool[2]);
      });
    });

    group('chartData', () {
      test(
        'chartData_segmentWithZeroValues_filtersNonPositiveAndSortsDescending',
        () {
          // arrange - tCurrentSegment contains a zero-valued topic

          // act
          final data = SegmentPresentation.chartData(
            tCurrentSegment,
            tColorIndices,
          );

          // assert
          expect(data.map((e) => e.label), ['iPhone', 'Mac']);
          expect(data.map((e) => e.value), [200.0, 50.0]);
          expect(data.first.color, AppColors.chartCategoricalPool[0]);
          expect(data.last.color, AppColors.chartCategoricalPool[1]);
        },
      );

      test('chartData_allValuesNonPositive_returnsEmptyList', () {
        // arrange
        const segment = RevenueSegment(
          date: '2025-09-27',
          fiscalYear: 2025,
          period: 'FY',
          reportedCurrency: tCurrency,
          data: {'Legacy': 0.0, 'Writedown': -5.0},
        );

        // act
        final data = SegmentPresentation.chartData(segment, tColorIndices);

        // assert
        expect(data, isEmpty);
      });
    });

    group('tableRows', () {
      test(
        'tableRows_currentAndPrevious_buildsUnionRowsWithGrowthAndColors',
        () {
          // arrange - union of current and previous topics ordered by value

          // act
          final rows = SegmentPresentation.tableRows(
            current: tCurrentSegment,
            previous: tPreviousSegment,
            colorIndices: tColorIndices,
            currency: tCurrency,
            locale: tLocale,
          );

          // assert
          expect(rows.map((r) => r.metric), [
            'iPhone',
            'Mac',
            'Legacy',
            'iPod',
          ]);

          final iPhoneRow = rows[0];
          expect(
            iPhoneRow.amount,
            CurrencyFormatter.formatCompact(200.0, tCurrency, locale: tLocale),
          );
          expect(
            iPhoneRow.secondaryValue,
            CurrencyFormatter.formatCompact(180.0, tCurrency, locale: tLocale),
          );
          expect(iPhoneRow.growth, '+11.1%');
          expect(iPhoneRow.growthColor, AppColors.successText);
          expect(iPhoneRow.indicatorColor, AppColors.chartCategoricalPool[0]);

          final macRow = rows[1];
          expect(macRow.growth, '-16.7%');
          expect(macRow.growthColor, AppColors.criticalText);

          final iPodRow = rows[3];
          expect(iPodRow.amount, '-');
          expect(iPodRow.growth, '-');
          expect(iPodRow.growthColor, AppColors.textPrimary);
          expect(iPodRow.indicatorColor, AppColors.chartCategoricalPool[2]);
        },
      );

      test('tableRows_previousMissing_showsPlaceholdersForComparison', () {
        // arrange
        const segment = RevenueSegment(
          date: '2026-03-28',
          fiscalYear: 2026,
          period: 'Q2',
          reportedCurrency: tCurrency,
          data: {'iPhone': 90.0},
        );

        // act
        final rows = SegmentPresentation.tableRows(
          current: segment,
          previous: null,
          colorIndices: tColorIndices,
          currency: tCurrency,
          locale: tLocale,
        );

        // assert
        expect(rows.length, 1);
        expect(rows.first.metric, 'iPhone');
        expect(rows.first.secondaryValue, '-');
        expect(rows.first.growth, '-');
      });

      test('tableRows_bothSegmentsNull_returnsEmptyList', () {
        // arrange - nothing to display

        // act
        final rows = SegmentPresentation.tableRows(
          current: null,
          previous: null,
          colorIndices: tColorIndices,
          currency: tCurrency,
          locale: tLocale,
        );

        // assert
        expect(rows, isEmpty);
      });
    });
  });
}
