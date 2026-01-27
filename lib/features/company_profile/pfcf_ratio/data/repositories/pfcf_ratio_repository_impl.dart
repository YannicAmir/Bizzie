import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_remote_data_source.dart';
import '../../domain/interfaces/i_pfcf_ratio_repository.dart';
import '../../domain/models/pfcf_ratio.dart';

abstract class _Consts {
  static const String ttm = 'ttm';
}

@LazySingleton(as: IPfcfRatioRepository)
class PfcfRatioRepositoryImpl implements IPfcfRatioRepository {
  final RatiosRemoteDataSource _remoteDataSource;
  final RatiosFirestoreDataSource _localDataSource;

  PfcfRatioRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<PfcfRatio>>> getPfcfRatios(
    String ticker, {
    String period = 'annual',
  }) async {
    try {
      final local = await _localDataSource.getCachedRatios(
        ticker,
        isTtm: period == _Consts.ttm,
      );
      if (local != null) {
        return right(local.map((d) => d.toPfcfRatio()).toList());
      }

      final remote = await _remoteDataSource.getRatios(ticker);

      await _localDataSource.cacheRatios(ticker, remote, isTtm: false);
      return right(remote.map((d) => d.toPfcfRatio()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
