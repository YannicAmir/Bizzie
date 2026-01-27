import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_remote_data_source.dart';
import '../../domain/interfaces/i_pe_ratio_repository.dart';
import '../../domain/models/pe_ratio.dart';

abstract class _Consts {
  static const String ttm = 'ttm';
}

@LazySingleton(as: IPeRatioRepository)
class PeRatioRepositoryImpl implements IPeRatioRepository {
  final RatiosRemoteDataSource _remoteDataSource;
  final RatiosFirestoreDataSource _localDataSource;

  PeRatioRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<PeRatio>>> getPeRatios(
    String ticker, {
    String period = 'annual',
  }) async {
    try {
      final local = await _localDataSource.getCachedRatios(
        ticker,
        isTtm: period == _Consts.ttm,
      );
      if (local != null) return right(local.map((d) => d.toPeRatio()).toList());

      final remote = await _remoteDataSource.getRatios(ticker);

      await _localDataSource.cacheRatios(ticker, remote, isTtm: false);
      return right(remote.map((d) => d.toPeRatio()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
