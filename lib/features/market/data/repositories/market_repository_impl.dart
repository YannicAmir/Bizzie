import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/market/data/datasources/market_local_datasource.dart';
import 'package:bizzie/features/market/data/datasources/market_remote_datasource.dart';
import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:bizzie/features/market/data/dtos/market_data_snapshot.dart';
import 'package:bizzie/features/market/domain/interfaces/i_market_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('MarketRepository');

@LazySingleton(as: IMarketRepository)
class MarketRepositoryImpl implements IMarketRepository {
  final MarketRemoteDataSource _remoteDataSource;
  final MarketLocalDataSource _localDataSource;

  MarketRepositoryImpl(this._remoteDataSource, this._localDataSource);

  Future<MarketDataSnapshot> _getSnapshot() async {
    final localData = await _localDataSource.getLastKnownMarketData();
    final now = DateTime.now().millisecondsSinceEpoch;
    final ttl = const Duration(hours: 12).inMilliseconds;

    if (localData != null) {
      final age = now - localData.cacheTimestamp;
      if (age < ttl) {
        _logger.info(
          'Serving fresh market data from cache (date: ${localData.date})',
        );
        return localData;
      }
      _logger.info(
        'Cache is stale. Serving cached data and verifying remote in background.',
      );
      _refreshRemoteData();
      return localData;
    }

    return _fetchAndCacheRemote();
  }

  Future<MarketDataSnapshot> _fetchAndCacheRemote() async {
    try {
      final remoteData = await _remoteDataSource.getMarketDataSnapshot();
      await _localDataSource.cacheMarketData(remoteData);
      _logger.info('Successfully fetched and cached remote market data');
      return remoteData;
    } catch (e) {
      _logger.warning(
        'Remote fetch failed, checking for any cached fallback',
        e,
      );
      final localData = await _localDataSource.getLastKnownMarketData();
      if (localData != null) {
        _logger.warning('Serving STALE market data due to remote failure');
        return localData;
      }
      rethrow;
    }
  }

  Future<void> _refreshRemoteData() async {
    try {
      final remoteData = await _remoteDataSource.getMarketDataSnapshot();
      await _localDataSource.cacheMarketData(remoteData);
    } catch (e) {
      _logger.warning('Background refresh failed', e);
    }
  }

  @override
  Future<Either<Failure, List<SectorPe>>> getSectorPeList() async {
    _logger.info('Getting Sector PE List');
    try {
      final snapshot = await _getSnapshot();
      final entities = snapshot.peList.map((e) => e.toDomain()).toList();
      return Right(entities);
    } catch (e, s) {
      _logger.severe('Failed to get Sector PE List', e, s);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SectorPerformance>>>
  getSectorPerformanceList() async {
    _logger.info('Getting Sector Performance List');
    try {
      final snapshot = await _getSnapshot();
      final entities = snapshot.performanceList
          .map((e) => e.toDomain())
          .toList();
      return Right(entities);
    } catch (e, s) {
      _logger.severe('Failed to get Sector Performance List', e, s);
      return Left(ServerFailure(e.toString()));
    }
  }
}
