import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_report.freezed.dart';

@freezed
abstract class FinancialReport with _$FinancialReport {
  const factory FinancialReport({
    required String id,
    required String ticker,
    required DateTime? dateAnalyzed,
    required DateTime? filingDate,
    required String formType,
    required ReportSummary summary,
    required ReportBalanceSheet balanceSheet,
    required ReportCashFlow cashFlow,
    required ReportIncome income,
    required ReportStockActivity stockActivity,
  }) = _FinancialReport;
}

@freezed
abstract class ReportSummary with _$ReportSummary {
  const factory ReportSummary({
    required String ticker,
    required String forwardLooking,
    required int citationPage,
    required String reportingCurrency,
  }) = _ReportSummary;
}

@freezed
abstract class ReportBalanceSheet with _$ReportBalanceSheet {
  const factory ReportBalanceSheet({
    required FinancialMetric equity,
    required FinancialMetric totalAssets,
    required FinancialMetric totalLiabilities,
  }) = _ReportBalanceSheet;
}

@freezed
abstract class ReportCashFlow with _$ReportCashFlow {
  const factory ReportCashFlow({
    required FinancialMetricWithDriver freeCashFlow,
  }) = _ReportCashFlow;
}

@freezed
abstract class ReportIncome with _$ReportIncome {
  const factory ReportIncome({
    required FinancialMetric costOfRevenue,
    required FinancialMetric eps,
    required FinancialMetricWithDriver netIncome,
    required FinancialMetricWithDriver revenue,
    required FinancialMetricWithDriver totalExpenses,
  }) = _ReportIncome;
}

@freezed
abstract class ReportStockActivity with _$ReportStockActivity {
  const factory ReportStockActivity({
    required int citationPage,
    double? issuedShares,
    double? netStockChangeShares,
    double? repurchasedShares,
  }) = _ReportStockActivity;
}

@freezed
abstract class FinancialMetric with _$FinancialMetric {
  const factory FinancialMetric({
    required double amount,
    required double changeAmount,
    required double changePercent,
    required int citationPage,
  }) = _FinancialMetric;
}

@freezed
abstract class FinancialMetricWithDriver with _$FinancialMetricWithDriver {
  const factory FinancialMetricWithDriver({
    required double amount,
    required double changeAmount,
    required double changePercent,
    required int citationPage,
    String? driver,
  }) = _FinancialMetricWithDriver;
}
