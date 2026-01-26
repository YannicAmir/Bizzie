import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/dividends/domain/interfaces/i_dividend_repository.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_event.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_info.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDividendRepository)
class DividendRepositoryImpl implements IDividendRepository {
  final CompanyRemoteDataSource _remoteDataSource;
  final CompanyFirestoreDataSource _localDataSource;

  DividendRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, DividendInfo>> getDividendInfo(String ticker) async {
    try {
      var local = await _localDataSource.getCachedDividends(ticker);
      if (local == null) {
        local = await _remoteDataSource.getDividends(ticker);
        await _localDataSource.cacheDividends(ticker, local);
      }
      return right(
        DividendInfo(
          symbol: ticker,
          history: local
              .map(
                (e) => DividendEvent(
                  date: e.date,
                  dividend: e.dividend ?? 0.0,
                  adjDividend: e.adjDividend ?? 0.0,
                  recordDate: e.recordDate,
                  paymentDate: e.paymentDate,
                  declarationDate: e.declarationDate,
                  frequency: e.frequency,
                  yield: e.yield,
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
