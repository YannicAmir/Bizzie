import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/presentation/enums/financial_table_enums.dart';
import 'package:bizzie/features/company_profile/presentation/utils/financial_data_table_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FinancialDataPointPresentationX', () {
    testWidgets('formatCurrency_usdValue_returnsCompactCurrencyString', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // arrange
              const point = FinancialDataPoint(
                date: '2023-01-01',
                period: 'FY',
                value: 1234567.89,
              );

              // act
              final result = point.formatCurrency(
                context: context,
                currency: 'USD',
                isPercentage: false,
              );

              // assert
              expect(result, contains('1.23'));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('formatCurrency_percentageValue_returnsPercentageString', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // arrange
              const point = FinancialDataPoint(
                date: '2023-01-01',
                period: 'FY',
                value: 0.12345,
              );

              // act
              final result = point.formatCurrency(
                context: context,
                currency: '',
                isPercentage: true,
              );

              // assert
              expect(result, contains('12.35%'));
              return const SizedBox();
            },
          ),
        ),
      );
    });

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
    test('calculateGrowthAtIndex_validPoints_returnsPercentageChange', () {
      // arrange
      const points = [
        FinancialDataPoint(date: '2024-01-01', period: 'FY', value: 120),
        FinancialDataPoint(date: '2023-01-01', period: 'FY', value: 100),
      ];

      // act
      final result = points.calculateGrowthAtIndex(0);

      // assert
      expect(result, 0.2);
    });

    test('calculateGrowthAtIndex_lastItem_returnsNull', () {
      // arrange
      const points = [
        FinancialDataPoint(date: '2024-01-01', period: 'FY', value: 120),
      ];

      // act
      final result = points.calculateGrowthAtIndex(0);

      // assert
      expect(result, isNull);
    });
  });

  group('GrowthPresentationX', () {
    test('formattedPercent_positiveDouble_returnsWithPlusSign', () {
      // arrange
      const double growth = 0.052;

      // act
      final result = growth.formattedPercent;

      // assert
      expect(result, '+5.2%');
    });

    test('formattedPercent_nullDouble_returnsDash', () {
      // arrange
      const double? growth = null;

      // act
      final result = growth.formattedPercent;

      // assert
      expect(result, '-');
    });

    testWidgets('getGrowthColor_positiveValue_returnsGoodText', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // arrange
              const double growth = 0.1;

              // act
              final result = growth.getGrowthColor(
                context: context,
                isInverse: false,
                isNeutral: false,
              );

              // assert
              expect(result, AppColors.goodText);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('getGrowthColor_negativeValue_returnsCriticalText', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // arrange
              const double growth = -0.1;

              // act
              final result = growth.getGrowthColor(
                context: context,
                isInverse: false,
                isNeutral: false,
              );

              // assert
              expect(result, AppColors.criticalText);
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
