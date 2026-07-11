import 'package:bizzie/features/company_profile/pe_ratio/domain/models/pe_ratio.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/services/pe_ratio_metrics_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PeRatioMetricsService sut;

  setUp(() {
    sut = PeRatioMetricsService();
  });

  const tTicker = 'AAPL';
  const tPeriod = 'FY';

  PeRatio ratio(String date, double value) => PeRatio(
    symbol: tTicker,
    date: date,
    period: tPeriod,
    priceToEarningsRatio: value,
  );

  FinancialDataPoint point(String date, double value) =>
      FinancialDataPoint(date: date, period: tPeriod, value: value);

  group('PeRatioMetricsService', () {
    group('extractSortedDataPoints', () {
      test('extractSortedDataPoints_unsortedRatios_returnsPointsSortedByDateAscending', () {
        // arrange
        final ratios = [
          ratio('2023-09-30', 28.0),
          ratio('2019-09-28', 18.0),
          ratio('2021-09-25', 24.0),
        ];

        // act
        final result = sut.extractSortedDataPoints(ratios);

        // assert
        expect(result.map((p) => p.date).toList(), [
          '2019-09-28',
          '2021-09-25',
          '2023-09-30',
        ]);
      });

      test('extractSortedDataPoints_validRatios_mapsAllFieldsToDataPoints', () {
        // arrange
        final ratios = [ratio('2023-09-30', 28.0)];

        // act
        final result = sut.extractSortedDataPoints(ratios);

        // assert
        expect(result, [point('2023-09-30', 28.0)]);
      });

      test('extractSortedDataPoints_emptyRatios_returnsEmptyList', () {
        // arrange
        final ratios = <PeRatio>[];

        // act
        final result = sut.extractSortedDataPoints(ratios);

        // assert
        expect(result, isEmpty);
      });
    });

    group('findReferencePoint', () {
      test('findReferencePoint_allPointsWithinWindow_returnsFirstPoint', () {
        // arrange
        final sortedPoints = [
          point('2021-09-25', 24.0),
          point('2022-09-24', 22.0),
          point('2024-09-28', 30.0),
        ];

        // act
        final result = sut.findReferencePoint(sortedPoints, sortedPoints.last);

        // assert
        expect(result, sortedPoints.first);
      });

      test('findReferencePoint_pointsOlderThanWindow_returnsFirstPointWithinWindow', () {
        // arrange
        final sortedPoints = [
          point('2010-09-25', 12.0),
          point('2021-09-25', 24.0),
          point('2024-09-28', 30.0),
        ];

        // act
        final result = sut.findReferencePoint(sortedPoints, sortedPoints.last);

        // assert
        expect(result, point('2021-09-25', 24.0));
      });

      test('findReferencePoint_pointExactlyOnCutoffDate_returnsCutoffPoint', () {
        // arrange
        final sortedPoints = [
          point('2010-09-28', 12.0),
          point('2019-09-28', 18.0),
          point('2024-09-28', 30.0),
        ];

        // act
        final result = sut.findReferencePoint(sortedPoints, sortedPoints.last);

        // assert
        expect(result, point('2019-09-28', 18.0));
      });

      test('findReferencePoint_unparseableCurrentDate_returnsFirstPoint', () {
        // arrange
        final sortedPoints = [
          point('2010-09-25', 12.0),
          point('2024-09-28', 30.0),
        ];
        final currentPoint = point('not-a-date', 30.0);

        // act
        final result = sut.findReferencePoint(sortedPoints, currentPoint);

        // assert
        expect(result, sortedPoints.first);
      });

      test('findReferencePoint_singlePoint_returnsThatPoint', () {
        // arrange
        final sortedPoints = [point('2024-09-28', 30.0)];

        // act
        final result = sut.findReferencePoint(sortedPoints, sortedPoints.first);

        // assert
        expect(result, sortedPoints.first);
      });

      test('findReferencePoint_unparseablePointDateInList_skipsInvalidAndSelectsNextValid', () {
        // arrange
        final sortedPoints = [
          point('2010-09-25', 12.0),
          point('not-a-date', 15.0),
          point('2021-09-25', 24.0),
          point('2024-09-28', 30.0),
        ];

        // act
        final result = sut.findReferencePoint(sortedPoints, sortedPoints.last);

        // assert
        expect(result, point('2021-09-25', 24.0));
      });
    });

    group('calculateGrowth', () {
      test('calculateGrowth_positiveDelta_returnsDeltaAndPercentage', () {
        // arrange
        const currentValue = 30.0;
        const referenceValue = 20.0;

        // act
        final result = sut.calculateGrowth(currentValue, referenceValue);

        // assert
        expect(result.delta, 10.0);
        expect(result.percentage, 50.0);
      });

      test('calculateGrowth_negativeDelta_returnsNegativePercentage', () {
        // arrange
        const currentValue = 20.0;
        const referenceValue = 30.0;

        // act
        final result = sut.calculateGrowth(currentValue, referenceValue);

        // assert
        expect(result.delta, -10.0);
        expect(result.percentage, ((20.0 - 30.0) / 30.0) * 100);
      });

      test('calculateGrowth_referenceBelowEpsilon_returnsZeroPercentage', () {
        // arrange
        const currentValue = 30.0;
        const referenceValue = 0.0;

        // act
        final result = sut.calculateGrowth(currentValue, referenceValue);

        // assert
        expect(result.delta, 30.0);
        expect(result.percentage, 0.0);
      });

      test('calculateGrowth_negativeReference_usesAbsoluteReferenceInDenominator', () {
        // arrange
        const currentValue = 5.0;
        const referenceValue = -10.0;

        // act
        final result = sut.calculateGrowth(currentValue, referenceValue);

        // assert
        expect(result.delta, 15.0);
        expect(result.percentage, 150.0);
      });
    });
  });
}
