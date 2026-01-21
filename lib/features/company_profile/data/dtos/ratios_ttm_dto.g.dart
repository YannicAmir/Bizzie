// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratios_ttm_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RatiosTtmDto _$RatiosTtmDtoFromJson(Map<String, dynamic> json) =>
    _RatiosTtmDto(
      symbol: json['symbol'] as String?,
      priceToEarningsRatioTTM: (json['priceToEarningsRatioTTM'] as num?)
          ?.toDouble(),
      priceToFreeCashFlowRatioTTM: (json['priceToFreeCashFlowRatioTTM'] as num?)
          ?.toDouble(),
    );

Map<String, dynamic> _$RatiosTtmDtoToJson(_RatiosTtmDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'priceToEarningsRatioTTM': instance.priceToEarningsRatioTTM,
      'priceToFreeCashFlowRatioTTM': instance.priceToFreeCashFlowRatioTTM,
    };
