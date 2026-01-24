import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/presentation/utils/metric_summary_presentation_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MetricSummaryListX', () {
    test('getAsOfPrefix_emptyListWithLastUpdated_returnsFormattedPrefix', () {
      // arrange
      final points = <FinancialDataPoint>[];
      final lastUpdated = DateTime(2023, 10, 27);

      // act
      final result = points.getAsOfPrefix(lastUpdated);

      // assert
      expect(result, 'As of Oct. 27, 2023 | ');
    });

    test('getAsOfPrefix_emptyListNoLastUpdated_returnsEmptyString', () {
      // arrange
      final points = <FinancialDataPoint>[];

      // act
      final result = points.getAsOfPrefix(null);

      // assert
      expect(result, '');
    });

    test('getAsOfPrefix_nonEmptyList_returnsLatestPointDate', () {
      // arrange
      final points = [
        const FinancialDataPoint(date: '2023-01-01', period: 'FY', value: 10),
        const FinancialDataPoint(date: '2023-12-31', period: 'FY', value: 20),
      ];

      // act
      final result = points.getAsOfPrefix(null);

      // assert
      expect(result, 'As of Dec. 31, 2023 | ');
    });

    test('getDynamicAverageColumn_has5YData_returns5YAverage', () {
      // arrange
      final points = List.generate(
        5,
        (i) =>
            FinancialDataPoint(date: '202$i-01-01', period: 'FY', value: 10.0),
      );

      // act
      final result = points.getDynamicAverageColumn('Metric');

      // assert
      expect(result?.label, '5Y Avg. Metric');
      expect(result?.value, '10.00');
    });

    test('getDynamicAverageColumn_has3YDataOnly_returns3YAverage', () {
      // arrange
      final points = List.generate(
        3,
        (i) =>
            FinancialDataPoint(date: '202$i-01-01', period: 'FY', value: 10.0),
      );

      // act
      final result = points.getDynamicAverageColumn('Metric');

      // assert
      expect(result?.label, '3Y Avg. Metric');
      expect(result?.value, '10.00');
    });

    test('getDynamicAverageColumn_insufficientData_returnsNull', () {
      // arrange
      final points = List.generate(
        2,
        (i) =>
            FinancialDataPoint(date: '202$i-01-01', period: 'FY', value: 10.0),
      );

      // act
      final result = points.getDynamicAverageColumn('Metric');

      // assert
      expect(result, isNull);
    });
  });

  group('MetricSummaryDoubleX', () {
    test('formattedRatioValue_doubleValue_returnsTwoDecimalPlaces', () {
      // arrange
      const value = 15.1234;

      // act
      final result = value.formattedRatioValue;

      // assert
      expect(result, '15.12');
    });

    test('formattedRatioBadge_positiveValue_returnsPlusSignAndOneDecimal', () {
      // arrange
      const value = 5.234;

      // act
      final result = value.formattedRatioBadge;

      // assert
      expect(result, '+5.2%');
    });

    test('formattedRatioBadge_negativeValue_returnsDashSignAndOneDecimal', () {
      // arrange
      const value = -5.234;

      // act
      final result = value.formattedRatioBadge;

      // assert
      expect(result, '-5.2%');
    });
  });

  group('MetricSummarySubtitleHelper', () {
    test('getSubtitle_positiveDelta_returnsIncreasedString', () {
      // arrange
      const asOfPrefix = 'As of Oct. 27, 2023 | ';
      const isPositive = true;
      const absoluteDelta = 1.25;
      const referenceLabel = 'last year';

      // act
      final result = MetricSummarySubtitleHelper.getSubtitle(
        asOfPrefix: asOfPrefix,
        isPositive: isPositive,
        absoluteDelta: absoluteDelta,
        referenceLabel: referenceLabel,
      );

      // assert
      expect(result, 'As of Oct. 27, 2023 | Increased by 1.25 since last year');
    });

    test('getSubtitle_negativeDelta_returnsDecreasedString', () {
      // arrange
      const asOfPrefix = 'As of Oct. 27, 2023 | ';
      const isPositive = false;
      const absoluteDelta = 0.5;
      const referenceLabel = 'last quarter';

      // act
      final result = MetricSummarySubtitleHelper.getSubtitle(
        asOfPrefix: asOfPrefix,
        isPositive: isPositive,
        absoluteDelta: absoluteDelta,
        referenceLabel: referenceLabel,
      );

      // assert
      expect(
        result,
        'As of Oct. 27, 2023 | Decreased by 0.50 since last quarter',
      );
    });
  });
}
