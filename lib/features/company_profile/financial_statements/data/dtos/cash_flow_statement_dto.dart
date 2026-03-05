import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_flow_statement_dto.freezed.dart';
part 'cash_flow_statement_dto.g.dart';

@freezed
abstract class CashFlowStatementDto with _$CashFlowStatementDto {
  const factory CashFlowStatementDto({
    String? date,
    String? symbol,
    String? reportedCurrency,
    String? cik,
    String? filingDate,
    String? acceptedDate,
    String? fiscalYear,
    String? period,
    double? netIncome,
    double? depreciationAndAmortization,
    double? deferredIncomeTax,
    double? stockBasedCompensation,
    double? changeInWorkingCapital,
    double? accountsReceivables,
    double? inventory,
    double? accountsPayables,
    double? otherWorkingCapital,
    double? otherNonCashItems,
    double? netCashProvidedByOperatingActivities,
    double? investmentsInPropertyPlantAndEquipment,
    double? acquisitionsNet,
    double? purchasesOfInvestments,
    double? salesMaturitiesOfInvestments,
    double? otherInvestingActivities,
    double? netCashProvidedByInvestingActivities,
    double? netDebtIssuance,
    double? longTermNetDebtIssuance,
    double? shortTermNetDebtIssuance,
    double? netStockIssuance,
    double? netCommonStockIssuance,
    double? commonStockIssuance,
    double? commonStockRepurchased,
    double? netPreferredStockIssuance,
    double? netDividendsPaid,
    double? commonDividendsPaid,
    double? preferredDividendsPaid,
    double? otherFinancingActivities,
    double? netCashProvidedByFinancingActivities,
    double? effectOfForexChangesOnCash,
    double? netChangeInCash,
    double? cashAtEndOfPeriod,
    double? cashAtBeginningOfPeriod,
    double? operatingCashFlow,
    double? capitalExpenditure,
    double? freeCashFlow,
    double? incomeTaxesPaid,
    double? interestPaid,
  }) = _CashFlowStatementDto;

  const CashFlowStatementDto._();

  factory CashFlowStatementDto.fromJson(Map<String, dynamic> json) =>
      _$CashFlowStatementDtoFromJson(json);

  FinancialDataPoint toFinancialDataPoint(double value) {
    return FinancialDataPoint(
      date: date ?? '',
      period: period ?? '',
      value: value,
    );
  }

  FinancialDataPoint toFreeCashFlowDataPoint({double multiplier = 1.0}) {
    return toFinancialDataPoint((freeCashFlow ?? 0.0) * multiplier);
  }

  FinancialDataPoint toFcpsDataPoint(double shares, {double multiplier = 1.0}) {
    final value = (shares > 0) ? (freeCashFlow ?? 0.0) / shares : 0.0;
    return toFinancialDataPoint(value * multiplier);
  }

  CashFlowStatement toDomain({
    double multiplier = 1.0,
    String? targetCurrency,
  }) {
    return CashFlowStatement(
      date: date ?? '',
      symbol: symbol ?? '',
      reportedCurrency: targetCurrency ?? reportedCurrency ?? '',
      period: period ?? '',
      operatingCashFlow: (operatingCashFlow ?? 0.0) * multiplier,
      investingCashFlow:
          (netCashProvidedByInvestingActivities ?? 0.0) * multiplier,
      financingCashFlow:
          (netCashProvidedByFinancingActivities ?? 0.0) * multiplier,
      capitalExpenditure: (capitalExpenditure ?? 0.0) * multiplier,
      freeCashFlow: (freeCashFlow ?? 0.0) * multiplier,
      dividendsPaid: (netDividendsPaid ?? 0.0) * multiplier,
      cashAtBeginningOfPeriod: (cashAtBeginningOfPeriod ?? 0.0) * multiplier,
      cashAtEndOfPeriod: (cashAtEndOfPeriod ?? 0.0) * multiplier,
    );
  }
}
