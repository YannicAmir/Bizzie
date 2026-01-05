// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_symbol.freezed.dart';
part 'stock_symbol.g.dart';

@freezed
abstract class StockSymbol with _$StockSymbol {
  const factory StockSymbol({
    @JsonKey(name: 's') required String symbol,
    @JsonKey(name: 'n') required String name,
  }) = _StockSymbol;

  factory StockSymbol.fromJson(Map<String, dynamic> json) =>
      _$StockSymbolFromJson(json);
}
