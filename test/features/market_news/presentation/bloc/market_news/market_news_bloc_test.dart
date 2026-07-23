import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:bizzie/features/market_news/domain/usecases/watch_market_news_usecase.dart';
import 'package:bizzie/features/market_news/presentation/bloc/market_news/market_news_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchMarketNewsUseCase extends Mock
    implements WatchMarketNewsUseCase {}

const tFailure = Failure.server('error');

final tArticle = MarketNewsArticle(
  id: 'news_1',
  title: 'Article',
  site: 'reuters.com',
  publisher: 'Reuters',
  url: 'https://reuters.com/article',
  publishedAt: DateTime.utc(2026, 7, 15, 10),
);

void main() {
  late MarketNewsBloc bloc;
  late MockWatchMarketNewsUseCase mockWatchMarketNews;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockWatchMarketNews = MockWatchMarketNewsUseCase();
    bloc = MarketNewsBloc(mockWatchMarketNews);
  });

  tearDown(() => bloc.close());

  group('MarketNewsBloc', () {
    test('initialState_isCorrect', () {
      // assert
      expect(bloc.state, const MarketNewsState.initial());
    });

    group('loadRequested', () {
      blocTest<MarketNewsBloc, MarketNewsState>(
        'loadRequested_useCaseEmitsRight_emitsLoadingAndLoaded',
        build: () {
          // arrange
          when(
            () => mockWatchMarketNews(any()),
          ).thenAnswer((_) => Stream.value(Right([tArticle])));
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const MarketNewsEvent.loadRequested());
        },
        // assert
        expect: () => [
          const MarketNewsState.loading(),
          MarketNewsState.loaded([tArticle]),
        ],
      );

      blocTest<MarketNewsBloc, MarketNewsState>(
        'loadRequested_useCaseEmitsLeft_emitsLoadingAndFailure',
        build: () {
          // arrange
          when(
            () => mockWatchMarketNews(any()),
          ).thenAnswer((_) => Stream.value(const Left(tFailure)));
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const MarketNewsEvent.loadRequested());
        },
        // assert
        expect: () => [
          const MarketNewsState.loading(),
          const MarketNewsState.failure(tFailure),
        ],
      );

      blocTest<MarketNewsBloc, MarketNewsState>(
        'loadRequested_useCaseStreamThrows_emitsLoadingAndServerFailure',
        build: () {
          // arrange
          when(
            () => mockWatchMarketNews(any()),
          ).thenAnswer((_) => Stream.error(Exception('boom')));
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const MarketNewsEvent.loadRequested());
        },
        // assert
        expect: () => [
          const MarketNewsState.loading(),
          const MarketNewsState.failure(
            Failure.server('Unable to load market news'),
          ),
        ],
      );
    });
  });
}
