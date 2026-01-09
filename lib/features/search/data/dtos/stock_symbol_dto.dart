// ignore_for_file: invalid_annotation_target
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_symbol_dto.freezed.dart';
part 'stock_symbol_dto.g.dart';

@freezed
abstract class StockSymbolDto with _$StockSymbolDto {
  const factory StockSymbolDto({
    @JsonKey(name: 's', readValue: _readSymbol) required String symbol,
    @JsonKey(name: 'n', readValue: _readName) required String name,
    @Default(false)
    @JsonKey(name: 'isPrivate', readValue: _readIsPrivate)
    bool isPrivate,
  }) = _StockSymbolDto;

  const StockSymbolDto._();

  factory StockSymbolDto.fromJson(Map<String, dynamic> json) =>
      _$StockSymbolDtoFromJson(json);

  StockSymbol toDomain() {
    return StockSymbol(symbol: symbol, name: name, isPrivate: isPrivate);
  }
}

Object? _readSymbol(Map map, String key) {
  return map['s'] ?? map['symbol'];
}

Object? _readName(Map map, String key) {
  return map['n'] ?? map['name'];
}

Object? _readIsPrivate(Map map, String key) {
  return map['isPrivate'] ?? map['private'];
}
