import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:dartz/dartz.dart';

abstract class IWatchlistPricesRepository {
  Stream<Either<Failure, List<WatchlistStockPrice>>> watchWatchlistPrices(
    List<String> tickers,
  );
}
