import 'package:freezed_annotation/freezed_annotation.dart';

part 'legacy_income_statement_dto.freezed.dart';
part 'legacy_income_statement_dto.g.dart';

@freezed
abstract class LegacyIncomeStatementDto with _$LegacyIncomeStatementDto {
  const factory LegacyIncomeStatementDto({
    required String date,
    required String symbol,
    required String reportedCurrency,
    required String cik,
    required String fillingDate,
    required String acceptedDate,
    required String calendarYear,
    required String period,
    double? revenue,
    double? costOfRevenue,
    double? grossProfit,
    double? grossProfitRatio,
    double? researchAndDevelopmentExpenses,
    double? generalAndAdministrativeExpenses,
    double? sellingAndMarketingExpenses,
    double? sellingGeneralAndAdministrativeExpenses,
    double? otherExpenses,
    double? operatingExpenses,
    double? costAndExpenses,
    double? interestIncome,
    double? interestExpense,
    double? depreciationAndAmortization,
    double? ebitda,
    double? ebitdaratio,
    double? operatingIncome,
    double? operatingIncomeRatio,
    double? totalOtherIncomeExpensesNet,
    double? incomeBeforeTax,
    double? incomeBeforeTaxRatio,
    double? incomeTaxExpense,
    double? netIncome,
    double? netIncomeRatio,
    double? eps,
    double? epsdiluted,
    double? weightedAverageShsOut,
    double? weightedAverageShsOutDil,
    required String? link,
    required String? finalLink,
  }) = _LegacyIncomeStatementDto;

  factory LegacyIncomeStatementDto.fromJson(Map<String, dynamic> json) =>
      _$LegacyIncomeStatementDtoFromJson(json);
}
