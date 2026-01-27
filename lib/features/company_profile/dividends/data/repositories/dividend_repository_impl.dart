import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/dividends/data/datasources/dividends_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/dividends/data/datasources/dividends_remote_data_source.dart';
import 'package:bizzie/features/company_profile/dividends/data/dtos/dividend_dto.dart';
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
  Future<Either<Failure, DividendInfo>> getDividendInfo(String ticker) async {
    try {
      List<DividendDto>? cached = await _localDataSource.getCachedDividends(
        ticker,
      );
      if (cached != null) {
        return right(
          DividendInfo(
            symbol: ticker,
            history: cached.map((e) => e.toDomain()).toList(),
          ),
        );
      }

      final remote = await _remoteDataSource.getDividends(ticker);
      await _localDataSource.cacheDividends(ticker, remote);

      return right(
        DividendInfo(
          symbol: ticker,
          history: remote.map((e) => e.toDomain()).toList(),
        ),
      );
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }
}
