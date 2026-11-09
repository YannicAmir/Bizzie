import 'package:bizzie/features/company_profile/ai_reports/domain/enums/ai_report_form.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_state.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/extensions/company_ai_reports_state_extensions.dart';
import 'package:bizzie/core/domain/models/company_filings.dart';
import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/core/domain/models/weekly_report.dart';
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

FinancialReport tReport(String id, String formType, DateTime? filingDate) =>
    FinancialReport(
      id: id,
      ticker: 'AAPL',
      dateAnalyzed: null,
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

SecFiling tFiling(
  String id,
  String formType,
  DateTime? filingDate, {
  bool isEarnings = false,
}) => SecFiling(
  id: id,
  symbol: 'AAPL',
  companyName: 'Apple Inc.',
  filingDate: filingDate,
  formType: formType,
  link: 'https://sec.gov/$id',
  summary: 'Summary',
  isEarnings: isEarnings,
  createdAt: null,
  analyzedAt: null,
);

void main() {
  final tDate = DateTime(2025, 10, 31);

  group('CompanyFilingsAiReportsX', () {
    test('aiReportFilings_matchingFiling_pairsReportWithFiling', () {
      // arrange
      final report = tReport('r', '10-K', tDate);
      final filing = tFiling('f', '10-K', tDate);
      final sut = CompanyFilings(reports: [report], filings: [filing]);

      // act
      final result = sut.aiReportFilings(AiReportForm.tenK);

      // assert
      expect(result.single.filing, filing);
      expect(result.single.report, report);
    });

    test('aiReportFilings_multipleReports_returnsNewestFirst', () {
      // arrange
      final older = DateTime(2024, 10, 31);
      final sut = CompanyFilings(
        reports: [tReport('old', '10-Q', older), tReport('new', '10-Q', tDate)],
        filings: [tFiling('a', '10-Q', older), tFiling('b', '10-Q', tDate)],
      );

      // act
      final result = sut.aiReportFilings(AiReportForm.tenQ);

      // assert
      expect(result.map((vm) => vm.report?.id), ['new', 'old']);
    });

    test('aiReportFilings_filingWithoutReport_isExcluded', () {
      // arrange
      final sut = CompanyFilings(filings: [tFiling('f', '10-K', tDate)]);

      // act
      final result = sut.aiReportFilings(AiReportForm.tenK);

      // assert
      expect(result, isEmpty);
    });

    test('aiReportFilings_reportWithoutFiling_isExcluded', () {
      // arrange
      final sut = CompanyFilings(
        reports: [tReport('r', '10-K', tDate)],
        filings: [tFiling('f', '10-K', DateTime(2024))],
      );

      // act
      final result = sut.aiReportFilings(AiReportForm.tenK);

      // assert
      expect(result, isEmpty);
    });

    test('aiReportFilings_sameDayEightKs_prefersEarningsFiling', () {
      // arrange
      final earnings = tFiling('earnings', '8-K', tDate, isEarnings: true);
      final sut = CompanyFilings(
        reports: [tReport('r', '8-K', tDate)],
        filings: [tFiling('other', '8-K', tDate), earnings],
      );

      // act
      final result = sut.aiReportFilings(AiReportForm.eightK);

      // assert
      expect(result.single.filing, earnings);
    });

    test('aiReportFilings_amendedReport_matchesSlashFormType', () {
      // arrange
      final amended = tFiling('amended', '10-K/A', tDate);
      final sut = CompanyFilings(
        reports: [tReport('r', '10-K_A', tDate)],
        filings: [tFiling('original', '10-K', tDate), amended],
      );

      // act
      final result = sut.aiReportFilings(AiReportForm.tenK);

      // assert
      expect(result.single.filing, amended);
    });
  });

  group('CompanyAiReportsLoadedX', () {
    for (final (form, label) in [
      (AiReportForm.tenK, '10-K'),
      (AiReportForm.tenQ, '10-Q'),
      (AiReportForm.eightK, '8-K'),
    ]) {
      test('emptyMessage_${form.name}_namesFormAndTicker', () {
        // arrange
        final state =
            CompanyAiReportsState.loaded(
                  ticker: 'AAPL',
                  companyFilings: const CompanyFilings(),
                  summaryButtonLabel: 'Summarize',
                  selectedForm: form,
                )
                as CompanyAiReportsLoaded;

        // act
        final message = state.emptyMessage;

        // assert
        expect(message, 'No AI $label reports available for AAPL');
      });
    }

    CompanyAiReportsLoaded recapsState(AiReportForm form) =>
        CompanyAiReportsState.loaded(
              ticker: 'AAPL',
              companyFilings: const CompanyFilings(
                weeklyReports: [WeeklyReport(id: '2026-01-09')],
              ),
              summaryButtonLabel: 'Summarize',
              selectedForm: form,
            )
            as CompanyAiReportsLoaded;

    test('emptyMessage_recaps_namesRecapsAndTicker', () {
      // act
      final message = recapsState(AiReportForm.recaps).emptyMessage;

      // assert
      expect(message, 'No recaps available for AAPL');
    });

    test('visibleRecaps_recapsSelected_returnsWeeklyReports', () {
      // act
      final result = recapsState(AiReportForm.recaps).visibleRecaps;

      // assert
      expect(result.map((r) => r.id), ['2026-01-09']);
    });

    test('visibleRecaps_filingFormSelected_returnsEmpty', () {
      // act
      final result = recapsState(AiReportForm.tenK).visibleRecaps;

      // assert
      expect(result, isEmpty);
    });

    test('visibleFilings_recapsSelected_returnsEmpty', () {
      // act
      final result = recapsState(AiReportForm.recaps).visibleFilings;

      // assert
      expect(result, isEmpty);
    });
  });
}
