import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_statement_dto.freezed.dart';
part 'income_statement_dto.g.dart';

@freezed
abstract class IncomeStatementDto with _$IncomeStatementDto {
  const factory IncomeStatementDto({
    String? date,
    String? symbol,
    String? reportedCurrency,
    String? cik,
    String? filingDate,
    String? acceptedDate,
    String? fiscalYear,
    String? period,
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

  const IncomeStatementDto._();

  factory IncomeStatementDto.fromJson(Map<String, dynamic> json) =>
      _$IncomeStatementDtoFromJson(json);

  FinancialDataPoint toFinancialDataPoint(double value) {
    return FinancialDataPoint(
      date: date ?? '',
      period: period ?? '',
      value: value,
    );
  }

  FinancialDataPoint toRevenueDataPoint({double multiplier = 1.0}) {
    return toFinancialDataPoint((revenue ?? 0.0) * multiplier);
  }

  FinancialDataPoint toNetIncomeDataPoint({double multiplier = 1.0}) {
    return toFinancialDataPoint((netIncome ?? 0.0) * multiplier);
  }

  FinancialDataPoint toEpsDataPoint({double multiplier = 1.0}) {
    return toFinancialDataPoint((epsDiluted ?? 0.0) * multiplier);
  }

  IncomeStatement toDomain({double multiplier = 1.0, String? targetCurrency}) {
    return IncomeStatement(
      date: date ?? '',
      symbol: symbol ?? '',
      reportedCurrency: targetCurrency ?? reportedCurrency ?? '',
      period: period ?? '',
      revenue: (revenue ?? 0.0) * multiplier,
      grossProfit: (grossProfit ?? 0.0) * multiplier,
      operatingIncome: (operatingIncome ?? 0.0) * multiplier,
      netIncome: (netIncome ?? 0.0) * multiplier,
      eps: (epsDiluted ?? 0.0) * multiplier,
      ebitda: (ebitda ?? 0.0) * multiplier,
      costOfRevenue: (costOfRevenue ?? 0.0) * multiplier,
      operatingExpenses: (operatingExpenses ?? 0.0) * multiplier,
      costAndExpenses: (costAndExpenses ?? 0.0) * multiplier,
    );
  }
}
