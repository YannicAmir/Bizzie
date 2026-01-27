import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_remote_data_source.dart';
import '../../domain/interfaces/i_roe_repository.dart';
import '../../domain/models/roe.dart';

abstract class _Consts {
  static const String ttm = 'ttm';
}

@LazySingleton(as: IRoeRepository)
class RoeRepositoryImpl implements IRoeRepository {
  final RatiosRemoteDataSource _remoteDataSource;
  final RatiosFirestoreDataSource _localDataSource;

  RoeRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<Roe>>> getRoeMetrics(
    String ticker, {
    String period = 'annual',
  }) async {
    try {
      final local = await _localDataSource.getCachedKeyMetrics(
        ticker,
        isTtm: period == _Consts.ttm,
      );
      if (local != null) return right(local.map((d) => d.toRoe()).toList());

      final remote = await _remoteDataSource.getKeyMetrics(ticker);

      await _localDataSource.cacheKeyMetrics(ticker, remote, isTtm: false);
      return right(remote.map((d) => d.toRoe()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
