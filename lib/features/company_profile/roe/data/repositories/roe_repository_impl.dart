import 'package:bizzie/core/enums/data_origin.dart';
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
  Future<Either<Failure, (List<Roe>, CompanyProfileDataOrigin)>> getRoeMetrics(
    String ticker, {
    String period = 'annual',
  }) async {
    try {
      final res = await _localDataSource.syncKeyMetrics(
        ticker,
        isTtm: period == _Consts.ttm,
        remoteFetcher: () => _remoteDataSource.getKeyMetrics(ticker),
      );

      return res.map(
        success: (s) =>
            right((s.data.map((d) => d.toRoe()).toList(), s.origin)),
        failure: (f) => left(f.failure),
        notFound: (_) => right((const <Roe>[], CompanyProfileDataOrigin.cache)),
      );
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }
}
