// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_flow_statement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CashFlowStatementDto _$CashFlowStatementDtoFromJson(
  Map<String, dynamic> json,
) => _CashFlowStatementDto(
  date: json['date'] as String,
  symbol: json['symbol'] as String,
  reportedCurrency: json['reportedCurrency'] as String,
  cik: json['cik'] as String,
  filingDate: json['filingDate'] as String,
  acceptedDate: json['acceptedDate'] as String,
  fiscalYear: json['fiscalYear'] as String,
  period: json['period'] as String,
  netIncome: (json['netIncome'] as num).toDouble(),
  depreciationAndAmortization: (json['depreciationAndAmortization'] as num)
      .toDouble(),
  deferredIncomeTax: (json['deferredIncomeTax'] as num).toDouble(),
  stockBasedCompensation: (json['stockBasedCompensation'] as num).toDouble(),
  changeInWorkingCapital: (json['changeInWorkingCapital'] as num).toDouble(),
  accountsReceivables: (json['accountsReceivables'] as num).toDouble(),
  inventory: (json['inventory'] as num).toDouble(),
  accountsPayables: (json['accountsPayables'] as num).toDouble(),
  otherWorkingCapital: (json['otherWorkingCapital'] as num).toDouble(),
  otherNonCashItems: (json['otherNonCashItems'] as num).toDouble(),
  netCashProvidedByOperatingActivities:
      (json['netCashProvidedByOperatingActivities'] as num).toDouble(),
  investmentsInPropertyPlantAndEquipment:
      (json['investmentsInPropertyPlantAndEquipment'] as num).toDouble(),
  acquisitionsNet: (json['acquisitionsNet'] as num).toDouble(),
  purchasesOfInvestments: (json['purchasesOfInvestments'] as num).toDouble(),
  salesMaturitiesOfInvestments: (json['salesMaturitiesOfInvestments'] as num)
      .toDouble(),
  otherInvestingActivities: (json['otherInvestingActivities'] as num)
      .toDouble(),
  netCashProvidedByInvestingActivities:
      (json['netCashProvidedByInvestingActivities'] as num).toDouble(),
  netDebtIssuance: (json['netDebtIssuance'] as num).toDouble(),
  longTermNetDebtIssuance: (json['longTermNetDebtIssuance'] as num).toDouble(),
  shortTermNetDebtIssuance: (json['shortTermNetDebtIssuance'] as num)
      .toDouble(),
  netStockIssuance: (json['netStockIssuance'] as num).toDouble(),
  netCommonStockIssuance: (json['netCommonStockIssuance'] as num).toDouble(),
  commonStockIssuance: (json['commonStockIssuance'] as num).toDouble(),
  commonStockRepurchased: (json['commonStockRepurchased'] as num).toDouble(),
  netPreferredStockIssuance: (json['netPreferredStockIssuance'] as num)
      .toDouble(),
  netDividendsPaid: (json['netDividendsPaid'] as num).toDouble(),
  commonDividendsPaid: (json['commonDividendsPaid'] as num).toDouble(),
  preferredDividendsPaid: (json['preferredDividendsPaid'] as num).toDouble(),
  otherFinancingActivities: (json['otherFinancingActivities'] as num)
      .toDouble(),
  netCashProvidedByFinancingActivities:
      (json['netCashProvidedByFinancingActivities'] as num).toDouble(),
  effectOfForexChangesOnCash: (json['effectOfForexChangesOnCash'] as num)
      .toDouble(),
  netChangeInCash: (json['netChangeInCash'] as num).toDouble(),
  cashAtEndOfPeriod: (json['cashAtEndOfPeriod'] as num).toDouble(),
  cashAtBeginningOfPeriod: (json['cashAtBeginningOfPeriod'] as num).toDouble(),
  operatingCashFlow: (json['operatingCashFlow'] as num).toDouble(),
  capitalExpenditure: (json['capitalExpenditure'] as num).toDouble(),
  freeCashFlow: (json['freeCashFlow'] as num).toDouble(),
  incomeTaxesPaid: (json['incomeTaxesPaid'] as num).toDouble(),
  interestPaid: (json['interestPaid'] as num).toDouble(),
);

Map<String, dynamic> _$CashFlowStatementDtoToJson(
  _CashFlowStatementDto instance,
) => <String, dynamic>{
  'date': instance.date,
  'symbol': instance.symbol,
  'reportedCurrency': instance.reportedCurrency,
  'cik': instance.cik,
  'filingDate': instance.filingDate,
  'acceptedDate': instance.acceptedDate,
  'fiscalYear': instance.fiscalYear,
  'period': instance.period,
  'netIncome': instance.netIncome,
  'depreciationAndAmortization': instance.depreciationAndAmortization,
  'deferredIncomeTax': instance.deferredIncomeTax,
  'stockBasedCompensation': instance.stockBasedCompensation,
  'changeInWorkingCapital': instance.changeInWorkingCapital,
  'accountsReceivables': instance.accountsReceivables,
  'inventory': instance.inventory,
  'accountsPayables': instance.accountsPayables,
  'otherWorkingCapital': instance.otherWorkingCapital,
  'otherNonCashItems': instance.otherNonCashItems,
  'netCashProvidedByOperatingActivities':
      instance.netCashProvidedByOperatingActivities,
  'investmentsInPropertyPlantAndEquipment':
      instance.investmentsInPropertyPlantAndEquipment,
  'acquisitionsNet': instance.acquisitionsNet,
  'purchasesOfInvestments': instance.purchasesOfInvestments,
  'salesMaturitiesOfInvestments': instance.salesMaturitiesOfInvestments,
  'otherInvestingActivities': instance.otherInvestingActivities,
  'netCashProvidedByInvestingActivities':
      instance.netCashProvidedByInvestingActivities,
  'netDebtIssuance': instance.netDebtIssuance,
  'longTermNetDebtIssuance': instance.longTermNetDebtIssuance,
  'shortTermNetDebtIssuance': instance.shortTermNetDebtIssuance,
  'netStockIssuance': instance.netStockIssuance,
  'netCommonStockIssuance': instance.netCommonStockIssuance,
  'commonStockIssuance': instance.commonStockIssuance,
  'commonStockRepurchased': instance.commonStockRepurchased,
  'netPreferredStockIssuance': instance.netPreferredStockIssuance,
  'netDividendsPaid': instance.netDividendsPaid,
  'commonDividendsPaid': instance.commonDividendsPaid,
  'preferredDividendsPaid': instance.preferredDividendsPaid,
  'otherFinancingActivities': instance.otherFinancingActivities,
  'netCashProvidedByFinancingActivities':
      instance.netCashProvidedByFinancingActivities,
  'effectOfForexChangesOnCash': instance.effectOfForexChangesOnCash,
  'netChangeInCash': instance.netChangeInCash,
  'cashAtEndOfPeriod': instance.cashAtEndOfPeriod,
  'cashAtBeginningOfPeriod': instance.cashAtBeginningOfPeriod,
  'operatingCashFlow': instance.operatingCashFlow,
  'capitalExpenditure': instance.capitalExpenditure,
  'freeCashFlow': instance.freeCashFlow,
  'incomeTaxesPaid': instance.incomeTaxesPaid,
  'interestPaid': instance.interestPaid,
};
