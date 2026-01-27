// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteDto _$QuoteDtoFromJson(Map<String, dynamic> json) => _QuoteDto(
  symbol: json['symbol'] as String,
  name: json['name'] as String,
  price: (json['price'] as num?)?.toDouble(),
  change: (json['change'] as num?)?.toDouble(),
  changesPercentage: (json['changesPercentage'] as num?)?.toDouble(),
  marketCap: (json['marketCap'] as num?)?.toDouble(),
  pe: (json['pe'] as num?)?.toDouble(),
  eps: (json['eps'] as num?)?.toDouble(),
  volume: (json['volume'] as num?)?.toDouble(),
  sharesOutstanding: (json['sharesOutstanding'] as num?)?.toDouble(),
);

Map<String, dynamic> _$QuoteDtoToJson(_QuoteDto instance) => <String, dynamic>{
  'symbol': instance.symbol,
  'name': instance.name,
  'price': instance.price,
  'change': instance.change,
  'changesPercentage': instance.changesPercentage,
  'marketCap': instance.marketCap,
  'pe': instance.pe,
  'eps': instance.eps,
  'volume': instance.volume,
  'sharesOutstanding': instance.sharesOutstanding,
};
