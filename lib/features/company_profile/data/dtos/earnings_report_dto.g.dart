// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earnings_report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarningsReportDto _$EarningsReportDtoFromJson(Map<String, dynamic> json) =>
    _EarningsReportDto(
      symbol: json['symbol'] as String,
      date: json['date'] as String,
      epsActual: (json['epsActual'] as num?)?.toDouble(),
      epsEstimated: (json['epsEstimated'] as num?)?.toDouble(),
      revenueActual: (json['revenueActual'] as num?)?.toInt(),
      revenueEstimated: (json['revenueEstimated'] as num?)?.toInt(),
      lastUpdated: json['lastUpdated'] as String?,
    );

Map<String, dynamic> _$EarningsReportDtoToJson(_EarningsReportDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'date': instance.date,
      'epsActual': instance.epsActual,
      'epsEstimated': instance.epsEstimated,
      'revenueActual': instance.revenueActual,
      'revenueEstimated': instance.revenueEstimated,
      'lastUpdated': instance.lastUpdated,
    };
