import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/news/data/datasources/news_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/news/data/datasources/news_remote_data_source.dart';
import 'package:bizzie/features/company_profile/news/domain/interfaces/i_news_repository.dart';
import 'package:bizzie/features/company_profile/news/domain/models/company_news.dart';

@LazySingleton(as: INewsRepository)
class NewsRepositoryImpl implements INewsRepository {
  final NewsRemoteDataSource _remoteDataSource;
  final NewsFirestoreDataSource _localDataSource;

  NewsRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, (CompanyNews, CompanyProfileDataOrigin)>>
  getCompanyNews(String ticker) async {
    try {
      final res = await _localDataSource.syncStockNews(
        ticker,
        remoteFetcher: () => _remoteDataSource.getStockNews(ticker),
      );

      return res.map(
        success: (s) => right((
          CompanyNews(
            symbol: ticker,
            articles: s.data.map((e) => e.toDomain()).toList(),
          ),
          s.origin,
        )),
        failure: (f) => left(f.failure),
        notFound: (_) => right((
          CompanyNews(symbol: ticker, articles: const []),
          CompanyProfileDataOrigin.cache,
        )),
      );
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }
}
