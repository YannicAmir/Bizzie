// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_price_eod_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoricalPriceEodDto _$HistoricalPriceEodDtoFromJson(
  Map<String, dynamic> json,
) => _HistoricalPriceEodDto(
  symbol: json['symbol'] as String,
  date: json['date'] as String,
  price: (json['price'] as num).toDouble(),
  volume: (json['volume'] as num).toDouble(),
);

Map<String, dynamic> _$HistoricalPriceEodDtoToJson(
  _HistoricalPriceEodDto instance,
) => <String, dynamic>{
  'symbol': instance.symbol,
  'date': instance.date,
  'price': instance.price,
  'volume': instance.volume,
};
