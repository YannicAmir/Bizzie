// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_price_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoricalPriceDto _$HistoricalPriceDtoFromJson(Map<String, dynamic> json) =>
    _HistoricalPriceDto(
      symbol: json['symbol'] as String,
      date: json['date'] as String,
      price: (json['price'] as num).toDouble(),
      volume: (json['volume'] as num).toInt(),
    );

Map<String, dynamic> _$HistoricalPriceDtoToJson(_HistoricalPriceDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'date': instance.date,
      'price': instance.price,
      'volume': instance.volume,
    };
