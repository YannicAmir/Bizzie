// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FinancialStatementDto _$FinancialStatementDtoFromJson(
  Map<String, dynamic> json,
) => _FinancialStatementDto(
  date: json['date'] as String?,
  symbol: json['symbol'] as String?,
  period: json['period'] as String?,
  revenue: (json['revenue'] as num?)?.toDouble(),
  netIncome: (json['netIncome'] as num?)?.toDouble(),
  eps: (json['eps'] as num?)?.toDouble(),
  ebitda: (json['ebitda'] as num?)?.toDouble(),
  operatingIncome: (json['operatingIncome'] as num?)?.toDouble(),
  grossProfit: (json['grossProfit'] as num?)?.toDouble(),
  totalAssets: (json['totalAssets'] as num?)?.toDouble(),
  totalLiabilities: (json['totalLiabilities'] as num?)?.toDouble(),
  totalEquity: (json['totalEquity'] as num?)?.toDouble(),
  totalStockholdersEquity: (json['totalStockholdersEquity'] as num?)
      ?.toDouble(),
  cashAndShortTermInvestments: (json['cashAndShortTermInvestments'] as num?)
      ?.toDouble(),
  totalDebt: (json['totalDebt'] as num?)?.toDouble(),
  operatingCashFlow: (json['operatingCashFlow'] as num?)?.toDouble(),
  netCashProvidedByOperatingActivities:
      (json['netCashProvidedByOperatingActivities'] as num?)?.toDouble(),
  investingCashFlow: (json['investingCashFlow'] as num?)?.toDouble(),
  netCashProvidedByInvestingActivities:
      (json['netCashProvidedByInvestingActivities'] as num?)?.toDouble(),
  financingCashFlow: (json['financingCashFlow'] as num?)?.toDouble(),
  netCashProvidedByFinancingActivities:
      (json['netCashProvidedByFinancingActivities'] as num?)?.toDouble(),
  capitalExpenditure: (json['capitalExpenditure'] as num?)?.toDouble(),
  freeCashFlow: (json['freeCashFlow'] as num?)?.toDouble(),
  dividendsPaid: (json['dividendsPaid'] as num?)?.toDouble(),
  netDividendsPaid: (json['netDividendsPaid'] as num?)?.toDouble(),
  weightedAverageShsOut: (json['weightedAverageShsOut'] as num?)?.toDouble(),
  link: json['link'] as String?,
  finalLink: json['finalLink'] as String?,
);

Map<String, dynamic> _$FinancialStatementDtoToJson(
  _FinancialStatementDto instance,
) => <String, dynamic>{
  'date': instance.date,
  'symbol': instance.symbol,
  'period': instance.period,
  'revenue': instance.revenue,
  'netIncome': instance.netIncome,
  'eps': instance.eps,
  'ebitda': instance.ebitda,
  'operatingIncome': instance.operatingIncome,
  'grossProfit': instance.grossProfit,
  'totalAssets': instance.totalAssets,
  'totalLiabilities': instance.totalLiabilities,
  'totalEquity': instance.totalEquity,
  'totalStockholdersEquity': instance.totalStockholdersEquity,
  'cashAndShortTermInvestments': instance.cashAndShortTermInvestments,
  'totalDebt': instance.totalDebt,
  'operatingCashFlow': instance.operatingCashFlow,
  'netCashProvidedByOperatingActivities':
      instance.netCashProvidedByOperatingActivities,
  'investingCashFlow': instance.investingCashFlow,
  'netCashProvidedByInvestingActivities':
      instance.netCashProvidedByInvestingActivities,
  'financingCashFlow': instance.financingCashFlow,
  'netCashProvidedByFinancingActivities':
      instance.netCashProvidedByFinancingActivities,
  'capitalExpenditure': instance.capitalExpenditure,
  'freeCashFlow': instance.freeCashFlow,
  'dividendsPaid': instance.dividendsPaid,
  'netDividendsPaid': instance.netDividendsPaid,
  'weightedAverageShsOut': instance.weightedAverageShsOut,
  'link': instance.link,
  'finalLink': instance.finalLink,
};
