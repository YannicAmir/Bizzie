import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/ratios_dto.dart';
import '../../domain/interfaces/i_pe_ratio_repository.dart';
import '../../domain/models/pe_ratio.dart';

abstract class _Consts {
  static const String ttm = 'ttm';
}

@LazySingleton(as: IPeRatioRepository)
class PeRatioRepositoryImpl implements IPeRatioRepository {
  final CompanyRemoteDataSource _remoteDataSource;
  final CompanyFirestoreDataSource _localDataSource;

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
      if (local != null) return right(local.map(_toPeRatio).toList());

      final remote = await _remoteDataSource.getRatios(ticker);

      await _localDataSource.cacheRatios(ticker, remote, isTtm: false);
      return right(remote.map(_toPeRatio).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  PeRatio _toPeRatio(RatiosDto d) {
    return PeRatio(
      symbol: d.symbol ?? '',
      date: d.date ?? '',
      period: d.period ?? '',
      priceToEarningsRatio: d.priceToEarningsRatio ?? 0,
    );
  }
}
