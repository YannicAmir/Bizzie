// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_income_statement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LegacyIncomeStatementDto _$LegacyIncomeStatementDtoFromJson(
  Map<String, dynamic> json,
) => _LegacyIncomeStatementDto(
  date: json['date'] as String?,
  symbol: json['symbol'] as String?,
  reportedCurrency: json['reportedCurrency'] as String?,
  cik: json['cik'] as String?,
  fillingDate: json['fillingDate'] as String?,
  acceptedDate: json['acceptedDate'] as String?,
  calendarYear: json['calendarYear'] as String?,
  period: json['period'] as String?,
  revenue: (json['revenue'] as num?)?.toDouble(),
  costOfRevenue: (json['costOfRevenue'] as num?)?.toDouble(),
  grossProfit: (json['grossProfit'] as num?)?.toDouble(),
  grossProfitRatio: (json['grossProfitRatio'] as num?)?.toDouble(),
  researchAndDevelopmentExpenses:
      (json['researchAndDevelopmentExpenses'] as num?)?.toDouble(),
  generalAndAdministrativeExpenses:
      (json['generalAndAdministrativeExpenses'] as num?)?.toDouble(),
  sellingAndMarketingExpenses: (json['sellingAndMarketingExpenses'] as num?)
      ?.toDouble(),
  sellingGeneralAndAdministrativeExpenses:
      (json['sellingGeneralAndAdministrativeExpenses'] as num?)?.toDouble(),
  otherExpenses: (json['otherExpenses'] as num?)?.toDouble(),
  operatingExpenses: (json['operatingExpenses'] as num?)?.toDouble(),
  costAndExpenses: (json['costAndExpenses'] as num?)?.toDouble(),
  interestIncome: (json['interestIncome'] as num?)?.toDouble(),
  interestExpense: (json['interestExpense'] as num?)?.toDouble(),
  depreciationAndAmortization: (json['depreciationAndAmortization'] as num?)
      ?.toDouble(),
  ebitda: (json['ebitda'] as num?)?.toDouble(),
  ebitdaratio: (json['ebitdaratio'] as num?)?.toDouble(),
  operatingIncome: (json['operatingIncome'] as num?)?.toDouble(),
  operatingIncomeRatio: (json['operatingIncomeRatio'] as num?)?.toDouble(),
  totalOtherIncomeExpensesNet: (json['totalOtherIncomeExpensesNet'] as num?)
      ?.toDouble(),
  incomeBeforeTax: (json['incomeBeforeTax'] as num?)?.toDouble(),
  incomeBeforeTaxRatio: (json['incomeBeforeTaxRatio'] as num?)?.toDouble(),
  incomeTaxExpense: (json['incomeTaxExpense'] as num?)?.toDouble(),
  netIncome: (json['netIncome'] as num?)?.toDouble(),
  netIncomeRatio: (json['netIncomeRatio'] as num?)?.toDouble(),
  eps: (json['eps'] as num?)?.toDouble(),
  epsdiluted: (json['epsdiluted'] as num?)?.toDouble(),
  weightedAverageShsOut: (json['weightedAverageShsOut'] as num?)?.toDouble(),
  weightedAverageShsOutDil: (json['weightedAverageShsOutDil'] as num?)
      ?.toDouble(),
  link: json['link'] as String?,
  finalLink: json['finalLink'] as String?,
);

Map<String, dynamic> _$LegacyIncomeStatementDtoToJson(
  _LegacyIncomeStatementDto instance,
) => <String, dynamic>{
  'date': instance.date,
  'symbol': instance.symbol,
  'reportedCurrency': instance.reportedCurrency,
  'cik': instance.cik,
  'fillingDate': instance.fillingDate,
  'acceptedDate': instance.acceptedDate,
  'calendarYear': instance.calendarYear,
  'period': instance.period,
  'revenue': instance.revenue,
  'costOfRevenue': instance.costOfRevenue,
  'grossProfit': instance.grossProfit,
  'grossProfitRatio': instance.grossProfitRatio,
  'researchAndDevelopmentExpenses': instance.researchAndDevelopmentExpenses,
  'generalAndAdministrativeExpenses': instance.generalAndAdministrativeExpenses,
  'sellingAndMarketingExpenses': instance.sellingAndMarketingExpenses,
  'sellingGeneralAndAdministrativeExpenses':
      instance.sellingGeneralAndAdministrativeExpenses,
  'otherExpenses': instance.otherExpenses,
  'operatingExpenses': instance.operatingExpenses,
  'costAndExpenses': instance.costAndExpenses,
  'interestIncome': instance.interestIncome,
  'interestExpense': instance.interestExpense,
  'depreciationAndAmortization': instance.depreciationAndAmortization,
  'ebitda': instance.ebitda,
  'ebitdaratio': instance.ebitdaratio,
  'operatingIncome': instance.operatingIncome,
  'operatingIncomeRatio': instance.operatingIncomeRatio,
  'totalOtherIncomeExpensesNet': instance.totalOtherIncomeExpensesNet,
  'incomeBeforeTax': instance.incomeBeforeTax,
  'incomeBeforeTaxRatio': instance.incomeBeforeTaxRatio,
  'incomeTaxExpense': instance.incomeTaxExpense,
  'netIncome': instance.netIncome,
  'netIncomeRatio': instance.netIncomeRatio,
  'eps': instance.eps,
  'epsdiluted': instance.epsdiluted,
  'weightedAverageShsOut': instance.weightedAverageShsOut,
  'weightedAverageShsOutDil': instance.weightedAverageShsOutDil,
  'link': instance.link,
  'finalLink': instance.finalLink,
};
