import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/news/domain/models/company_news.dart';
import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';
import 'package:bizzie/features/company_profile/news/domain/usecases/get_company_news_usecase.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_bloc.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_event.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCompanyNewsUseCase extends Mock implements GetCompanyNewsUseCase {}

void main() {
  late CompanyNewsBloc bloc;
  late MockGetCompanyNewsUseCase mockGetCompanyNews;

  setUp(() {
    mockGetCompanyNews = MockGetCompanyNewsUseCase();
    bloc = CompanyNewsBloc(mockGetCompanyNews);
  });

  const tTicker = 'AAPL';
  const tNewsArticles = [
    NewsArticle(
      title: 'Apple News',
      publishedDate: '2023-01-01',
      site: 'TechCrunch',
      url: 'https://apple.com',
    ),
  ];
  const tCompanyNews = CompanyNews(symbol: tTicker, articles: tNewsArticles);

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyNewsState.initial());
  });

  group('CompanyNewsBloc - loadRequested', () {
    blocTest<CompanyNewsBloc, CompanyNewsState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetCompanyNews(tTicker),
        ).thenAnswer((_) async => const Right(tCompanyNews));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyNewsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyNewsState.loading(),
          isA<CompanyNewsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.news, orElse: () => null),
            'news',
            tNewsArticles,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetCompanyNews(tTicker)).called(1);
      },
    );

    blocTest<CompanyNewsBloc, CompanyNewsState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetCompanyNews(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyNewsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyNewsState.loading(),
          const CompanyNewsState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanyNewsBloc, CompanyNewsState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyNewsState.loaded(tNewsArticles),
      act: (bloc) {
        // act
        bloc.add(const CompanyNewsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetCompanyNews(any()));
      },
    );

    blocTest<CompanyNewsBloc, CompanyNewsState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetCompanyNews(tTicker),
        ).thenAnswer((_) async => const Right(tCompanyNews));
        return bloc;
      },
      seed: () => const CompanyNewsState.loaded(tNewsArticles),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyNewsEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyNewsState.loading(),
          isA<CompanyNewsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.news, orElse: () => null),
            'news',
            tNewsArticles,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetCompanyNews(tTicker)).called(1);
      },
    );
    group('CompanyNewsBloc - stalenessCheckRequested', () {
      blocTest<CompanyNewsBloc, CompanyNewsState>(
        'stalenessCheckRequested_initialState_triggersLoadRequested',
        build: () {
          // arrange
          when(
            () => mockGetCompanyNews(tTicker),
          ).thenAnswer((_) async => const Right(tCompanyNews));
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const CompanyNewsEvent.stalenessCheckRequested(tTicker));
        },
        expect: () {
          // assert
          return [
            const CompanyNewsState.loading(),
            isA<CompanyNewsState>().having(
              (s) => s.maybeMap(loaded: (l) => l.news, orElse: () => null),
              'news',
              tNewsArticles,
            ),
          ];
        },
      );

      blocTest<CompanyNewsBloc, CompanyNewsState>(
        'stalenessCheckRequested_fresh_doesNotTriggerLoad',
        build: () {
          // arrange
          return bloc;
        },
        seed: () =>
            CompanyNewsState.loaded(tNewsArticles, lastUpdated: DateTime.now()),
        act: (bloc) {
          // act
          bloc.add(const CompanyNewsEvent.stalenessCheckRequested(tTicker));
        },
        expect: () {
          // assert
          return [];
        },
        verify: (_) {
          // assert
          verifyNever(() => mockGetCompanyNews(any()));
        },
      );

      blocTest<CompanyNewsBloc, CompanyNewsState>(
        'stalenessCheckRequested_stale_triggersLoadRequested',
        build: () {
          // arrange
          when(
            () => mockGetCompanyNews(tTicker),
          ).thenAnswer((_) async => const Right(tCompanyNews));
          return bloc;
        },
        seed: () => CompanyNewsState.loaded(
          tNewsArticles,
          lastUpdated: DateTime.now().subtract(const Duration(minutes: 6)),
        ),
        act: (bloc) {
          // act
          bloc.add(const CompanyNewsEvent.stalenessCheckRequested(tTicker));
        },
        expect: () {
          // assert
          return [
            const CompanyNewsState.loading(),
            isA<CompanyNewsState>().having(
              (s) => s.maybeMap(loaded: (l) => l.news, orElse: () => null),
              'news',
              tNewsArticles,
            ),
          ];
        },
      );
    });
  });
}
