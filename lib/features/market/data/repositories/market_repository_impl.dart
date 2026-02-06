import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/market/data/datasources/market_remote_datasource.dart';
import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:bizzie/features/market/domain/interfaces/i_market_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('MarketRepository');

@LazySingleton(as: IMarketRepository)
class MarketRepositoryImpl implements IMarketRepository {
  final MarketRemoteDataSource _remoteDataSource;

  MarketRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<SectorPe>>> getSectorPeList() async {
    _logger.info('Getting Sector PE List');
    try {
      final dtos = await _remoteDataSource.getSectorPeList();
      final entities = dtos.map((e) => e.toDomain()).toList();
      _logger.info(
        'Successfully retrieved ${entities.length} Sector PE entities',
      );
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
      final dtos = await _remoteDataSource.getSectorPerformanceList();
      final entities = dtos.map((e) => e.toDomain()).toList();
      _logger.info(
        'Successfully retrieved ${entities.length} Sector Performance entities',
      );
      return Right(entities);
    } catch (e, s) {
      _logger.severe('Failed to get Sector Performance List', e, s);
      return Left(ServerFailure(e.toString()));
    }
  }
}
