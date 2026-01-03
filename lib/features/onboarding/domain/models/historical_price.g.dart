// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoricalPrice _$HistoricalPriceFromJson(Map<String, dynamic> json) =>
    _HistoricalPrice(
      symbol: json['symbol'] as String,
      date: json['date'] as String,
      price: (json['price'] as num).toDouble(),
      volume: (json['volume'] as num).toInt(),
    );

Map<String, dynamic> _$HistoricalPriceToJson(_HistoricalPrice instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'date': instance.date,
      'price': instance.price,
      'volume': instance.volume,
    };
