import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/news/data/datasources/news_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/news/data/datasources/news_remote_data_source.dart';
import 'package:bizzie/features/company_profile/news/data/dtos/news_dto.dart';
import 'package:bizzie/features/company_profile/news/data/repositories/news_repository_impl.dart';
import 'package:bizzie/features/company_profile/news/domain/models/company_news.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as cache;

class MockNewsRemoteDataSource extends Mock implements NewsRemoteDataSource {}

class MockNewsLocalDataSource extends Mock implements NewsFirestoreDataSource {}

void main() {
  late NewsRepositoryImpl repository;
  late MockNewsRemoteDataSource mockRemoteDataSource;
  late MockNewsLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockNewsRemoteDataSource();
    mockLocalDataSource = MockNewsLocalDataSource();
    repository = NewsRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  const tTicker = 'AAPL';
  final tNewsDto = NewsDto(
    symbol: tTicker,
    publishedDate: '2023-01-01',
    title: 'Apple News',
    image: 'https://example.com/image.png',
    site: 'TechCrunch',
    url: 'https://example.com/news',
    text: 'Some news text',
  );
  final tNewsList = [tNewsDto];

  group('NewsRepositoryImpl', () {
    test('getCompanyNews_success_returnsData', () async {
      // arrange
      when(
        () => mockLocalDataSource.syncStockNews(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async =>
            cache.CacheSuccess(tNewsList, CompanyProfileDataOrigin.api),
      );

      // act
      final resultData = await repository.getCompanyNews(tTicker);

      // assert
      expect(resultData.isRight(), true);
      resultData.fold((l) => fail('Should return right'), (tuple) {
        final r = tuple.$1;
        final origin = tuple.$2;
        expect(r, isA<CompanyNews>());
        expect(origin, CompanyProfileDataOrigin.api);
        expect(r.articles.first.title, 'Apple News');
      });
    });

    test('getCompanyNews_failure_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.syncStockNews(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async => const cache.CacheFailure(Failure.server('error')),
      );

      // act
      final resultData = await repository.getCompanyNews(tTicker);

      // assert
      expect(resultData.isLeft(), true);
    });
  });
}
