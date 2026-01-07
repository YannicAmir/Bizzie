// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_symbol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockSymbol _$StockSymbolFromJson(Map<String, dynamic> json) => _StockSymbol(
  symbol: json['s'] as String,
  name: json['n'] as String,
  isPrivate: json['private'] as bool? ?? false,
);

Map<String, dynamic> _$StockSymbolToJson(_StockSymbol instance) =>
    <String, dynamic>{
      's': instance.symbol,
      'n': instance.name,
      'private': instance.isPrivate,
    };
