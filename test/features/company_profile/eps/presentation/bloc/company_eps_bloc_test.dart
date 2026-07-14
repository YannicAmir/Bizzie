import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/eps/domain/models/eps_stats.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/eps/domain/usecases/get_eps_stats_usecase.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_bloc.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_event.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_state.dart';
import 'package:bizzie/features/company_profile/eps/presentation/analytics/eps_tab_analytics.dart';
import 'package:bizzie/features/company_profile/eps/presentation/analytics/eps_tab_view_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';

class MockGetEpsStatsUseCase extends Mock implements GetEpsStatsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockEpsTabAnalytics extends Mock implements EpsTabAnalytics {}

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
  late CompanyEpsBloc bloc;
  late MockGetEpsStatsUseCase mockGetEpsStatsUseCase;
  late MockConfigService mockConfigService;
  late MockEpsTabAnalytics mockAnalytics;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;

  const tTicker = 'AAPL';
  const tEpsStats = EpsStats(
    reportedCurrency: 'USD',
    annualEps: [
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 6.13),
      FinancialDataPoint(date: '2022-09-24', period: 'FY', value: 6.11),
    ],
    quarterlyEps: [
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 1.26),
    ],
  );

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(const EpsTabViewState(ticker: 'AAPL', timestamp: ''));
  });

  setUp(() {
    mockGetEpsStatsUseCase = MockGetEpsStatsUseCase();
    mockConfigService = MockConfigService();
    mockAnalytics = MockEpsTabAnalytics();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();

    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    when(
      () => mockAnalytics.logViewSummary(any(), isFinal: any(named: 'isFinal')),
    ).thenAnswer((_) async {});
    when(
      () => mockWatchActiveTabUseCase(any()),
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockGetEpsStatsUseCase(any())).thenAnswer(
      (_) async => Right((tEpsStats, CompanyProfileDataOrigin.cache)),
    );

    bloc = CompanyEpsBloc(
      mockGetEpsStatsUseCase,
      mockConfigService,
      mockAnalytics,
      mockWatchActiveTabUseCase,
      stubbedTimeProvider(),
      stubbedGetAuthStream(),
    );
  });

  test('initialState_isCorrect', () {
    // act & assert
    expect(bloc.state, const CompanyEpsState.initial());
  });

  group('CompanyEpsBloc - loadRequested', () {
    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_success_updatesAnalyticsSession',
      build: () {
        // arrange
        when(() => mockGetEpsStatsUseCase(tTicker)).thenAnswer(
          (_) async => const Right((tEpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) => bloc
        // act
        ..add(const CompanyEpsEvent.tabShown(tTicker))
        ..add(const CompanyEpsEvent.loadRequested(tTicker)),
      expect: () => [
        // assert
        const CompanyEpsState.loading(),
        isA<CompanyEpsState>()
            .having(
              (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
              'ticker',
              tTicker,
            )
            .having(
              (s) => s.maybeMap(
                loaded: (l) => l.analyticsState,
                orElse: () => null,
              ),
              'analyticsState',
              isNotNull,
            ),
      ],
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_failure_updatesAnalyticsSession',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetEpsStatsUseCase(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) => bloc
        // act
        ..add(const CompanyEpsEvent.tabShown(tTicker))
        ..add(const CompanyEpsEvent.loadRequested(tTicker)),
      skip:
          2, // tabShown triggers stalenessCheck → loadRequested → loading + failure (1st cycle)
      expect: () => [
        // assert
        const CompanyEpsState.loading(),
        const CompanyEpsState.failure(Failure.server('Server error')),
      ],
    );
  });

  group('CompanyEpsBloc - Analytics Events', () {
    final tLoadedState = CompanyEpsState.loaded(
      ticker: tTicker,
      epsStats: tEpsStats,
      annualChartData: const [],
      quarterlyChartData: const [],
      historyLimit: 7,
      dataOrigin: CompanyProfileDataOrigin.api,
      lastUpdated: DateTime.now(),
      analyticsState: const EpsTabViewState(
        ticker: tTicker,
        timestamp: '2024-01-01',
      ),
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'periodChanged_updatesAnalyticsState',
      build: () => bloc,
      seed: () => tLoadedState, // arrange
      act: (bloc) => bloc
        // act
        ..add(const CompanyEpsEvent.tabShown(tTicker))
        ..add(const CompanyEpsEvent.periodChanged(isAnnual: true)),
      expect: () => const <CompanyEpsState>[],
      verify: (bloc) {
        // assert
        expect(bloc.analyticsSession?.viewedYearlyEpsTab, isTrue);
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'periodChanged_toDifferentValue_emitsUpdatedIsAnnualView',
      build: () => bloc,
      seed: () => tLoadedState, // arrange
      act: (bloc) => bloc
        // act
        ..add(const CompanyEpsEvent.tabShown(tTicker))
        ..add(const CompanyEpsEvent.periodChanged(isAnnual: false)),
      expect: () => [
        isA<CompanyEpsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.isAnnualView, orElse: () => null),
          'isAnnualView',
          false,
        ),
      ],
      verify: (bloc) {
        // assert
        expect(bloc.analyticsSession?.viewedQtrlyEpsTab, isTrue);
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'viewAllTapped_updatesCorrectInteractionFlags',
      build: () => bloc,
      seed: () => tLoadedState, // arrange
      act: (bloc) => bloc
        // act
        ..add(const CompanyEpsEvent.tabShown(tTicker))
        ..add(
          const CompanyEpsEvent.viewAllTapped(isAnnual: true, isChart: true),
        )
        ..add(
          const CompanyEpsEvent.viewAllTapped(isAnnual: true, isChart: false),
        )
        ..add(
          const CompanyEpsEvent.viewAllTapped(isAnnual: false, isChart: true),
        )
        ..add(
          const CompanyEpsEvent.viewAllTapped(isAnnual: false, isChart: false),
        ),
      expect: () => const <CompanyEpsState>[],
      verify: (bloc) {
        // assert
        expect(bloc.analyticsSession?.tappedYrchartViewAll, isTrue);
        expect(bloc.analyticsSession?.tappedYrtableViewAll, isTrue);
        expect(bloc.analyticsSession?.tappedQtrchartViewAll, isTrue);
        expect(bloc.analyticsSession?.tappedQtrtableViewAll, isTrue);
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'tabHidden_logsViewSummary',
      build: () => bloc,
      seed: () => tLoadedState, // arrange
      act: (bloc) => bloc
        // act
        ..add(const CompanyEpsEvent.tabShown(tTicker))
        ..add(const CompanyEpsEvent.tabHidden()),
      verify: (_) {
        // assert
        verify(
          () => mockAnalytics.logViewSummary(any(), isFinal: true),
        ).called(1);
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'tabShown_recoversExistingMetrics',
      build: () => bloc,
      seed: () {
        // arrange
        final loaded = tLoadedState as dynamic;
        return loaded.copyWith(
          analyticsState: loaded.analyticsState?.copyWith(
            isSuccess: true,
            loadTimeMs: 123,
          ),
        );
      },
      act: (bloc) =>
          bloc
          // act
          .add(const CompanyEpsEvent.tabShown(tTicker)),
      expect: () => const <CompanyEpsState>[],
      verify: (bloc) {
        // assert
        expect(bloc.analyticsSession?.isSuccess, isTrue);
        expect(bloc.analyticsSession?.loadTimeMs, 123);
      },
    );
  });
}
