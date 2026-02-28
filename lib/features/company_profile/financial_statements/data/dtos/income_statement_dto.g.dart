// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_statement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IncomeStatementDto _$IncomeStatementDtoFromJson(Map<String, dynamic> json) =>
    _IncomeStatementDto(
      date: json['date'] as String?,
      symbol: json['symbol'] as String?,
      reportedCurrency: json['reportedCurrency'] as String?,
      cik: json['cik'] as String?,
      filingDate: json['filingDate'] as String?,
      acceptedDate: json['acceptedDate'] as String?,
      fiscalYear: json['fiscalYear'] as String?,
      period: json['period'] as String?,
      revenue: (json['revenue'] as num?)?.toDouble(),
      costOfRevenue: (json['costOfRevenue'] as num?)?.toDouble(),
      grossProfit: (json['grossProfit'] as num?)?.toDouble(),
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
      ebit: (json['ebit'] as num?)?.toDouble(),
      operatingIncome: (json['operatingIncome'] as num?)?.toDouble(),
      totalOtherIncomeExpensesNet: (json['totalOtherIncomeExpensesNet'] as num?)
          ?.toDouble(),
      incomeBeforeTax: (json['incomeBeforeTax'] as num?)?.toDouble(),
      incomeTaxExpense: (json['incomeTaxExpense'] as num?)?.toDouble(),
      netIncome: (json['netIncome'] as num?)?.toDouble(),
      eps: (json['eps'] as num?)?.toDouble(),
      epsDiluted: (json['epsDiluted'] as num?)?.toDouble(),
      weightedAverageShsOut: (json['weightedAverageShsOut'] as num?)
          ?.toDouble(),
      weightedAverageShsOutDil: (json['weightedAverageShsOutDil'] as num?)
          ?.toDouble(),
    );

Map<String, dynamic> _$IncomeStatementDtoToJson(
  _IncomeStatementDto instance,
) => <String, dynamic>{
  'date': instance.date,
  'symbol': instance.symbol,
  'reportedCurrency': instance.reportedCurrency,
  'cik': instance.cik,
  'filingDate': instance.filingDate,
  'acceptedDate': instance.acceptedDate,
  'fiscalYear': instance.fiscalYear,
  'period': instance.period,
  'revenue': instance.revenue,
  'costOfRevenue': instance.costOfRevenue,
  'grossProfit': instance.grossProfit,
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
  'ebit': instance.ebit,
  'operatingIncome': instance.operatingIncome,
  'totalOtherIncomeExpensesNet': instance.totalOtherIncomeExpensesNet,
  'incomeBeforeTax': instance.incomeBeforeTax,
  'incomeTaxExpense': instance.incomeTaxExpense,
  'netIncome': instance.netIncome,
  'eps': instance.eps,
  'epsDiluted': instance.epsDiluted,
  'weightedAverageShsOut': instance.weightedAverageShsOut,
  'weightedAverageShsOutDil': instance.weightedAverageShsOutDil,
};
