import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/net_income/domain/models/net_income_stats.dart';
import 'package:bizzie/features/company_profile/net_income/domain/usecases/get_net_income_stats_usecase.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_bloc.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_event.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_state.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/analytics/net_income_tab_analytics.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/analytics/net_income_tab_view_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNetIncomeStatsUseCase extends Mock
    implements GetNetIncomeStatsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockNetIncomeTabAnalytics extends Mock implements NetIncomeTabAnalytics {}

class MockWatchActiveTabUseCase extends Mock implements WatchActiveTabUseCase {}

void main() {
  late CompanyNetIncomeBloc bloc;
  late MockGetNetIncomeStatsUseCase mockGetNetIncomeStats;
  late MockConfigService mockConfigService;
  late MockNetIncomeTabAnalytics mockTracker;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      NetIncomeTabViewState(ticker: 'AAPL', timestamp: 'ts'),
    );
  });

  setUp(() {
    mockGetNetIncomeStats = MockGetNetIncomeStatsUseCase();
    mockConfigService = MockConfigService();
    mockTracker = MockNetIncomeTabAnalytics();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();

    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    when(
      () => mockTracker.logViewSummary(any(), isFinal: any(named: 'isFinal')),
    ).thenAnswer((_) async {});
    when(() => mockWatchActiveTabUseCase(any()))
        .thenAnswer((_) => const Stream.empty());

    bloc = CompanyNetIncomeBloc(
      mockGetNetIncomeStats,
      mockConfigService,
      mockTracker,
      mockWatchActiveTabUseCase,
    );
  });

  const tTicker = 'AAPL';
  const tNetIncomeStats = NetIncomeStats(
    reportedCurrency: 'USD',
    annualNetIncome: [
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 96995.0),
      FinancialDataPoint(date: '2022-09-24', period: 'FY', value: 99803.0),
    ],
    quarterlyNetIncome: [
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 19881.0),
    ],
  );

  test('initialState_isInitial', () {
    // assert
    expect(bloc.state, const CompanyNetIncomeState.initial());
  });

  group('CompanyNetIncomeBloc - loadRequested', () {
    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_success_emitsLoadingAndLoadedWithPerformanceMetrics',
      build: () {
        // arrange
        when(() => mockGetNetIncomeStats(tTicker)).thenAnswer(
          (_) async =>
              const Right((tNetIncomeStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const CompanyNetIncomeEvent.loadRequested(tTicker)),
      expect: () => [
        const CompanyNetIncomeState.loading(),
        isA<CompanyNetIncomeState>()
            .having(
              (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
              'ticker',
              tTicker,
            )
            .having(
              (s) => s.maybeMap(
                loaded: (l) => l.analyticsState?.loadTimeMs != null,
                orElse: () => false,
              ),
              'hasLoadTime',
              true,
            )
            .having(
              (s) => s.maybeMap(
                loaded: (l) => l.analyticsState?.isSuccess,
                orElse: () => false,
              ),
              'isSuccess',
              true,
            ),
      ],
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_failure_preservesMetricsEvenInFailureStatePlaceholder',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetNetIncomeStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const CompanyNetIncomeEvent.loadRequested(tTicker)),
      expect: () => [
        const CompanyNetIncomeState.loading(),
        const CompanyNetIncomeState.failure(Failure.server('Server error')),
      ],
    );
  });

  group('CompanyNetIncomeBloc - Analytics Orchestration', () {
    final loadedState = CompanyNetIncomeState.loaded(
      ticker: tTicker,
      netIncomeStats: tNetIncomeStats,
      annualChartData: const [],
      quarterlyChartData: const [],
      historyLimit: 7,
      dataOrigin: CompanyProfileDataOrigin.api,
      lastUpdated: DateTime.now(),
      analyticsState: NetIncomeTabViewState(
        ticker: tTicker,
        timestamp: 'ts',
        loadTimeMs: 100,
        isSuccess: true,
        dataSource: CompanyProfileDataOrigin.api,
      ),
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'tabShown_startsSessionAndMergesMetrics',
      build: () => bloc,
      seed: () => loadedState,
      act: (bloc) => bloc.add(const CompanyNetIncomeEvent.tabShown(tTicker)),
      verify: (_) {
        // assert
        final state = bloc.state.maybeMap(
          loaded: (l) => l.analyticsState,
          orElse: () => null,
        );
        expect(state?.ticker, tTicker);
        expect(state?.loadTimeMs, 100);
        expect(state?.timestamp, isNotEmpty);
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'tabHidden_endsSessionAndLogsSummary',
      build: () => bloc,
      seed: () => loadedState,
      act: (bloc) {
        // act
        bloc.add(const CompanyNetIncomeEvent.tabShown(tTicker));
        bloc.add(const CompanyNetIncomeEvent.tabHidden());
      },
      verify: (_) {
        // assert
        verify(
          () => mockTracker.logViewSummary(any(), isFinal: true),
        ).called(1);
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'periodViewed_updatesAnalyticsFlags',
      build: () => bloc,
      seed: () => loadedState,
      act: (bloc) {
        // act
        bloc.add(const CompanyNetIncomeEvent.tabShown(tTicker));
        bloc.add(const CompanyNetIncomeEvent.periodViewed(isAnnual: true));
        bloc.add(const CompanyNetIncomeEvent.periodViewed(isAnnual: false));
      },
      verify: (_) {
        // assert
        expect(bloc.analyticsSession?.viewedYearlyNetTab, true);
        expect(bloc.analyticsSession?.viewedQtrlyNetTab, true);
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'viewAllTapped_updatesCorrectInteractionFlags',
      build: () => bloc,
      seed: () => loadedState,
      act: (bloc) {
        // act
        bloc.add(const CompanyNetIncomeEvent.tabShown(tTicker));
        bloc.add(
          const CompanyNetIncomeEvent.viewAllTapped(
            isAnnual: true,
            isChart: true,
          ),
        );
        bloc.add(
          const CompanyNetIncomeEvent.viewAllTapped(
            isAnnual: false,
            isChart: false,
          ),
        );
      },
      verify: (_) {
        // assert
        expect(bloc.analyticsSession?.tappedYrchartViewAll, true);
        expect(bloc.analyticsSession?.tappedQtrtableViewAll, true);
      },
    );
  });
}
