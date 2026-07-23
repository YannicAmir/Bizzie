import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/financial_table_enums.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_data_table_extensions.dart';
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

  group('GrowthPresentationX', () {
    Future<String> resolveFormattedPercent(
      WidgetTester tester,
      QuarterlyGrowth growth,
    ) async {
      late String result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              result = growth.formattedPercent(context);
              return const SizedBox();
            },
          ),
        ),
      );
      return result;
    }

    testWidgets('formattedPercent_numericPositive_returnsWithPlusSign', (
      tester,
    ) async {
      // arrange
      final growth = QuarterlyGrowth.numeric(0.052);

      // act
      final result = await resolveFormattedPercent(tester, growth);

      // assert
      expect(result, '+5.2%');
    });

    testWidgets('formattedPercent_none_returnsDash', (tester) async {
      final result = await resolveFormattedPercent(tester, QuarterlyGrowth.none);
      expect(result, '-');
    });

    testWidgets('formattedPercent_turnedPositive_returnsPos', (tester) async {
      final result = await resolveFormattedPercent(
        tester,
        QuarterlyGrowth.turnedPositive,
      );
      expect(result, 'Pos.');
    });

    testWidgets('formattedPercent_turnedNegative_returnsNeg', (tester) async {
      final result = await resolveFormattedPercent(
        tester,
        QuarterlyGrowth.turnedNegative,
      );
      expect(result, 'Neg.');
    });

    testWidgets('formattedPercent_numericNegative_returnsWithoutPlusSign', (
      tester,
    ) async {
      // arrange
      final growth = QuarterlyGrowth.numeric(-0.052);

      // act
      final result = await resolveFormattedPercent(tester, growth);

      // assert
      expect(result, '-5.2%');
    });

    testWidgets('formattedPercent_notMeaningful_returnsNm', (tester) async {
      final result = await resolveFormattedPercent(
        tester,
        QuarterlyGrowth.notMeaningful,
      );
      expect(result, 'N/M');
    });

    Future<Color> resolveColor(
      WidgetTester tester,
      QuarterlyGrowth growth, {
      bool isInverse = false,
      bool isNeutral = false,
    }) async {
      late Color result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              result = growth.getGrowthColor(
                context: context,
                isInverse: isInverse,
                isNeutral: isNeutral,
              );
              return const SizedBox();
            },
          ),
        ),
      );
      return result;
    }

    testWidgets('getGrowthColor_numericPositive_returnsGoodText', (
      tester,
    ) async {
      final result = await resolveColor(tester, QuarterlyGrowth.numeric(0.1));
      expect(result, AppColors.goodText);
    });

    testWidgets('getGrowthColor_numericNegative_returnsCriticalText', (
      tester,
    ) async {
      final result = await resolveColor(tester, QuarterlyGrowth.numeric(-0.1));
      expect(result, AppColors.criticalText);
    });

    testWidgets('getGrowthColor_turnedPositive_returnsGoodText', (
      tester,
    ) async {
      final result = await resolveColor(tester, QuarterlyGrowth.turnedPositive);
      expect(result, AppColors.goodText);
    });

    testWidgets('getGrowthColor_turnedNegative_returnsCriticalText', (
      tester,
    ) async {
      final result = await resolveColor(tester, QuarterlyGrowth.turnedNegative);
      expect(result, AppColors.criticalText);
    });

    testWidgets('getGrowthColor_notMeaningful_returnsNeutralSecondary', (
      tester,
    ) async {
      final result = await resolveColor(tester, QuarterlyGrowth.notMeaningful);
      expect(result, AppColors.textSecondary);
    });

    testWidgets('getGrowthColor_none_returnsSlate500', (tester) async {
      final result = await resolveColor(tester, QuarterlyGrowth.none);
      expect(result, AppColors.slate500);
    });

    testWidgets('getGrowthColor_numericZero_returnsTextPrimary', (
      tester,
    ) async {
      final result = await resolveColor(tester, QuarterlyGrowth.numeric(0));
      expect(result, AppColors.textPrimary);
    });

    testWidgets('getGrowthColor_numericNeutral_returnsTextPrimary', (
      tester,
    ) async {
      final result = await resolveColor(
        tester,
        QuarterlyGrowth.numeric(0.1),
        isNeutral: true,
      );
      expect(result, AppColors.textPrimary);
    });

    testWidgets('getGrowthColor_numericPositiveInverse_returnsCriticalText', (
      tester,
    ) async {
      final result = await resolveColor(
        tester,
        QuarterlyGrowth.numeric(0.1),
        isInverse: true,
      );
      expect(result, AppColors.criticalText);
    });

    testWidgets('getGrowthColor_numericNegativeInverse_returnsGoodText', (
      tester,
    ) async {
      final result = await resolveColor(
        tester,
        QuarterlyGrowth.numeric(-0.1),
        isInverse: true,
      );
      expect(result, AppColors.goodText);
    });

    testWidgets('getGrowthColor_turnedPositiveNeutral_returnsTextPrimary', (
      tester,
    ) async {
      final result = await resolveColor(
        tester,
        QuarterlyGrowth.turnedPositive,
        isNeutral: true,
      );
      expect(result, AppColors.textPrimary);
    });

    testWidgets('getGrowthColor_turnedPositiveInverse_returnsCriticalText', (
      tester,
    ) async {
      final result = await resolveColor(
        tester,
        QuarterlyGrowth.turnedPositive,
        isInverse: true,
      );
      expect(result, AppColors.criticalText);
    });

    testWidgets('getGrowthColor_turnedNegativeNeutral_returnsTextPrimary', (
      tester,
    ) async {
      final result = await resolveColor(
        tester,
        QuarterlyGrowth.turnedNegative,
        isNeutral: true,
      );
      expect(result, AppColors.textPrimary);
    });

    testWidgets('getGrowthColor_turnedNegativeInverse_returnsGoodText', (
      tester,
    ) async {
      final result = await resolveColor(
        tester,
        QuarterlyGrowth.turnedNegative,
        isInverse: true,
      );
      expect(result, AppColors.goodText);
    });
  });
}
