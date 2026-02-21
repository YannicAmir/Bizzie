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

    group('Real-time Updates', () {
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
