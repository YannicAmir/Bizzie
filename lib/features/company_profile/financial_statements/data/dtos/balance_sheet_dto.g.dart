// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_sheet_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BalanceSheetDto _$BalanceSheetDtoFromJson(Map<String, dynamic> json) =>
    _BalanceSheetDto(
      date: json['date'] as String?,
      symbol: json['symbol'] as String?,
      reportedCurrency: json['reportedCurrency'] as String?,
      cik: json['cik'] as String?,
      fillingDate: json['fillingDate'] as String?,
      acceptedDate: json['acceptedDate'] as String?,
      calendarYear: json['calendarYear'] as String?,
      period: json['period'] as String?,
      totalAssets: (json['totalAssets'] as num?)?.toDouble(),
      totalLiabilities: (json['totalLiabilities'] as num?)?.toDouble(),
      totalEquity: (json['totalEquity'] as num?)?.toDouble(),
      totalCurrentAssets: (json['totalCurrentAssets'] as num?)?.toDouble(),
      totalNonCurrentAssets: (json['totalNonCurrentAssets'] as num?)
          ?.toDouble(),
      totalCurrentLiabilities: (json['totalCurrentLiabilities'] as num?)
          ?.toDouble(),
      totalNonCurrentLiabilities: (json['totalNonCurrentLiabilities'] as num?)
          ?.toDouble(),
      longTermDebt: (json['longTermDebt'] as num?)?.toDouble(),
      shortTermDebt: (json['shortTermDebt'] as num?)?.toDouble(),
      cashAndShortTermInvestments: (json['cashAndShortTermInvestments'] as num?)
          ?.toDouble(),
      netDebt: (json['netDebt'] as num?)?.toDouble(),
      totalDebt: (json['totalDebt'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BalanceSheetDtoToJson(_BalanceSheetDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'symbol': instance.symbol,
      'reportedCurrency': instance.reportedCurrency,
      'cik': instance.cik,
      'fillingDate': instance.fillingDate,
      'acceptedDate': instance.acceptedDate,
      'calendarYear': instance.calendarYear,
      'period': instance.period,
      'totalAssets': instance.totalAssets,
      'totalLiabilities': instance.totalLiabilities,
      'totalEquity': instance.totalEquity,
      'totalCurrentAssets': instance.totalCurrentAssets,
      'totalNonCurrentAssets': instance.totalNonCurrentAssets,
      'totalCurrentLiabilities': instance.totalCurrentLiabilities,
      'totalNonCurrentLiabilities': instance.totalNonCurrentLiabilities,
      'longTermDebt': instance.longTermDebt,
      'shortTermDebt': instance.shortTermDebt,
      'cashAndShortTermInvestments': instance.cashAndShortTermInvestments,
      'netDebt': instance.netDebt,
      'totalDebt': instance.totalDebt,
    };
