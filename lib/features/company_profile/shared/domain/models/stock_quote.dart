import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_quote.freezed.dart';

@freezed
abstract class StockQuote with _$StockQuote {
  const factory StockQuote({
    required String symbol,
    required String name,
    double? price,
    double? change,
    double? changesPercentage,
    double? marketCap,
    double? pe,
    double? eps,
    double? volume,
    double? sharesOutstanding,
  }) = _StockQuote;
}
