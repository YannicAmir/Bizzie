import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_symbol.freezed.dart';

@freezed
abstract class StockSymbol with _$StockSymbol {
  const factory StockSymbol({
    required String symbol,
    required String name,
    @Default(false) bool isPrivate,
  }) = _StockSymbol;
}
