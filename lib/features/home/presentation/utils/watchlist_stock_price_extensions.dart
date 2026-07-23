import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';

extension WatchlistStockPricePresentationX on WatchlistStockPrice {
  bool get hasPositiveChange => (changePercent ?? 0) >= 0;

  String get formattedChangePercent {
    final percent = changePercent;
    if (percent == null) return '--';
    final sign = hasPositiveChange ? '+' : '';
    return '$sign${percent.toStringAsFixed(2)}%';
  }
}
