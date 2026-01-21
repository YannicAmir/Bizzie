import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_flow_statement_dto.freezed.dart';
part 'cash_flow_statement_dto.g.dart';

@freezed
abstract class CashFlowStatementDto with _$CashFlowStatementDto {
  const factory CashFlowStatementDto({
    required String date,
    required String symbol,
    required String reportedCurrency,
    required String cik,
    required String filingDate,
    required String acceptedDate,
    required String fiscalYear,
    required String period,
    required double netIncome,
    required double depreciationAndAmortization,
    required double deferredIncomeTax,
    required double stockBasedCompensation,
    required double changeInWorkingCapital,
    required double accountsReceivables,
    required double inventory,
    required double accountsPayables,
    required double otherWorkingCapital,
    required double otherNonCashItems,
    required double netCashProvidedByOperatingActivities,
    required double investmentsInPropertyPlantAndEquipment,
    required double acquisitionsNet,
    required double purchasesOfInvestments,
    required double salesMaturitiesOfInvestments,
    required double otherInvestingActivities,
    required double netCashProvidedByInvestingActivities,
    required double netDebtIssuance,
    required double longTermNetDebtIssuance,
    required double shortTermNetDebtIssuance,
    required double netStockIssuance,
    required double netCommonStockIssuance,
    required double commonStockIssuance,
    required double commonStockRepurchased,
    required double netPreferredStockIssuance,
    required double netDividendsPaid,
    required double commonDividendsPaid,
    required double preferredDividendsPaid,
    required double otherFinancingActivities,
    required double netCashProvidedByFinancingActivities,
    required double effectOfForexChangesOnCash,
    required double netChangeInCash,
    required double cashAtEndOfPeriod,
    required double cashAtBeginningOfPeriod,
    required double operatingCashFlow,
    required double capitalExpenditure,
    required double freeCashFlow,
    required double incomeTaxesPaid,
    required double interestPaid,
  }) = _CashFlowStatementDto;

  factory CashFlowStatementDto.fromJson(Map<String, dynamic> json) =>
      _$CashFlowStatementDtoFromJson(json);
}
