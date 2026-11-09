import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:bizzie/shared/widgets/cards/metric_card.dart';
import 'package:bizzie/shared/widgets/modals/report_summary_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _zero = FinancialMetric(
  amount: 0,
  changeAmount: 0,
  changePercent: 0,
  citationPage: 1,
);
const _zeroWithDriver = FinancialMetricWithDriver(
  amount: 0,
  changeAmount: 0,
  changePercent: 0,
  citationPage: 1,
);
const _value = FinancialMetric(
  amount: 100,
  changeAmount: 10,
  changePercent: 10,
  citationPage: 1,
);
const _valueWithDriver = FinancialMetricWithDriver(
  amount: 100,
  changeAmount: 10,
  changePercent: 10,
  citationPage: 1,
);

const _zeroIncome = ReportIncome(
  costOfRevenue: _zero,
  eps: _zero,
  netIncome: _zeroWithDriver,
  revenue: _zeroWithDriver,
  totalExpenses: _zeroWithDriver,
);
const _zeroBalanceSheet = ReportBalanceSheet(
  equity: _zero,
  totalAssets: _zero,
  totalLiabilities: _zero,
);
const _zeroCashFlow = ReportCashFlow(freeCashFlow: _zeroWithDriver);

FinancialReport _report({
  ReportIncome income = _zeroIncome,
  ReportBalanceSheet balanceSheet = _zeroBalanceSheet,
  ReportCashFlow cashFlow = _zeroCashFlow,
}) => FinancialReport(
  id: 'r',
  ticker: 'AXP',
  dateAnalyzed: null,
  filingDate: DateTime(2026, 1, 30),
  formType: '8-K',
  summary: const ReportSummary(
    ticker: 'AXP',
    forwardLooking: '',
    citationPage: 1,
    reportingCurrency: 'USD',
  ),
  balanceSheet: balanceSheet,
  cashFlow: cashFlow,
  income: income,
  stockActivity: const ReportStockActivity(citationPage: 1),
);

void main() {
  Future<void> pumpModal(WidgetTester tester, FinancialReport report) async {
    tester.view.physicalSize = const Size(1200, 6000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ReportSummaryModal(report: report)),
      ),
    );
  }

  group('ReportSummaryModal', () {
    testWidgets('build_allMetricsZero_hidesCardsAndSectionHeaders', (
      tester,
    ) async {
      // act
      await pumpModal(tester, _report());

      // assert
      expect(find.byType(MetricCard), findsNothing);
      expect(find.text('Operations'), findsNothing);
      expect(find.text('Balance Sheet'), findsNothing);
      expect(find.text('Cash Flow'), findsNothing);
      expect(find.text('AI-Generated Summary'), findsOneWidget);
    });

    testWidgets('build_someMetricsZero_showsOnlyNonZeroCards', (tester) async {
      // act
      await pumpModal(
        tester,
        _report(
          income: _zeroIncome.copyWith(revenue: _valueWithDriver, eps: _value),
        ),
      );

      // assert
      expect(find.text('Operations'), findsOneWidget);
      expect(find.text('Revenue'), findsOneWidget);
      expect(find.text('Earnings Per Share'), findsOneWidget);
      expect(find.text('Cost of Revenue'), findsNothing);
      expect(find.text('Total Expenses'), findsNothing);
      expect(find.text('Net Income'), findsNothing);
      expect(find.byType(MetricCard), findsNWidgets(2));
    });

    testWidgets('build_onlyOneSectionHasValues_hidesOtherSectionHeaders', (
      tester,
    ) async {
      // act
      await pumpModal(
        tester,
        _report(cashFlow: const ReportCashFlow(freeCashFlow: _valueWithDriver)),
      );

      // assert
      expect(find.text('Cash Flow'), findsOneWidget);
      expect(find.text('Free Cash Flow'), findsOneWidget);
      expect(find.text('Operations'), findsNothing);
      expect(find.text('Balance Sheet'), findsNothing);
    });

    testWidgets('build_negativeMetric_showsCard', (tester) async {
      // act
      await pumpModal(
        tester,
        _report(
          income: _zeroIncome.copyWith(
            netIncome: _valueWithDriver.copyWith(amount: -100),
          ),
        ),
      );

      // assert
      expect(find.text('Net Income'), findsOneWidget);
    });
  });
}
