import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/stock_quote.dart';

@LazySingleton(as: ICompanyRepository)
class CompanyRepositoryImpl implements ICompanyRepository {
  final CompanyRemoteDataSource _remoteDataSource;
  final CompanyFirestoreDataSource _localDataSource;

  CompanyRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, CompanyProfile>> getProfile(String ticker) async {
    try {
      final local = await _localDataSource.getCachedProfile(ticker);
      if (local != null) return right(local.toDomain());

      final remote = await _remoteDataSource.getProfile(ticker);
      if (remote.isEmpty) {
        return left(const ServerFailure('Profile not found'));
      }
      final profile = remote.first;
      await _localDataSource.cacheProfile(ticker, profile);
      return right(profile.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StockQuote>> getQuote(String ticker) async {
    try {
      final local = await _localDataSource.getCachedQuote(ticker);
      if (local != null) return right(local.toDomain());

      final remote = await _remoteDataSource.getQuote(ticker);
      if (remote.isEmpty) {
        return left(const ServerFailure('Quote not found'));
      }
      final quote = remote.first;
      await _localDataSource.cacheQuote(ticker, quote);
      return right(quote.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
