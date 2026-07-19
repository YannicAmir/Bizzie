import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_stock_price.freezed.dart';

@freezed
abstract class WatchlistStockPrice with _$WatchlistStockPrice {
  const factory WatchlistStockPrice({
    required String ticker,
    required String companyName,
    required double price,
    required double? previousClose,
    required double? change,
    required double? changePercent,
    required String sessionDate,
    required List<WatchlistStockPricePoint> series,
    required bool closeFinalized,
  }) = _WatchlistStockPrice;
}

@freezed
abstract class WatchlistStockPricePoint with _$WatchlistStockPricePoint {
  const factory WatchlistStockPricePoint({
    required String time,
    required double close,
  }) = _WatchlistStockPricePoint;
}
