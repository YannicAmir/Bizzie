import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/fcps/domain/models/fcps_stats.dart';
import 'package:bizzie/features/company_profile/fcps/domain/usecases/get_fcps_stats_usecase.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_bloc.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_event.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/tab_content_freshness_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/analytics/fcps_tab_analytics.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/analytics/fcps_tab_view_state.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';

class MockGetFcpsStatsUseCase extends Mock implements GetFcpsStatsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockFcpsTabAnalytics extends Mock implements FcpsTabAnalytics {}

class MockWatchActiveTabUseCase extends Mock implements WatchActiveTabUseCase {}

class MockTabContentFreshnessService extends Mock
    implements TabContentFreshnessService {}

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
    registerFallbackValue(const FcpsTabViewState(ticker: '', timestamp: ''));
    registerFallbackValue(DateTime(2020));
  });

  late CompanyFcpsBloc bloc;
  late MockGetFcpsStatsUseCase mockGetFcpsStats;
  late MockConfigService mockConfigService;
  late MockFcpsTabAnalytics mockAnalytics;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;
  late MockTabContentFreshnessService mockFreshnessService;

  setUp(() {
    mockGetFcpsStats = MockGetFcpsStatsUseCase();
    mockConfigService = MockConfigService();
    mockAnalytics = MockFcpsTabAnalytics();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();
    mockFreshnessService = MockTabContentFreshnessService();

    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    when(
      () => mockWatchActiveTabUseCase(any()),
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockFreshnessService.isStale(any())).thenReturn(false);
    bloc = CompanyFcpsBloc(
      mockGetFcpsStats,
      mockConfigService,
      mockAnalytics,
      mockWatchActiveTabUseCase,
      mockFreshnessService,
      stubbedTimeProvider(),
      stubbedGetAuthStream(),
    );
  });

  tearDown(() => bloc.close());

  const tTicker = 'AAPL';
  const tFcpsStats = FcpsStats(
    reportedCurrency: 'USD',
    annualFcps: [
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 3.50),
      FinancialDataPoint(date: '2022-09-24', period: 'FY', value: 3.20),
    ],
    quarterlyFcps: [
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 0.85),
    ],
  );

  test('initialState_isCorrect', () {
    expect(bloc.state, const CompanyFcpsState.initial());
  });

  group('CompanyFcpsBloc - loadRequested', () {
    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetFcpsStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const CompanyFcpsEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        isA<CompanyFcpsState>()
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
        verify(() => mockGetFcpsStats(tTicker)).called(1);
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetFcpsStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const CompanyFcpsEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        const CompanyFcpsState.failure(Failure.server('Server error')),
      ],
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      // Arrange
      build: () => bloc,
      seed: () => const CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(const CompanyFcpsEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetFcpsStats(any()));
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetFcpsStats('MSFT')).thenAnswer(
          (_) async => const Right((tFcpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyFcpsState.loaded(
        ticker: 'AAPL',
        fcpsStats: tFcpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(const CompanyFcpsEvent.loadRequested('MSFT')),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        isA<CompanyFcpsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadedOnly',
      build: () {
        // Arrange
        when(() => mockGetFcpsStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyFcpsEvent.loadRequested(tTicker, forceRefresh: true),
      ),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        isA<CompanyFcpsState>()
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
    );
  });

  group('CompanyFcpsBloc - stalenessCheckRequested', () {
    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetFcpsStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFcpsEvent.stalenessCheckRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        isA<CompanyFcpsState>()
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
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // Arrange
        when(() => mockFreshnessService.isStale(any())).thenReturn(false);
        return bloc;
      },
      seed: () => CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFcpsEvent.stalenessCheckRequested(tTicker)),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetFcpsStats(any()));
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockFreshnessService.isStale(any())).thenReturn(true);
        when(() => mockGetFcpsStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFcpsEvent.stalenessCheckRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        isA<CompanyFcpsState>()
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
    );
  });

  group('CompanyFcpsBloc - reset', () {
    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'reset_fromLoadedState_emitsInitial',
      // Arrange
      build: () => bloc,
      seed: () => const CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(const CompanyFcpsEvent.reset()),
      // Assert
      expect: () => [const CompanyFcpsState.initial()],
    );
  });

  group('CompanyFcpsBloc - Interaction Events', () {
    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'periodChanged_isAnnualTrue_updatesviewedYearlyFcpsTabFlag',
      build: () => bloc,
      // Arrange
      seed: () => CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) {
        bloc.add(const CompanyFcpsEvent.tabShown(tTicker));
        bloc.add(const CompanyFcpsEvent.periodChanged(isAnnual: true));
      },
      // Assert
      expect: () => const <CompanyFcpsState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession?.ticker, tTicker);
        expect(bloc.analyticsSession?.viewedYearlyFcpsTab, isTrue);
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'periodChanged_isAnnualFalse_emitsUpdatedIsAnnualViewAndUpdatesFlag',
      build: () => bloc,
      // Arrange
      seed: () => CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) => bloc
        ..add(const CompanyFcpsEvent.tabShown(tTicker))
        ..add(const CompanyFcpsEvent.periodChanged(isAnnual: false)),
      // Assert
      expect: () => [
        isA<CompanyFcpsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.isAnnualView, orElse: () => null),
          'isAnnualView',
          false,
        ),
      ],
      verify: (bloc) {
        expect(bloc.analyticsSession?.viewedQtrlyFcpsTab, isTrue);
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'viewAllTapped_chartAndTable_updatesCorrectInteractionFlags',
      build: () => bloc,
      // Arrange
      seed: () => CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) {
        bloc.add(const CompanyFcpsEvent.tabShown(tTicker));
        bloc.add(
          const CompanyFcpsEvent.viewAllTapped(isAnnual: true, isChart: true),
        );
        bloc.add(
          const CompanyFcpsEvent.viewAllTapped(isAnnual: false, isChart: false),
        );
      },
      // Assert
      expect: () => const <CompanyFcpsState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession?.ticker, tTicker);
        expect(bloc.analyticsSession?.tappedYrchartViewAll, isTrue);
        expect(bloc.analyticsSession?.tappedQtrtableViewAll, isTrue);
      },
    );
  });

  group('CompanyFcpsBloc - Lifecycle Events', () {
    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
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
      seed: () => CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) async {
        bloc.add(const CompanyFcpsEvent.tabShown(tTicker));
        bloc.add(const CompanyFcpsEvent.tabHidden());
      },
      // Assert
      verify: (_) {
        verify(
          () => mockAnalytics.logViewSummary(any(), isFinal: true),
        ).called(1);
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
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
      seed: () => CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) async {
        bloc.add(const CompanyFcpsEvent.tabShown(tTicker));
        bloc.add(const CompanyFcpsEvent.appBackgrounded());
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
