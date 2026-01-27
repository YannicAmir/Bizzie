import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_statement_dto.freezed.dart';
part 'income_statement_dto.g.dart';

@freezed
abstract class IncomeStatementDto with _$IncomeStatementDto {
  const factory IncomeStatementDto({
    required String date,
    required String symbol,
    required String reportedCurrency,
    required String cik,
    required String filingDate,
    required String acceptedDate,
    required String fiscalYear,
    required String period,
    double? revenue,
    double? costOfRevenue,
    double? grossProfit,
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
    double? ebit,
    double? operatingIncome,
    double? totalOtherIncomeExpensesNet,
    double? incomeBeforeTax,
    double? incomeTaxExpense,
    double? netIncome,
    double? eps,
    double? epsDiluted,
    double? weightedAverageShsOut,
    double? weightedAverageShsOutDil,
  }) = _IncomeStatementDto;

  factory IncomeStatementDto.fromJson(Map<String, dynamic> json) =>
      _$IncomeStatementDtoFromJson(json);
}
