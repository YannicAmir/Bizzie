import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_dtos.freezed.dart';
part 'financial_dtos.g.dart';

// Financial Statements Wrapper
@freezed
abstract class FinancialStatementDto with _$FinancialStatementDto {
  const factory FinancialStatementDto({
    required String date,
    required String symbol,
    required String period,

    // Income
    double? revenue,
    double? netIncome,
    double? eps,
    double? ebitda,
    double? operatingIncome,
    double? grossProfit,

    // Balance Sheet
    double? totalAssets,
    double? totalLiabilities,
    double? totalEquity,
    double? totalStockholdersEquity,
    double? cashAndShortTermInvestments,
    double? totalDebt,

    // Cash Flow
    double? operatingCashFlow,
    double? netCashProvidedByOperatingActivities,
    double? investingCashFlow,
    double? netCashProvidedByInvestingActivities,
    double? financingCashFlow,
    double? netCashProvidedByFinancingActivities,
    double? capitalExpenditure,
    double? freeCashFlow,
    double? dividendsPaid,
    double? netDividendsPaid,
    double? weightedAverageShsOut,
    String? link,
    String? finalLink,
  }) = _FinancialStatementDto;

  factory FinancialStatementDto.fromJson(Map<String, dynamic> json) =>
      _$FinancialStatementDtoFromJson(json);
}
