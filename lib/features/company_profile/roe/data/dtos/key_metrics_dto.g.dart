// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_metrics_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KeyMetricsDto _$KeyMetricsDtoFromJson(Map<String, dynamic> json) =>
    _KeyMetricsDto(
      symbol: json['symbol'] as String?,
      date: json['date'] as String?,
      period: json['period'] as String?,
      returnOnEquity: (json['returnOnEquity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$KeyMetricsDtoToJson(_KeyMetricsDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'date': instance.date,
      'period': instance.period,
      'returnOnEquity': instance.returnOnEquity,
    };
