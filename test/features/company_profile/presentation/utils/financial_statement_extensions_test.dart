import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/utils/financial_statement_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FinancialStatementPresentationX', () {
    test('IncomeStatement_formattedPeriod_returnsPeriodAndDate', () {
      const statement = IncomeStatement(
        date: '2023-09-30',
        symbol: 'AAPL',
        reportedCurrency: 'USD',
        period: 'FY',
        revenue: 0,
        grossProfit: 0,
        operatingIncome: 0,
        netIncome: 0,
        eps: 0,
        ebitda: 0,
        costOfRevenue: 0,
        operatingExpenses: 0,
        costAndExpenses: 0,
      );
      expect(statement.formattedPeriod, 'FY | Sep. 30, 2023');
    });

    test('BalanceSheet_formattedPeriod_returnsPeriodAndDate', () {
      const statement = BalanceSheet(
        date: '2023-09-30',
        symbol: 'AAPL',
        reportedCurrency: 'USD',
        period: 'Q3',
        totalAssets: 0,
        totalLiabilities: 0,
        totalEquity: 0,
        cashAndShortTermInvestments: 0,
        totalDebt: 0,
        totalCurrentAssets: 0,
        totalNonCurrentAssets: 0,
        totalCurrentLiabilities: 0,
        totalNonCurrentLiabilities: 0,
        longTermDebt: 0,
        shortTermDebt: 0,
      );
      expect(statement.formattedPeriod, 'Q3 | Sep. 30, 2023');
    });

    test('CashFlowStatement_formattedPeriod_returnsPeriodAndDate', () {
      const statement = CashFlowStatement(
        date: '2023-09-30',
        symbol: 'AAPL',
        reportedCurrency: 'USD',
        period: 'FY',
        operatingCashFlow: 0,
        investingCashFlow: 0,
        financingCashFlow: 0,
        capitalExpenditure: 0,
        freeCashFlow: 0,
        dividendsPaid: 0,
        cashAtBeginningOfPeriod: 0,
        cashAtEndOfPeriod: 0,
      );
      expect(statement.formattedPeriod, 'FY | Sep. 30, 2023');
    });

    test('handlesEmptyPeriod_returnsOnlyDate', () {
      const statement = IncomeStatement(
        date: '2023-09-30',
        symbol: 'AAPL',
        reportedCurrency: 'USD',
        period: '',
        revenue: 0,
        grossProfit: 0,
        operatingIncome: 0,
        netIncome: 0,
        eps: 0,
        ebitda: 0,
        costOfRevenue: 0,
        operatingExpenses: 0,
        costAndExpenses: 0,
      );
      expect(statement.formattedPeriod, 'Sep. 30, 2023');
    });
  });
}
