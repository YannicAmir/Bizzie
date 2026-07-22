import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:bizzie/features/home/domain/usecases/watch_watchlist_news_usecase.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_news/watchlist_news_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchWatchlistNewsUseCase extends Mock
    implements WatchWatchlistNewsUseCase {}

class MockGetAuthStream extends Mock implements GetAuthStream {}

MockGetAuthStream stubbedGetAuthStream() {
  final mock = MockGetAuthStream();
  when(() => mock()).thenAnswer((_) => const Stream.empty());
  return mock;
}

const tTickers = ['AXP', 'NVDA'];
const tFailure = Failure.server('error');

final tArticle = WatchlistNewsArticle(
  id: 'AXP_article',
  symbol: 'AXP',
  title: 'Article',
  site: 'zacks.com',
  url: 'https://example.com/article',
  publishedAt: DateTime.utc(2026, 7, 15, 10),
);

void main() {
  late WatchlistNewsBloc bloc;
  late MockWatchWatchlistNewsUseCase mockWatchWatchlistNews;

  setUp(() {
    mockWatchWatchlistNews = MockWatchWatchlistNewsUseCase();
    bloc = WatchlistNewsBloc(mockWatchWatchlistNews, stubbedGetAuthStream());
  });

  tearDown(() => bloc.close());

  group('WatchlistNewsBloc', () {
    test('initialState_isCorrect', () {
      // assert
      expect(bloc.state, const WatchlistNewsState.initial());
    });

    group('loadRequested', () {
      blocTest<WatchlistNewsBloc, WatchlistNewsState>(
        'loadRequested_useCaseEmitsRight_emitsLoadingAndLoaded',
        build: () {
          // arrange
          when(() => mockWatchWatchlistNews(tTickers)).thenAnswer(
            (_) => Stream.value(Right([tArticle])),
          );
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistNewsEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [
          const WatchlistNewsState.loading(),
          WatchlistNewsState.loaded([tArticle]),
        ],
      );

      blocTest<WatchlistNewsBloc, WatchlistNewsState>(
        'loadRequested_useCaseEmitsLeft_emitsLoadingAndFailure',
        build: () {
          // arrange
          when(() => mockWatchWatchlistNews(tTickers)).thenAnswer(
            (_) => Stream.value(const Left(tFailure)),
          );
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistNewsEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [
          const WatchlistNewsState.loading(),
          const WatchlistNewsState.failure(tFailure),
        ],
      );

      blocTest<WatchlistNewsBloc, WatchlistNewsState>(
        'loadRequested_sameTickerSetTwice_subscribesOnlyOnce',
        build: () {
          // arrange
          when(() => mockWatchWatchlistNews(any())).thenAnswer(
            (_) => Stream.value(Right([tArticle])),
          );
          return bloc;
        },
        act: (bloc) {
          // act
          bloc
            ..add(const WatchlistNewsEvent.loadRequested(tTickers))
            ..add(const WatchlistNewsEvent.loadRequested(['NVDA', 'AXP']));
        },
        // assert
        expect: () => [
          const WatchlistNewsState.loading(),
          WatchlistNewsState.loaded([tArticle]),
        ],
        verify: (_) {
          verify(() => mockWatchWatchlistNews(any())).called(1);
        },
      );

      blocTest<WatchlistNewsBloc, WatchlistNewsState>(
        'loadRequested_changedTickerSet_resubscribesWithNewTickers',
        build: () {
          // arrange
          when(() => mockWatchWatchlistNews(any())).thenAnswer(
            (_) => Stream.value(Right([tArticle])),
          );
          return bloc;
        },
        act: (bloc) async {
          // act
          bloc.add(const WatchlistNewsEvent.loadRequested(tTickers));
          await Future<void>.delayed(Duration.zero);
          bloc.add(const WatchlistNewsEvent.loadRequested(['META']));
        },
        // assert
        expect: () => [
          const WatchlistNewsState.loading(),
          WatchlistNewsState.loaded([tArticle]),
          const WatchlistNewsState.loading(),
          WatchlistNewsState.loaded([tArticle]),
        ],
        verify: (_) {
          verify(() => mockWatchWatchlistNews(tTickers)).called(1);
          verify(() => mockWatchWatchlistNews(['META'])).called(1);
        },
      );
    });

    group('reset', () {
      blocTest<WatchlistNewsBloc, WatchlistNewsState>(
        'reset_fromLoaded_emitsInitial',
        seed: () => WatchlistNewsState.loaded([tArticle]),
        build: () => bloc,
        act: (bloc) {
          // act
          bloc.add(const WatchlistNewsEvent.reset());
        },
        // assert
        expect: () => [const WatchlistNewsState.initial()],
      );
    });
  });
}
