import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/market_dtos.dart';
import 'package:bizzie/features/company_profile/news/data/repositories/news_repository_impl.dart';
import 'package:bizzie/features/company_profile/news/domain/models/company_news.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements CompanyRemoteDataSource {}

class MockLocalDataSource extends Mock implements CompanyFirestoreDataSource {}

void main() {
  late NewsRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
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
    test('getCompanyNews_cacheHit_returnsLocalData', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedStockNews(tTicker),
      ).thenAnswer((_) async => tNewsList);

      // act
      final result = await repository.getCompanyNews(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, isA<CompanyNews>());
        expect(r.symbol, tTicker);
        expect(r.articles.length, 1);
        expect(r.articles.first.title, 'Apple News');
      });
      verify(() => mockLocalDataSource.getCachedStockNews(tTicker)).called(1);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test(
      'getCompanyNews_cacheMiss_fetchesRemoteAndCaches_returnsData',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getCachedStockNews(tTicker),
        ).thenAnswer((_) async => null);
        when(
          () => mockRemoteDataSource.getStockNews(tTicker),
        ).thenAnswer((_) async => tNewsList);
        when(
          () => mockLocalDataSource.cacheStockNews(tTicker, tNewsList),
        ).thenAnswer((_) async => Future.value());

        // act
        final result = await repository.getCompanyNews(tTicker);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('Should return right'), (r) {
          expect(r, isA<CompanyNews>());
          expect(r.articles.first.title, 'Apple News');
        });
        verify(() => mockLocalDataSource.getCachedStockNews(tTicker)).called(1);
        verify(() => mockRemoteDataSource.getStockNews(tTicker)).called(1);
        verify(
          () => mockLocalDataSource.cacheStockNews(tTicker, tNewsList),
        ).called(1);
      },
    );

    test('getCompanyNews_serverFailure_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedStockNews(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getStockNews(tTicker),
      ).thenThrow(Exception('Server Error'));

      // act
      final result = await repository.getCompanyNews(tTicker);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should return left'),
      );
    });
  });
}
