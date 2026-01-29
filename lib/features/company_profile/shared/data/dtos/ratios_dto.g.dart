// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratios_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RatiosDto _$RatiosDtoFromJson(Map<String, dynamic> json) => _RatiosDto(
  symbol: json['symbol'] as String?,
  date: json['date'] as String?,
  period: json['period'] as String?,
  priceToEarningsRatio: (json['priceToEarningsRatio'] as num?)?.toDouble(),
  priceToFreeCashFlowRatio: (json['priceToFreeCashFlowRatio'] as num?)
      ?.toDouble(),
);

Map<String, dynamic> _$RatiosDtoToJson(_RatiosDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'date': instance.date,
      'period': instance.period,
      'priceToEarningsRatio': instance.priceToEarningsRatio,
      'priceToFreeCashFlowRatio': instance.priceToFreeCashFlowRatio,
    };
