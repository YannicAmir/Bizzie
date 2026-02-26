import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_remote_data_source.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_price_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_eod_dto.dart';
import 'package:bizzie/features/company_profile/security/domain/models/price_history.dart';

@LazySingleton(as: IPriceRepository)
class PriceRepositoryImpl implements IPriceRepository {
  final SecurityRemoteDataSource _remoteDataSource;
  final SecurityFirestoreDataSource _localDataSource;

  PriceRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, (PriceHistory, CompanyProfileDataOrigin)>>
  getPriceHistory(String ticker) async {
    try {
      final res = await _localDataSource.syncPrices(
        ticker,
        remoteFetcher: () => _remoteDataSource.getHistoricalPrice(ticker),
      );

      return res.map(
        success: (s) => right((
          PriceHistory(
            symbol: ticker,
            history: s.data.map((e) => e.toDomain()).toList(),
          ),
          s.origin,
        )),
        failure: (f) => left(f.failure),
        notFound: (_) => right((
          PriceHistory(symbol: ticker, history: const []),
          CompanyProfileDataOrigin.cache,
        )),
      );
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, (List<HistoricalPriceEod>, CompanyProfileDataOrigin)>>
  getHistoricalEodPrices(String ticker) async {
    try {
      final res = await _localDataSource.syncHistoricalEodPrices(
        ticker,
        remoteFetcher: () => _remoteDataSource.getHistoricalEodPrices(ticker),
      );

      return res.map(
        success: (s) =>
            right((s.data.map((e) => e.toDomain()).toList(), s.origin)),
        failure: (f) => left(f.failure),
        notFound: (_) => right((
          const <HistoricalPriceEod>[],
          CompanyProfileDataOrigin.cache,
        )),
      );
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }
}
