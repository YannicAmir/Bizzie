import 'package:bizzie/features/home/data/dtos/watchlist_stock_price_dto.dart';

abstract class IWatchlistPricesRemoteDataSource {
  Stream<List<WatchlistStockPriceDto>> getWatchlistPricesStream(
    List<String> tickers,
  );
}
