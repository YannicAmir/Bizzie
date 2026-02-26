import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/dividends/data/datasources/dividends_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/dividends/data/datasources/dividends_remote_data_source.dart';
import 'package:bizzie/features/company_profile/dividends/domain/interfaces/i_dividend_repository.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_info.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDividendRepository)
class DividendRepositoryImpl implements IDividendRepository {
  final DividendsRemoteDataSource _remoteDataSource;
  final DividendsFirestoreDataSource _localDataSource;

  DividendRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, (DividendInfo, CompanyProfileDataOrigin)>>
  getDividendInfo(String ticker) async {
    try {
      final res = await _localDataSource.syncDividends(
        ticker,
        remoteFetcher: () => _remoteDataSource.getDividends(ticker),
      );

      return res.map(
        success: (s) => right((
          DividendInfo(
            symbol: ticker,
            history: s.data.map((e) => e.toDomain()).toList(),
          ),
          s.origin,
        )),
        failure: (f) => left(f.failure),
        notFound: (_) => right((
          DividendInfo(symbol: ticker, history: const []),
          CompanyProfileDataOrigin.cache,
        )),
      );
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }
}
