import 'package:bizzie/features/company_profile/business/domain/models/sec_filing.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
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

  const LegacyIncomeStatementDto._();

  factory LegacyIncomeStatementDto.fromJson(Map<String, dynamic> json) =>
      _$LegacyIncomeStatementDtoFromJson(json);

  SecFiling toSecFiling() {
    return SecFiling(
      date: date,
      year: (date.length >= 4) ? date.substring(0, 4) : '',
      period: period,
      link: finalLink ?? link ?? '',
    );
  }

  FinancialDataPoint toFinancialDataPoint(double value) {
    return FinancialDataPoint(date: date, period: period, value: value);
  }

  IncomeStatement toDomain({double multiplier = 1.0, String? targetCurrency}) {
    return IncomeStatement(
      date: date,
      symbol: symbol,
      reportedCurrency: targetCurrency ?? reportedCurrency,
      period: period,
      revenue: (revenue ?? 0.0) * multiplier,
      grossProfit: (grossProfit ?? 0.0) * multiplier,
      operatingIncome: (operatingIncome ?? 0.0) * multiplier,
      netIncome: (netIncome ?? 0.0) * multiplier,
      eps: (eps ?? 0.0) * multiplier,
      ebitda: (ebitda ?? 0.0) * multiplier,
      costOfRevenue: (costOfRevenue ?? 0.0) * multiplier,
      operatingExpenses: (operatingExpenses ?? 0.0) * multiplier,
      costAndExpenses: (costAndExpenses ?? 0.0) * multiplier,
    );
  }
}
