// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FinancialReportDto _$FinancialReportDtoFromJson(Map<String, dynamic> json) =>
    _FinancialReportDto(
      id: json['id'] as String,
      summary: ReportSummaryDto.fromJson(
        json['summary'] as Map<String, dynamic>,
      ),
      balanceSheet: ReportBalanceSheetDto.fromJson(
        json['balanceSheet'] as Map<String, dynamic>,
      ),
      cashFlow: ReportCashFlowDto.fromJson(
        json['cashFlow'] as Map<String, dynamic>,
      ),
      income: ReportIncomeDto.fromJson(json['income'] as Map<String, dynamic>),
      stockActivity: ReportStockActivityDto.fromJson(
        json['stockActivity'] as Map<String, dynamic>,
      ),
      filingDate: json['filingDate'] as String?,
      dateAnalyzed: _$JsonConverterFromJson<Object, DateTime>(
        json['dateAnalyzed'],
        const TimestampConverter().fromJson,
      ),
      formType: json['formType'] as String?,
      ticker: json['ticker'] as String?,
    );

Map<String, dynamic> _$FinancialReportDtoToJson(_FinancialReportDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'summary': instance.summary,
      'balanceSheet': instance.balanceSheet,
      'cashFlow': instance.cashFlow,
      'income': instance.income,
      'stockActivity': instance.stockActivity,
      'filingDate': instance.filingDate,
      'dateAnalyzed': _$JsonConverterToJson<Object, DateTime>(
        instance.dateAnalyzed,
        const TimestampConverter().toJson,
      ),
      'formType': instance.formType,
      'ticker': instance.ticker,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_ReportSummaryDto _$ReportSummaryDtoFromJson(Map<String, dynamic> json) =>
    _ReportSummaryDto(
      ticker: json['ticker'] as String? ?? '',
      forwardLooking: json['forwardLooking'] as String? ?? '',
      citationPage: (json['citationPage'] as num?)?.toInt() ?? 0,
      reportingCurrency: json['reportingCurrency'] as String? ?? 'USD',
    );

Map<String, dynamic> _$ReportSummaryDtoToJson(_ReportSummaryDto instance) =>
    <String, dynamic>{
      'ticker': instance.ticker,
      'forwardLooking': instance.forwardLooking,
      'citationPage': instance.citationPage,
      'reportingCurrency': instance.reportingCurrency,
    };

_ReportBalanceSheetDto _$ReportBalanceSheetDtoFromJson(
  Map<String, dynamic> json,
) => _ReportBalanceSheetDto(
  equity: FinancialMetricDto.fromJson(json['equity'] as Map<String, dynamic>),
  totalAssets: FinancialMetricDto.fromJson(
    json['totalAssets'] as Map<String, dynamic>,
  ),
  totalLiabilities: FinancialMetricDto.fromJson(
    json['totalLiabilities'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ReportBalanceSheetDtoToJson(
  _ReportBalanceSheetDto instance,
) => <String, dynamic>{
  'equity': instance.equity,
  'totalAssets': instance.totalAssets,
  'totalLiabilities': instance.totalLiabilities,
};

_ReportCashFlowDto _$ReportCashFlowDtoFromJson(Map<String, dynamic> json) =>
    _ReportCashFlowDto(
      freeCashFlow: FinancialMetricWithDriverDto.fromJson(
        json['freeCashFlow'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ReportCashFlowDtoToJson(_ReportCashFlowDto instance) =>
    <String, dynamic>{'freeCashFlow': instance.freeCashFlow};

_ReportIncomeDto _$ReportIncomeDtoFromJson(Map<String, dynamic> json) =>
    _ReportIncomeDto(
      costOfRevenue: FinancialMetricDto.fromJson(
        json['costOfRevenue'] as Map<String, dynamic>,
      ),
      eps: FinancialMetricDto.fromJson(json['eps'] as Map<String, dynamic>),
      netIncome: FinancialMetricWithDriverDto.fromJson(
        json['netIncome'] as Map<String, dynamic>,
      ),
      revenue: FinancialMetricWithDriverDto.fromJson(
        json['revenue'] as Map<String, dynamic>,
      ),
      totalExpenses: FinancialMetricWithDriverDto.fromJson(
        json['totalExpenses'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ReportIncomeDtoToJson(_ReportIncomeDto instance) =>
    <String, dynamic>{
      'costOfRevenue': instance.costOfRevenue,
      'eps': instance.eps,
      'netIncome': instance.netIncome,
      'revenue': instance.revenue,
      'totalExpenses': instance.totalExpenses,
    };

_ReportStockActivityDto _$ReportStockActivityDtoFromJson(
  Map<String, dynamic> json,
) => _ReportStockActivityDto(
  citationPage: (json['citationPage'] as num?)?.toInt() ?? 0,
  issuedShares: const ForceDoubleNullable().fromJson(json['issuedShares']),
  netStockChangeShares: const ForceDoubleNullable().fromJson(
    json['netStockChangeShares'],
  ),
  repurchasedShares: const ForceDoubleNullable().fromJson(
    json['repurchasedShares'],
  ),
);

Map<String, dynamic> _$ReportStockActivityDtoToJson(
  _ReportStockActivityDto instance,
) => <String, dynamic>{
  'citationPage': instance.citationPage,
  'issuedShares': const ForceDoubleNullable().toJson(instance.issuedShares),
  'netStockChangeShares': const ForceDoubleNullable().toJson(
    instance.netStockChangeShares,
  ),
  'repurchasedShares': const ForceDoubleNullable().toJson(
    instance.repurchasedShares,
  ),
};

_FinancialMetricDto _$FinancialMetricDtoFromJson(Map<String, dynamic> json) =>
    _FinancialMetricDto(
      amount: json['amount'] == null
          ? 0.0
          : const ForceDouble().fromJson(json['amount']),
      changeAmount: json['changeAmount'] == null
          ? 0.0
          : const ForceDouble().fromJson(json['changeAmount']),
      changePercent: json['changePercent'] == null
          ? 0.0
          : const ForceDouble().fromJson(json['changePercent']),
      citationPage: (json['citationPage'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$FinancialMetricDtoToJson(_FinancialMetricDto instance) =>
    <String, dynamic>{
      'amount': const ForceDouble().toJson(instance.amount),
      'changeAmount': const ForceDouble().toJson(instance.changeAmount),
      'changePercent': const ForceDouble().toJson(instance.changePercent),
      'citationPage': instance.citationPage,
    };

_FinancialMetricWithDriverDto _$FinancialMetricWithDriverDtoFromJson(
  Map<String, dynamic> json,
) => _FinancialMetricWithDriverDto(
  amount: json['amount'] == null
      ? 0.0
      : const ForceDouble().fromJson(json['amount']),
  changeAmount: json['changeAmount'] == null
      ? 0.0
      : const ForceDouble().fromJson(json['changeAmount']),
  changePercent: json['changePercent'] == null
      ? 0.0
      : const ForceDouble().fromJson(json['changePercent']),
  citationPage: (json['citationPage'] as num?)?.toInt() ?? 0,
  driver: json['driver'] as String?,
);

Map<String, dynamic> _$FinancialMetricWithDriverDtoToJson(
  _FinancialMetricWithDriverDto instance,
) => <String, dynamic>{
  'amount': const ForceDouble().toJson(instance.amount),
  'changeAmount': const ForceDouble().toJson(instance.changeAmount),
  'changePercent': const ForceDouble().toJson(instance.changePercent),
  'citationPage': instance.citationPage,
  'driver': instance.driver,
};
