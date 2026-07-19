import 'package:bizzie/features/home/data/dtos/watchlist_stock_price_dto.dart';

abstract class IWatchlistPricesRemoteDataSource {
  Future<List<WatchlistStockPriceDto>> getWatchlistPrices(
    List<String> tickers,
  );
}
