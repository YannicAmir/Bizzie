// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_symbol_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockSymbolDto _$StockSymbolDtoFromJson(Map<String, dynamic> json) =>
    _StockSymbolDto(
      symbol: _readSymbol(json, 's') as String,
      name: _readName(json, 'n') as String,
      isPrivate: _readIsPrivate(json, 'isPrivate') as bool? ?? false,
    );

Map<String, dynamic> _$StockSymbolDtoToJson(_StockSymbolDto instance) =>
    <String, dynamic>{
      's': instance.symbol,
      'n': instance.name,
      'isPrivate': instance.isPrivate,
    };
