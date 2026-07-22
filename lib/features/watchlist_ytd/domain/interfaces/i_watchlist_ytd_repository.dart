import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:dartz/dartz.dart';

abstract class IWatchlistYtdRepository {
  Future<Either<Failure, List<YtdPriceChange>>> getWatchlistYtd(
    List<String> tickers,
  );
}
