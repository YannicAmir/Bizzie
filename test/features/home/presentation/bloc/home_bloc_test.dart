import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/features/home/presentation/analytics/home_analytics.dart';
import 'package:bizzie/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeAnalytics extends Mock implements HomeAnalytics {}

void main() {
  late HomeBloc bloc;
  late MockHomeAnalytics mockAnalytics;

  setUp(() {
    mockAnalytics = MockHomeAnalytics();
    bloc = HomeBloc(mockAnalytics);
  });

  tearDown(() {
    bloc.close();
  });

  group('HomeBloc', () {
    test('initialState_isInitial', () {
      // assert
      expect(bloc.state, const HomeState.initial());
    });

    blocTest<HomeBloc, HomeState>(
      'started_callsLogHomeViewed',
      build: () {
        // arrange
        when(() => mockAnalytics.logHomeViewed()).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) => bloc.add(const HomeEvent.started()),
      // assert
      verify: (_) {
        verify(() => mockAnalytics.logHomeViewed()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'searchTapped_emitsNothing',
      build: () => bloc,
      act: (bloc) => bloc.add(const HomeEvent.searchTapped()),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockAnalytics.logHomeViewed());
      },
    );

    blocTest<HomeBloc, HomeState>(
      'watchlistTapped_callsLogHomeWatchlistTapped',
      build: () {
        // arrange
        when(
          () => mockAnalytics.logHomeWatchlistTapped(
            ticker: any(named: 'ticker'),
          ),
        ).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) => bloc.add(const HomeEvent.watchlistTapped(ticker: 'AAPL')),
      // assert
      verify: (_) {
        verify(
          () => mockAnalytics.logHomeWatchlistTapped(ticker: 'AAPL'),
        ).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emptyStateViewed_callsLogHomeEmptyStateViewed',
      build: () {
        // arrange
        when(
          () => mockAnalytics.logHomeEmptyStateViewed(),
        ).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) => bloc.add(const HomeEvent.emptyStateViewed()),
      // assert
      verify: (_) {
        verify(() => mockAnalytics.logHomeEmptyStateViewed()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'watchlistLoadFailed_callsLogHomeWatchlistError',
      build: () {
        // arrange
        when(
          () => mockAnalytics.logHomeWatchlistError(
            message: any(named: 'message'),
          ),
        ).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const HomeEvent.watchlistLoadFailed(error: 'Fail')),
      // assert
      verify: (_) {
        verify(
          () => mockAnalytics.logHomeWatchlistError(message: 'Fail'),
        ).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'watchlistLoaded_callsLogHomeWatchlistLoadedWithDuration',
      build: () {
        // arrange
        when(() => mockAnalytics.logHomeViewed()).thenAnswer((_) async {});
        when(
          () => mockAnalytics.logHomeWatchlistLoaded(
            itemCount: any(named: 'itemCount'),
            durationMs: any(named: 'durationMs'),
          ),
        ).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const HomeEvent.started());
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(const HomeEvent.watchlistLoaded(itemCount: 3));
      },
      // assert
      verify: (_) {
        verify(
          () => mockAnalytics.logHomeWatchlistLoaded(
            itemCount: 3,
            durationMs: any(
              named: 'durationMs',
              that: greaterThanOrEqualTo(100),
            ),
          ),
        ).called(1);
      },
    );
  });
}
