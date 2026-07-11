import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/domain/models/free_cash_flow_stats.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/domain/usecases/get_free_cash_flow_stats_usecase.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_bloc.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_event.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/tab_content_freshness_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/analytics/free_cash_flow_tab_analytics.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/analytics/free_cash_flow_tab_view_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetFreeCashFlowStatsUseCase extends Mock
    implements GetFreeCashFlowStatsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockFreeCashFlowTabAnalytics extends Mock
    implements FreeCashFlowTabAnalytics {}

class MockWatchActiveTabUseCase extends Mock implements WatchActiveTabUseCase {}

class MockTabContentFreshnessService extends Mock
    implements TabContentFreshnessService {}

void main() {
  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      const FreeCashFlowTabViewState(ticker: '', timestamp: ''),
    );
  });

  late CompanyFreeCashFlowBloc bloc;
  late MockGetFreeCashFlowStatsUseCase mockGetFreeCashFlowStats;
  late MockConfigService mockConfigService;
  late MockFreeCashFlowTabAnalytics mockAnalytics;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;
  late MockTabContentFreshnessService mockFreshnessService;

  setUp(() {
    mockGetFreeCashFlowStats = MockGetFreeCashFlowStatsUseCase();
    mockConfigService = MockConfigService();
    mockAnalytics = MockFreeCashFlowTabAnalytics();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();
    mockFreshnessService = MockTabContentFreshnessService();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    when(() => mockWatchActiveTabUseCase(any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockFreshnessService.isStale(any())).thenReturn(false);
    bloc = CompanyFreeCashFlowBloc(
      mockGetFreeCashFlowStats,
      mockConfigService,
      mockAnalytics,
      mockWatchActiveTabUseCase,
      mockFreshnessService,
    );
  });

  const tTicker = 'AAPL';
  const tFcfStats = FreeCashFlowStats(
    reportedCurrency: 'USD',
    annualFcf: [
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 99584.0),
      FinancialDataPoint(date: '2022-09-24', period: 'FY', value: 111443.0),
    ],
    quarterlyFcf: [
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 24285.0),
    ],
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyFreeCashFlowState.initial());
  });

  group('CompanyFreeCashFlowBloc - loadRequested', () {
    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetFreeCashFlowStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFreeCashFlowEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        isA<CompanyFreeCashFlowState>()
            .having(
              (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
              'ticker',
              tTicker,
            )
            .having(
              (s) =>
                  s.maybeMap(loaded: (l) => l.dataOrigin, orElse: () => null),
              'dataOrigin',
              CompanyProfileDataOrigin.api,
            ),
      ],
      // Assert
      verify: (_) {
        verify(() => mockGetFreeCashFlowStats(tTicker)).called(1);
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetFreeCashFlowStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFreeCashFlowEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        const CompanyFreeCashFlowState.failure(Failure.server('Server error')),
      ],
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () => bloc,
      // Arrange
      seed: () => const CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFreeCashFlowEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetFreeCashFlowStats(any()));
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetFreeCashFlowStats('MSFT')).thenAnswer(
          (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyFreeCashFlowState.loaded(
        ticker: 'AAPL',
        fcfStats: tFcfStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFreeCashFlowEvent.loadRequested('MSFT')),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        isA<CompanyFreeCashFlowState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadedOnly',
      build: () {
        // Arrange
        when(() => mockGetFreeCashFlowStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyFreeCashFlowEvent.loadRequested(
          tTicker,
          forceRefresh: true,
        ),
      ),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        isA<CompanyFreeCashFlowState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
    );
  });

  group('CompanyFreeCashFlowBloc - stalenessCheckRequested', () {
    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetFreeCashFlowStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(
        const CompanyFreeCashFlowEvent.stalenessCheckRequested(tTicker),
      ),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        isA<CompanyFreeCashFlowState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      // Arrange
      build: () => bloc,
      seed: () => CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyFreeCashFlowEvent.stalenessCheckRequested(tTicker),
      ),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetFreeCashFlowStats(any()));
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockFreshnessService.isStale(any())).thenReturn(true);
        when(() => mockGetFreeCashFlowStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyFreeCashFlowEvent.stalenessCheckRequested(tTicker),
      ),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        isA<CompanyFreeCashFlowState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
    );
  });

  group('CompanyFreeCashFlowBloc - reset', () {
    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'reset_loadedState_emitsInitial',
      build: () => bloc,
      // Arrange
      seed: () => const CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(const CompanyFreeCashFlowEvent.reset()),
      // Assert
      expect: () => [const CompanyFreeCashFlowState.initial()],
    );
  });

  group('CompanyFreeCashFlowBloc - Interaction Events', () {
    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'periodViewed_isAnnualTrue_updatesviewedYearlyFcfTabFlag',
      build: () => bloc,
      // Arrange
      seed: () => CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) {
        bloc.add(const CompanyFreeCashFlowEvent.tabShown(tTicker));
        bloc.add(const CompanyFreeCashFlowEvent.periodViewed(isAnnual: true));
      },
      // Assert
      expect: () => const <CompanyFreeCashFlowState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession?.ticker, tTicker);
        expect(bloc.analyticsSession?.viewedYearlyFcfTab, isTrue);
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'viewAllTapped_chartAndTable_updatesCorrectInteractionFlags',
      build: () => bloc,
      // Arrange
      seed: () => CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) {
        bloc.add(const CompanyFreeCashFlowEvent.tabShown(tTicker));
        bloc.add(
          const CompanyFreeCashFlowEvent.viewAllTapped(
            isAnnual: true,
            isChart: true,
          ),
        );
        bloc.add(
          const CompanyFreeCashFlowEvent.viewAllTapped(
            isAnnual: false,
            isChart: false,
          ),
        );
      },
      // Assert
      expect: () => const <CompanyFreeCashFlowState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession?.ticker, tTicker);
        expect(bloc.analyticsSession?.tappedYrchartViewAll, isTrue);
        expect(bloc.analyticsSession?.tappedQtrtableViewAll, isTrue);
      },
    );
  });

  group('CompanyFreeCashFlowBloc - Lifecycle Events', () {
    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'tabHidden_sessionActive_logsFinalSummary',
      build: () {
        // Arrange
        when(
          () => mockAnalytics.logViewSummary(
            any(),
            isFinal: any(named: 'isFinal'),
          ),
        ).thenAnswer((_) async {});
        return bloc;
      },
      seed: () => CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) async {
        bloc.add(const CompanyFreeCashFlowEvent.tabShown(tTicker));
        bloc.add(const CompanyFreeCashFlowEvent.tabHidden());
      },
      // Assert
      verify: (_) {
        verify(
          () => mockAnalytics.logViewSummary(any(), isFinal: true),
        ).called(1);
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'appBackgrounded_sessionActive_logsNonFinalSummary',
      build: () {
        // Arrange
        when(
          () => mockAnalytics.logViewSummary(
            any(),
            isFinal: any(named: 'isFinal'),
          ),
        ).thenAnswer((_) async {});
        return bloc;
      },
      seed: () => CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) async {
        bloc.add(const CompanyFreeCashFlowEvent.tabShown(tTicker));
        bloc.add(const CompanyFreeCashFlowEvent.appBackgrounded());
      },
      // Assert
      verify: (_) {
        verify(
          () => mockAnalytics.logViewSummary(any(), isFinal: false),
        ).called(1);
      },
    );
  });
}
