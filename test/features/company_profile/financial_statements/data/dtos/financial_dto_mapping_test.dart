import 'package:bizzie/features/company_profile/financial_statements/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FinancialDtoMappingTests', () {
    group('CashFlowStatementDto', () {
      test(
        'toFreeCashFlowDataPoint_validDataWithMultiplier_returnsScaledPoint',
        () {
          // arrange
          const dto = CashFlowStatementDto(
            date: '2023-01-01',
            period: 'FY',
            freeCashFlow: 100.0,
          );

          // act
          final point = dto.toFreeCashFlowDataPoint(multiplier: 2.0);

          // assert
          expect(point.value, 200.0);
          expect(point.date, '2023-01-01');
          expect(point.period, 'FY');
        },
      );

      test('toFreeCashFlowDataPoint_nullFields_returnsSafeDefaults', () {
        // arrange
        const dto = CashFlowStatementDto(
          date: null,
          period: null,
          freeCashFlow: null,
        );

        // act
        final point = dto.toFreeCashFlowDataPoint();

        // assert
        expect(point.value, 0.0);
        expect(point.date, '');
        expect(point.period, '');
      });

      test(
        'toFcpsDataPoint_validSharesAndMultiplier_returnsScaledPerShareValue',
        () {
          // arrange
          const dto = CashFlowStatementDto(freeCashFlow: 1000.0, date: '2023');

          // act
          final point = dto.toFcpsDataPoint(100.0, multiplier: 1.5);

          // assert
          expect(point.value, 15.0);
        },
      );

      test('toFcpsDataPoint_zeroShares_returnsZeroValue', () {
        // arrange
        const dto = CashFlowStatementDto(freeCashFlow: 1000.0);

        // act
        final point = dto.toFcpsDataPoint(0.0);

        // assert
        expect(point.value, 0.0);
      });

      test('toFcpsDataPoint_nullFreeCashFlow_returnsZeroValue', () {
        // arrange
        const dto = CashFlowStatementDto(freeCashFlow: null);

        // act
        final point = dto.toFcpsDataPoint(100.0);

        // assert
        expect(point.value, 0.0);
      });
    });

    group('IncomeStatementDto', () {
      test('toRevenueDataPoint_validData_returnsScaledPoint', () {
        // arrange
        const dto = IncomeStatementDto(revenue: 500.0, date: '2023');

        // act
        final point = dto.toRevenueDataPoint(multiplier: 1.1);

        // assert
        expect(point.value, 550.0);
      });

      test('toRevenueDataPoint_nullRevenue_returnsZeroValue', () {
        // arrange
        const dto = IncomeStatementDto(revenue: null);

        // act
        final point = dto.toRevenueDataPoint();

        // assert
        expect(point.value, 0.0);
      });

      test('toNetIncomeDataPoint_validData_returnsScaledPoint', () {
        // arrange
        const dto = IncomeStatementDto(netIncome: 300.0, date: '2023');

        // act
        final point = dto.toNetIncomeDataPoint(multiplier: 0.5);

        // assert
        expect(point.value, 150.0);
      });

      test('toEpsDataPoint_validData_returnsScaledPoint', () {
        // arrange
        const dto = IncomeStatementDto(epsDiluted: 2.5, date: '2023');

        // act
        final point = dto.toEpsDataPoint(multiplier: 2.0);

        // assert
        expect(point.value, 5.0);
      });
    });

    group('LegacyIncomeStatementDto', () {
      test('toWeightedAverageSharesDataPoint_validData_returnsDoubleValue', () {
        // arrange
        const dto = LegacyIncomeStatementDto(
          weightedAverageShsOutDil: 1000000,
          date: '2023',
        );

        // act
        final point = dto.toWeightedAverageSharesDataPoint();

        // assert
        expect(point.value, 1000000.0);
      });

      test('toWeightedAverageSharesDataPoint_nullShares_returnsZeroValue', () {
        // arrange
        const dto = LegacyIncomeStatementDto(weightedAverageShsOutDil: null);

        // act
        final point = dto.toWeightedAverageSharesDataPoint();

        // assert
        expect(point.value, 0.0);
      });
    });
  });
}
