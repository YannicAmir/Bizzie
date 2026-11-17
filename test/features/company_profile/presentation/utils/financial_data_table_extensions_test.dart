import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/financial_table_enums.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_data_table_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FinancialDataPointPresentationX', () {
    test('formatDate_periodEnum_returnsFormattedYear', () {
      // arrange
      const point = FinancialDataPoint(
        date: '2023-12-31',
        period: 'annual',
        value: 100,
      );

      // act
      final result = point.formatDate(FinancialDateFormat.period);

      // assert
      expect(result, '2023');
    });

    test('formatDate_quarterShortEnum_returnsQuarterAndYear', () {
      // arrange
      const point = FinancialDataPoint(
        date: '2023-03-31',
        period: 'Q1',
        value: 100,
      );

      // act
      final result = point.formatDate(FinancialDateFormat.quarterShort);

      // assert
      expect(result, 'Q1 | Mar. 31, 2023');
    });
  });

  group('FinancialDataPointListPresentationX', () {
    List<FinancialDataPoint> pointsFromNewestFirst(List<double> values) {
      return [
        for (var i = 0; i < values.length; i++)
          FinancialDataPoint(
            date: '${2100 - i}-01-01',
            period: 'FY',
            value: values[i],
          ),
      ];
    }

    test('calculateGrowthAtIndex_positiveToPositive_returnsNumericChange', () {
      // arrange
      final points = pointsFromNewestFirst([120, 100]);

      // act
      final result = points.calculateGrowthAtIndex(0);

      // assert
      expect(result.outcome, GrowthOutcome.numeric);
      expect(result.percent, closeTo(0.2, 1e-9));
    });

    test('calculateGrowthAtIndex_lastItem_returnsNone', () {
      // arrange
      final points = pointsFromNewestFirst([120]);

      // act & assert
      expect(points.calculateGrowthAtIndex(0).outcome, GrowthOutcome.none);
    });

    test('calculateGrowthAtIndex_zeroBase_returnsNone', () {
      // arrange — a zero prior period yields an undefined rate
      final points = pointsFromNewestFirst([120, 0]);

      // act & assert
      expect(points.calculateGrowthAtIndex(0).outcome, GrowthOutcome.none);
    });

    test('calculateGrowthAtIndex_positiveToNegative_turnsNegative', () {
      // arrange — swung from a profit into a loss
      final points = pointsFromNewestFirst([-1930, 104]);

      // act & assert
      expect(
        points.calculateGrowthAtIndex(0).outcome,
        GrowthOutcome.turnedNegative,
      );
    });

    test('calculateGrowthAtIndex_negativeToPositive_turnsPositive', () {
      // arrange — turned a loss into a profit
      final points = pointsFromNewestFirst([112, -23]);

      // act & assert
      expect(
        points.calculateGrowthAtIndex(0).outcome,
        GrowthOutcome.turnedPositive,
      );
    });

    test('calculateGrowthAtIndex_negativeToNegative_isNotMeaningful', () {
      // arrange — loss narrowed but still a loss
      final points = pointsFromNewestFirst([-23, -1930]);

      // act & assert
      expect(
        points.calculateGrowthAtIndex(0).outcome,
        GrowthOutcome.notMeaningful,
      );
    });
  });
}
