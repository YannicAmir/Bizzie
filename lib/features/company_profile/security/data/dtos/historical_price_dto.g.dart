// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_price_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoricalPriceDto _$HistoricalPriceDtoFromJson(Map<String, dynamic> json) =>
    _HistoricalPriceDto(
      date: json['date'] as String,
      price: (json['price'] as num?)?.toDouble(),
      close: (json['close'] as num?)?.toDouble(),
      volume: (json['volume'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HistoricalPriceDtoToJson(_HistoricalPriceDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'price': instance.price,
      'close': instance.close,
      'volume': instance.volume,
    };
