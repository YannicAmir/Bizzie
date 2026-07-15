import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/news/domain/models/company_news.dart';
import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';
import 'package:bizzie/features/company_profile/news/domain/usecases/get_company_news_usecase.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_bloc.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_event.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_state.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/features/company_profile/news/presentation/analytics/news_tab_analytics.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';

class MockGetCompanyNewsUseCase extends Mock implements GetCompanyNewsUseCase {}

class MockNewsTabAnalytics extends Mock implements NewsTabAnalytics {}

class MockWatchActiveTabUseCase extends Mock implements WatchActiveTabUseCase {}

class MockGetAuthStream extends Mock implements GetAuthStream {}

MockGetAuthStream stubbedGetAuthStream() {
  final mock = MockGetAuthStream();
  when(() => mock()).thenAnswer((_) => const Stream.empty());
  return mock;
}

class MockTimeProvider extends Mock implements ITimeProvider {}

MockTimeProvider stubbedTimeProvider() {
  final mock = MockTimeProvider();
  when(() => mock.nowLocal).thenAnswer((_) => DateTime.now());
  return mock;
}

void main() {
  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  late CompanyNewsBloc bloc;
  late MockGetCompanyNewsUseCase mockGetCompanyNews;
  late MockNewsTabAnalytics mockAnalytics;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;

  setUp(() {
    mockGetCompanyNews = MockGetCompanyNewsUseCase();
    mockAnalytics = MockNewsTabAnalytics();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();
    when(
      () => mockWatchActiveTabUseCase(any()),
    ).thenAnswer((_) => const Stream.empty());
    bloc = CompanyNewsBloc(
      mockGetCompanyNews,
      mockAnalytics,
      mockWatchActiveTabUseCase,
      stubbedTimeProvider(),
      stubbedGetAuthStream(),
    );
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
        when(() => mockGetCompanyNews(tTicker)).thenAnswer(
          (_) async =>
              const Right((tCompanyNews, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyNewsEvent.loadRequested(tTicker));
      },
      expect: () => [
        const CompanyNewsState.loading(),
        isA<CompanyNewsState>().having(
          (s) => s.maybeMap(
            loaded: (l) =>
                l.ticker == tTicker &&
                l.dataOrigin == CompanyProfileDataOrigin.api,
            orElse: () => false,
          ),
          'loaded with correct ticker and origin',
          true,
        ),
      ],
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
      expect: () => [
        const CompanyNewsState.loading(),
        const CompanyNewsState.failure(Failure.server('Server error')),
      ],
    );

    blocTest<CompanyNewsBloc, CompanyNewsState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyNewsState.loaded(
        articles: tNewsArticles,
        ticker: tTicker,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyNewsEvent.loadRequested(tTicker));
      },
      expect: () => [],
      verify: (_) {
        // assert
        verifyNever(() => mockGetCompanyNews(any()));
      },
    );

    blocTest<CompanyNewsBloc, CompanyNewsState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // arrange
        when(() => mockGetCompanyNews('MSFT')).thenAnswer(
          (_) async => const Right((
            CompanyNews(
              symbol: 'MSFT',
              articles: [
                NewsArticle(
                  title: 'Microsoft News',
                  publishedDate: '2023-01-01',
                  site: 'TechCrunch',
                  url: 'https://microsoft.com',
                ),
              ],
            ),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      seed: () => CompanyNewsState.loaded(
        articles: tNewsArticles,
        ticker: 'AAPL',
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyNewsEvent.loadRequested('MSFT'));
      },
      expect: () => [
        const CompanyNewsState.loading(),
        isA<CompanyNewsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );

    blocTest<CompanyNewsBloc, CompanyNewsState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadedOnly',
      build: () {
        // arrange
        when(() => mockGetCompanyNews(tTicker)).thenAnswer(
          (_) async =>
              const Right((tCompanyNews, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyNewsState.loaded(
        articles: tNewsArticles,
        ticker: tTicker,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyNewsEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () => [
        const CompanyNewsState.loading(),
        isA<CompanyNewsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
      verify: (_) {
        // assert
        verify(() => mockGetCompanyNews(tTicker)).called(1);
      },
    );
  });

  group('CompanyNewsBloc - stalenessCheckRequested', () {
    blocTest<CompanyNewsBloc, CompanyNewsState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockGetCompanyNews(tTicker)).thenAnswer(
          (_) async =>
              const Right((tCompanyNews, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyNewsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () => [
        const CompanyNewsState.loading(),
        isA<CompanyNewsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
    );

    blocTest<CompanyNewsBloc, CompanyNewsState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyNewsState.loaded(
        articles: tNewsArticles,
        ticker: tTicker,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyNewsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () => [],
      verify: (_) {
        // assert
        verifyNever(() => mockGetCompanyNews(any()));
      },
    );

    blocTest<CompanyNewsBloc, CompanyNewsState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockGetCompanyNews(tTicker)).thenAnswer(
          (_) async =>
              const Right((tCompanyNews, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyNewsState.loaded(
        articles: tNewsArticles,
        ticker: tTicker,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(minutes: 6)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyNewsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () => [
        const CompanyNewsState.loading(),
        isA<CompanyNewsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
    );
  });
}
