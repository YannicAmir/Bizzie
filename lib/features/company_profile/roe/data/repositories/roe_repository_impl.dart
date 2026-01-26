import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/key_metrics_dto.dart';
import '../../domain/interfaces/i_roe_repository.dart';
import '../../domain/models/roe.dart';

abstract class _Consts {
  static const String ttm = 'ttm';
}

@LazySingleton(as: IRoeRepository)
class RoeRepositoryImpl implements IRoeRepository {
  final CompanyRemoteDataSource _remoteDataSource;
  final CompanyFirestoreDataSource _localDataSource;

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
      if (local != null) return right(local.map(_toRoe).toList());

      final remote = await _remoteDataSource.getKeyMetrics(ticker);

      await _localDataSource.cacheKeyMetrics(ticker, remote, isTtm: false);
      return right(remote.map(_toRoe).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Roe _toRoe(KeyMetricsDto d) {
    return Roe(
      symbol: d.symbol ?? '',
      date: d.date ?? '',
      period: d.period ?? '',
      returnOnEquity: d.returnOnEquity ?? 0,
    );
  }
}
