import 'package:bizzie/features/company_profile/ai_reports/domain/enums/ai_report_form.dart';
import 'package:bizzie/features/company_profile/ai_reports/domain/extensions/financial_report_list_extensions.dart';
import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:flutter_test/flutter_test.dart';

const tMetric = FinancialMetric(
  amount: 1,
  changeAmount: 0,
  changePercent: 0,
  citationPage: 1,
);
const tDriverMetric = FinancialMetricWithDriver(
  amount: 1,
  changeAmount: 0,
  changePercent: 0,
  citationPage: 1,
);

FinancialReport tReport(
  String id,
  String formType, {
  DateTime? filingDate,
  DateTime? dateAnalyzed,
}) => FinancialReport(
  id: id,
  ticker: 'AAPL',
  dateAnalyzed: dateAnalyzed,
  filingDate: filingDate,
  formType: formType,
  summary: const ReportSummary(
    ticker: 'AAPL',
    forwardLooking: '',
    citationPage: 1,
    reportingCurrency: 'USD',
  ),
  balanceSheet: const ReportBalanceSheet(
    equity: tMetric,
    totalAssets: tMetric,
    totalLiabilities: tMetric,
  ),
  cashFlow: const ReportCashFlow(freeCashFlow: tDriverMetric),
  income: const ReportIncome(
    costOfRevenue: tMetric,
    eps: tMetric,
    netIncome: tDriverMetric,
    revenue: tDriverMetric,
    totalExpenses: tDriverMetric,
  ),
  stockActivity: const ReportStockActivity(citationPage: 1),
);

void main() {
  group('FinancialReportListX', () {
    test('forForm_mixedForms_returnsOnlyMatchingForm', () {
      // arrange
      final reports = [
        tReport('k', '10-K'),
        tReport('q', '10-Q'),
        tReport('e', '8-K'),
      ];

      // act
      final result = reports.forForm(AiReportForm.tenQ);

      // assert
      expect(result.map((r) => r.id), ['q']);
    });

    test('forForm_amendedFilings_groupsWithBaseForm', () {
      // arrange
      final reports = [
        tReport('underscore', '10-K_A'),
        tReport('slash', '10-K/A'),
        tReport('other', '18-K'),
      ];

      // act
      final tenK = reports.forForm(AiReportForm.tenK);
      final eightK = reports.forForm(AiReportForm.eightK);

      // assert
      expect(tenK.map((r) => r.id), containsAll(['underscore', 'slash']));
      expect(eightK, isEmpty);
    });

    test('forForm_unorderedDates_sortsNewestFirstWithUndatedLast', () {
      // arrange
      final reports = [
        tReport('old', '10-K', filingDate: DateTime(2023)),
        tReport('undated', '10-K'),
        tReport('new', '10-K', filingDate: DateTime(2025)),
        tReport('analyzed', '10-K', dateAnalyzed: DateTime(2024)),
      ];

      // act
      final result = reports.forForm(AiReportForm.tenK);

      // assert
      expect(result.map((r) => r.id), ['new', 'analyzed', 'old', 'undated']);
    });
  });
}
