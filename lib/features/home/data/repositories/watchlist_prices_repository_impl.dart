import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/home/data/interfaces/i_watchlist_prices_remote_datasource.dart';
import 'package:bizzie/features/home/domain/interfaces/i_watchlist_prices_repository.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistPricesRepositoryImpl');

@LazySingleton(as: IWatchlistPricesRepository)
class WatchlistPricesRepositoryImpl implements IWatchlistPricesRepository {
  final IWatchlistPricesRemoteDataSource _remoteDataSource;

  WatchlistPricesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<WatchlistStockPrice>>> getWatchlistPrices(
    List<String> tickers,
  ) async {
    try {
      final dtos = await _remoteDataSource.getWatchlistPrices(tickers);
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e, s) {
      _logger.severe('Failed to get watchlist prices', e, s);
      return Left(Failure.server(e.toString()));
    }
  }
}
