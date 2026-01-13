// ignore_for_file: invalid_annotation_target
import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/utils/json_converters.dart';

part 'financial_report_dto.freezed.dart';
part 'financial_report_dto.g.dart';

@freezed
abstract class FinancialReportDto with _$FinancialReportDto {
  const FinancialReportDto._();

  const factory FinancialReportDto({
    required String id,
    @JsonKey(name: 'summary') required ReportSummaryDto summary,
    @JsonKey(name: 'balanceSheet') required ReportBalanceSheetDto balanceSheet,
    @JsonKey(name: 'cashFlow') required ReportCashFlowDto cashFlow,
    @JsonKey(name: 'income') required ReportIncomeDto income,
    @JsonKey(name: 'stockActivity')
    required ReportStockActivityDto stockActivity,
    String? filingDate,
    DateTime? dateAnalyzed,
    String? formType,
    String? ticker,
  }) = _FinancialReportDto;

  factory FinancialReportDto.fromJson(Map<String, dynamic> json) =>
      _$FinancialReportDtoFromJson(json);

  FinancialReport toDomain() {
    String parsedDate = filingDate ?? '';
    String parsedType = formType ?? 'Unknown';
    String parsedTicker = ticker ?? summary.ticker;

    if (filingDate == null || formType == null || parsedTicker.isEmpty) {
      final parts = id.split('_');
      if (parts.length >= 3) {
        if (parsedTicker.isEmpty) parsedTicker = parts[0];
        if (filingDate == null) parsedDate = parts[1];
        if (formType == null) {
          parsedType = parts.sublist(2).join('_'); // Handle types like 10-K_A
        }
      }
    }

    return FinancialReport(
      id: id,
      ticker: parsedTicker,
      dateAnalyzed: dateAnalyzed,
      filingDate: DateTime.tryParse(parsedDate),
      formType: parsedType,
      summary: summary.toDomain(),
      balanceSheet: balanceSheet.toDomain(),
      cashFlow: cashFlow.toDomain(),
      income: income.toDomain(),
      stockActivity: stockActivity.toDomain(),
    );
  }
}

@freezed
abstract class ReportSummaryDto with _$ReportSummaryDto {
  const ReportSummaryDto._();
  const factory ReportSummaryDto({
    @Default('') String ticker,
    @Default('') String forwardLooking,
    @Default(0) int citationPage,
    @Default('USD') String reportingCurrency,
  }) = _ReportSummaryDto;

  factory ReportSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryDtoFromJson(json);

  ReportSummary toDomain() => ReportSummary(
    ticker: ticker,
    forwardLooking: forwardLooking,
    citationPage: citationPage,
    reportingCurrency: reportingCurrency,
  );
}

@freezed
abstract class ReportBalanceSheetDto with _$ReportBalanceSheetDto {
  const ReportBalanceSheetDto._();
  const factory ReportBalanceSheetDto({
    required FinancialMetricDto equity,
    required FinancialMetricDto totalAssets,
    required FinancialMetricDto totalLiabilities,
  }) = _ReportBalanceSheetDto;

  factory ReportBalanceSheetDto.fromJson(Map<String, dynamic> json) =>
      _$ReportBalanceSheetDtoFromJson(json);

  ReportBalanceSheet toDomain() => ReportBalanceSheet(
    equity: equity.toDomain(),
    totalAssets: totalAssets.toDomain(),
    totalLiabilities: totalLiabilities.toDomain(),
  );
}

@freezed
abstract class ReportCashFlowDto with _$ReportCashFlowDto {
  const ReportCashFlowDto._();
  const factory ReportCashFlowDto({
    required FinancialMetricWithDriverDto freeCashFlow,
  }) = _ReportCashFlowDto;

  factory ReportCashFlowDto.fromJson(Map<String, dynamic> json) =>
      _$ReportCashFlowDtoFromJson(json);

  ReportCashFlow toDomain() =>
      ReportCashFlow(freeCashFlow: freeCashFlow.toDomain());
}

@freezed
abstract class ReportIncomeDto with _$ReportIncomeDto {
  const ReportIncomeDto._();
  const factory ReportIncomeDto({
    required FinancialMetricDto costOfRevenue,
    required FinancialMetricDto eps,
    required FinancialMetricWithDriverDto netIncome,
    required FinancialMetricWithDriverDto revenue,
    required FinancialMetricWithDriverDto totalExpenses,
  }) = _ReportIncomeDto;

  factory ReportIncomeDto.fromJson(Map<String, dynamic> json) =>
      _$ReportIncomeDtoFromJson(json);

  ReportIncome toDomain() => ReportIncome(
    costOfRevenue: costOfRevenue.toDomain(),
    eps: eps.toDomain(),
    netIncome: netIncome.toDomain(),
    revenue: revenue.toDomain(),
    totalExpenses: totalExpenses.toDomain(),
  );
}

@freezed
abstract class ReportStockActivityDto with _$ReportStockActivityDto {
  const ReportStockActivityDto._();
  const factory ReportStockActivityDto({
    @Default(0) int citationPage,
    @ForceDoubleNullable() double? issuedShares,
    @ForceDoubleNullable() double? netStockChangeShares,
    @ForceDoubleNullable() double? repurchasedShares,
  }) = _ReportStockActivityDto;

  factory ReportStockActivityDto.fromJson(Map<String, dynamic> json) =>
      _$ReportStockActivityDtoFromJson(json);

  ReportStockActivity toDomain() => ReportStockActivity(
    citationPage: citationPage,
    issuedShares: issuedShares,
    netStockChangeShares: netStockChangeShares,
    repurchasedShares: repurchasedShares,
  );
}

@freezed
abstract class FinancialMetricDto with _$FinancialMetricDto {
  const FinancialMetricDto._();
  const factory FinancialMetricDto({
    @ForceDouble() @Default(0.0) double amount,
    @ForceDouble() @Default(0.0) double changeAmount,
    @ForceDouble() @Default(0.0) double changePercent,
    @Default(0) int citationPage,
  }) = _FinancialMetricDto;

  factory FinancialMetricDto.fromJson(Map<String, dynamic> json) =>
      _$FinancialMetricDtoFromJson(json);

  FinancialMetric toDomain() => FinancialMetric(
    amount: amount,
    changeAmount: changeAmount,
    changePercent: changePercent,
    citationPage: citationPage,
  );
}

@freezed
abstract class FinancialMetricWithDriverDto
    with _$FinancialMetricWithDriverDto {
  const FinancialMetricWithDriverDto._();
  const factory FinancialMetricWithDriverDto({
    @ForceDouble() @Default(0.0) double amount,
    @ForceDouble() @Default(0.0) double changeAmount,
    @ForceDouble() @Default(0.0) double changePercent,
    @Default(0) int citationPage,
    String? driver,
  }) = _FinancialMetricWithDriverDto;

  factory FinancialMetricWithDriverDto.fromJson(Map<String, dynamic> json) =>
      _$FinancialMetricWithDriverDtoFromJson(json);

  FinancialMetricWithDriver toDomain() => FinancialMetricWithDriver(
    amount: amount,
    changeAmount: changeAmount,
    changePercent: changePercent,
    citationPage: citationPage,
    driver: driver,
  );
}
