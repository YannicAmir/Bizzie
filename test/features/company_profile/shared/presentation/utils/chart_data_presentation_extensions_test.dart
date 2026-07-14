import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/chart_data_presentation_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

const tPointOldest = FinancialDataPoint(
  date: '2022-12-31',
  period: 'FY',
  value: 10.5,
);
const tPointMiddle = FinancialDataPoint(
  date: '2023-12-31',
  period: 'FY',
  value: 12.25,
);
const tPointNewest = FinancialDataPoint(
  date: '2024-12-31',
  period: 'FY',
  value: 15.75,
);
const tQuarterlyPoint = FinancialDataPoint(
  date: '2024-03-31',
  period: 'Q1',
  value: 3.5,
);
const tInvalidDatePoint = FinancialDataPoint(
  date: 'not-a-date',
  period: 'FY',
  value: 1.0,
);

void main() {
  group('ChartDataListX', () {
    group('toChartDataReversed', () {
      test('toChartDataReversed_annualPoints_returnsReversedOrderWithYearLabels',
          () {
        // arrange
        const points = [tPointNewest, tPointMiddle, tPointOldest];

        // act
        final result = points.toChartDataReversed(isAnnual: true);

        // assert
        expect(result, const [
          ChartDataPoint(label: '2022', value: 10.5),
          ChartDataPoint(label: '2023', value: 12.25),
          ChartDataPoint(label: '2024', value: 15.75),
        ]);
      });

      test(
          'toChartDataReversed_quarterlyPoint_returnsMonthYearShortLabel',
          () {
        // arrange
        const points = [tQuarterlyPoint];

        // act
        final result = points.toChartDataReversed(isAnnual: false);

        // assert
        expect(result, const [
          ChartDataPoint(label: "Mar. 31, '24", value: 3.5),
        ]);
      });

      test('toChartDataReversed_emptyList_returnsEmptyList', () {
        // arrange
        const points = <FinancialDataPoint>[];

        // act
        final result = points.toChartDataReversed(isAnnual: true);

        // assert
        expect(result, isEmpty);
      });

      test('toChartDataReversed_invalidDate_returnsRawDateStringAsLabel', () {
        // arrange
        const points = [tInvalidDatePoint];

        // act
        final result = points.toChartDataReversed(isAnnual: true);

        // assert
        expect(result, const [
          ChartDataPoint(label: 'not-a-date', value: 1.0),
        ]);
      });
    });

    group('toChartDataSortedByDate', () {
      test(
          'toChartDataSortedByDate_unsortedPoints_returnsChronologicalChartPoints',
          () {
        // arrange
        const points = [tPointMiddle, tPointNewest, tPointOldest];

        // act
        final result = points.toChartDataSortedByDate(isAnnual: true);

        // assert
        expect(result, const [
          ChartDataPoint(label: '2022', value: 10.5),
          ChartDataPoint(label: '2023', value: 12.25),
          ChartDataPoint(label: '2024', value: 15.75),
        ]);
      });

      test('toChartDataSortedByDate_unsortedPoints_doesNotMutateOriginalList',
          () {
        // arrange
        final points = [tPointNewest, tPointOldest, tPointMiddle];

        // act
        points.toChartDataSortedByDate(isAnnual: true);

        // assert
        expect(points, const [tPointNewest, tPointOldest, tPointMiddle]);
      });

      test(
          'toChartDataSortedByDate_quarterlyPoint_returnsMonthYearShortLabel',
          () {
        // arrange
        const points = [tQuarterlyPoint];

        // act
        final result = points.toChartDataSortedByDate(isAnnual: false);

        // assert
        expect(result, const [
          ChartDataPoint(label: "Mar. 31, '24", value: 3.5),
        ]);
      });

      test('toChartDataSortedByDate_emptyList_returnsEmptyList', () {
        // arrange
        const points = <FinancialDataPoint>[];

        // act
        final result = points.toChartDataSortedByDate(isAnnual: false);

        // assert
        expect(result, isEmpty);
      });
    });
  });
}
