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
      'watchlistTapped_callsLogHomeWatchlistTapped',
      build: () {
        // arrange
        when(
          () => mockAnalytics.logHomeWatchlistTapped(
            ticker: any(named: 'ticker'),
            eventText: any(named: 'eventText'),
            isUpcoming: any(named: 'isUpcoming'),
          ),
        ).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) => bloc.add(
        const HomeEvent.watchlistTapped(
          ticker: 'AAPL',
          eventText: 'Earnings',
          isUpcoming: true,
        ),
      ),
      // assert
      verify: (_) {
        verify(
          () => mockAnalytics.logHomeWatchlistTapped(
            ticker: 'AAPL',
            eventText: 'Earnings',
            isUpcoming: true,
          ),
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
      'watchlistLoaded_callsLogHomeWatchlistLoadedOnlyOnce_Indempotency',
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
        bloc.add(const HomeEvent.watchlistLoaded(itemCount: 3));
        bloc.add(const HomeEvent.watchlistLoaded(itemCount: 3));
      },
      // assert
      verify: (_) {
        verify(
          () => mockAnalytics.logHomeWatchlistLoaded(
            itemCount: 3,
            durationMs: any(named: 'durationMs'),
          ),
        ).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'watchlistLoaded_callsLogHomeWatchlistLoadedAgain_AfterStartedReset',
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
        bloc.add(const HomeEvent.watchlistLoaded(itemCount: 3));
        bloc.add(const HomeEvent.started());
        bloc.add(const HomeEvent.watchlistLoaded(itemCount: 5));
      },
      // assert
      verify: (_) {
        verify(
          () => mockAnalytics.logHomeWatchlistLoaded(
            itemCount: 3,
            durationMs: any(named: 'durationMs'),
          ),
        ).called(1);
        verify(
          () => mockAnalytics.logHomeWatchlistLoaded(
            itemCount: 5,
            durationMs: any(named: 'durationMs'),
          ),
        ).called(1);
      },
    );
    group('Real-time Updates', () {
      blocTest<HomeBloc, HomeState>(
        'watchlistLoaded_continuousStream_callsLogHomeWatchlistLoadedOnlyOnce',
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
          bloc.add(const HomeEvent.watchlistLoaded(itemCount: 1));
          bloc.add(const HomeEvent.watchlistLoaded(itemCount: 1));
          bloc.add(const HomeEvent.watchlistLoaded(itemCount: 1));
        },
        // assert
        verify: (_) {
          verify(
            () => mockAnalytics.logHomeWatchlistLoaded(
              itemCount: 1,
              durationMs: any(named: 'durationMs'),
            ),
          ).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'watchlistTapped_defensive_truncation_is_handled_by_ui_but_bloc_passes_through',
        build: () {
          when(
            () => mockAnalytics.logHomeWatchlistTapped(
              ticker: any(named: 'ticker'),
              eventText: any(named: 'eventText'),
              isUpcoming: any(named: 'isUpcoming'),
            ),
          ).thenAnswer((_) async {});
          return bloc;
        },
        act: (bloc) => bloc.add(
          const HomeEvent.watchlistTapped(
            ticker: 'AAPL',
            eventText: 'Very Long Earnings Name That Should Be Truncated',
            isUpcoming: true,
          ),
        ),
        verify: (_) {
          verify(
            () => mockAnalytics.logHomeWatchlistTapped(
              ticker: 'AAPL',
              eventText: 'Very Long Earnings Name That Should Be Truncated',
              isUpcoming: true,
            ),
          ).called(1);
        },
      );
    });
  });
}
