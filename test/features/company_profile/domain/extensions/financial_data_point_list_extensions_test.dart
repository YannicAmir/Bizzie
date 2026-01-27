import 'package:bizzie/features/company_profile/shared/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FinancialDataPointListX', () {
    test('averageValue_multiplePoints_returnsCorrectAverage', () {
      // arrange
      const points = [
        FinancialDataPoint(date: '2023-01-01', period: 'FY', value: 10.0),
        FinancialDataPoint(date: '2023-02-01', period: 'FY', value: 20.0),
        FinancialDataPoint(date: '2023-03-01', period: 'FY', value: 30.0),
      ];

      // act
      final result = points.averageValue;

      // assert
      expect(result, 20.0);
    });

    test('averageValue_singlePoint_returnsCorrectValue', () {
      // arrange
      const points = [
        FinancialDataPoint(date: '2023-01-01', period: 'FY', value: 15.5),
      ];

      // act
      final result = points.averageValue;

      // assert
      expect(result, 15.5);
    });

    test('averageValue_emptyList_returnsZero', () {
      // arrange
      final points = <FinancialDataPoint>[];

      // act
      final result = points.averageValue;

      // assert
      expect(result, 0.0);
    });

    test('averageValue_negativeValues_returnsCorrectAverage', () {
      // arrange
      const points = [
        FinancialDataPoint(date: '2023-01-01', period: 'FY', value: -10.0),
        FinancialDataPoint(date: '2023-02-01', period: 'FY', value: 10.0),
      ];

      // act
      final result = points.averageValue;

      // assert
      expect(result, 0.0);
    });

    test('getAverageOfLatest_sufficientData_returnsAverageOfTopN', () {
      // arrange
      const points = [
        FinancialDataPoint(
          date: '2024-01-01',
          period: 'FY',
          value: 30.0,
        ), // Latest
        FinancialDataPoint(date: '2022-01-01', period: 'FY', value: 10.0),
        FinancialDataPoint(
          date: '2023-01-01',
          period: 'FY',
          value: 20.0,
        ), // 2nd Latest
      ];

      // act
      // Should sort desc -> 2024 (30), 2023 (20), 2022 (10)
      // Take top 2 -> (30 + 20) / 2 = 25
      final result = points.getAverageOfLatest(2);

      // assert
      expect(result, 25.0);
    });

    test('getAverageOfLatest_exactDataCount_returnsFullAverage', () {
      // arrange
      const points = [
        FinancialDataPoint(date: '2024-01-01', period: 'FY', value: 30.0),
        FinancialDataPoint(date: '2023-01-01', period: 'FY', value: 10.0),
      ];

      // act
      final result = points.getAverageOfLatest(2);

      // assert
      expect(result, 20.0);
    });

    test('getAverageOfLatest_insufficientData_returnsNull', () {
      // arrange
      const points = [
        FinancialDataPoint(date: '2024-01-01', period: 'FY', value: 30.0),
      ];

      // act
      final result = points.getAverageOfLatest(3);

      // assert
      expect(result, isNull);
    });
  });
}
