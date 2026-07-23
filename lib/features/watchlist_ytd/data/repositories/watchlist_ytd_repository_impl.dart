import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/watchlist_ytd/data/interfaces/i_watchlist_ytd_remote_datasource.dart';
import 'package:bizzie/features/watchlist_ytd/domain/interfaces/i_watchlist_ytd_repository.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistYtdRepositoryImpl');

@LazySingleton(as: IWatchlistYtdRepository)
class WatchlistYtdRepositoryImpl implements IWatchlistYtdRepository {
  final IWatchlistYtdRemoteDataSource _remoteDataSource;

  WatchlistYtdRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<YtdPriceChange>>> getWatchlistYtd(
    List<String> tickers,
  ) async {
    try {
      final dtos = await _remoteDataSource.getWatchlistYtd(tickers);
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e, s) {
      _logger.severe('Failed to get watchlist YTD price change', e, s);
      return Left(Failure.server(e.toString()));
    }
  }
}
