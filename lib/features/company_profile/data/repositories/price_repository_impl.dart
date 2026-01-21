import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_price_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/data/dtos/historical_price_eod_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/market_dtos.dart';
import 'package:bizzie/features/company_profile/domain/models/price_history.dart';
import 'package:bizzie/features/company_profile/domain/models/price_point.dart';

@LazySingleton(as: IPriceRepository)
class PriceRepositoryImpl implements IPriceRepository {
  final CompanyRemoteDataSource _remoteDataSource;
  final CompanyFirestoreDataSource _localDataSource;

  PriceRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, PriceHistory>> getPriceHistory(String ticker) async {
    try {
      var local = await _localDataSource.getCachedPrices(ticker);
      if (local == null) {
        local = await _remoteDataSource.getHistoricalPrice(ticker);
        await _localDataSource.cachePrices(ticker, local);
      }
      return right(
        PriceHistory(
          symbol: ticker,
          history: local.map(_toPricePoint).toList(),
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  PricePoint _toPricePoint(HistoricalPriceDto e) {
    return PricePoint(date: e.date, close: e.price ?? 0, volume: e.volume);
  }

  @override
  Future<Either<Failure, List<HistoricalPriceEod>>> getHistoricalEodPrices(
    String ticker,
  ) async {
    try {
      final local = await _localDataSource.getCachedHistoricalEodPrices(ticker);
      if (local != null) {
        return right(local.map((e) => e.toDomain()).toList());
      }

      final dtos = await _remoteDataSource.getHistoricalEodPrices(ticker);
      await _localDataSource.cacheHistoricalEodPrices(ticker, dtos);

      return right(dtos.map((e) => e.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
