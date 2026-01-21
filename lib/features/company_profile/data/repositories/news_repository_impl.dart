import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/market_dtos.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_news_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/company_news.dart';
import 'package:bizzie/features/company_profile/domain/models/news_article.dart';

@LazySingleton(as: INewsRepository)
class NewsRepositoryImpl implements INewsRepository {
  final CompanyRemoteDataSource _remoteDataSource;
  final CompanyFirestoreDataSource _localDataSource;

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
          articles: local.map(_toNewsArticle).toList(),
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  NewsArticle _toNewsArticle(NewsDto e) {
    return NewsArticle(
      title: e.title,
      publishedDate: e.publishedDate,
      site: e.site,
      url: e.url,
      image: e.image,
      text: e.text,
    );
  }
}
