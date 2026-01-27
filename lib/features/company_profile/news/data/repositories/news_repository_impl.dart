import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/news/data/datasources/news_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/news/data/datasources/news_remote_data_source.dart';
import 'package:bizzie/features/company_profile/news/data/dtos/news_dto.dart';
import 'package:bizzie/features/company_profile/news/domain/interfaces/i_news_repository.dart';
import 'package:bizzie/features/company_profile/news/domain/models/company_news.dart';

@LazySingleton(as: INewsRepository)
class NewsRepositoryImpl implements INewsRepository {
  final NewsRemoteDataSource _remoteDataSource;
  final NewsFirestoreDataSource _localDataSource;

  NewsRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, CompanyNews>> getCompanyNews(String ticker) async {
    try {
      var local = await _localDataSource.getCachedStockNews(ticker);
      if (local == null) {
        local = await _remoteDataSource.getStockNews(ticker);
        await _localDataSource.cacheStockNews(ticker, local);
      }

      return right(
        CompanyNews(
          symbol: ticker,
          articles: local.map((NewsDto e) => e.toDomain()).toList(),
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
