import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/models/pe_ratio.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/services/pe_ratio_metrics_service.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/usecases/get_pe_ratio_usecase.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_event.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_state.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/analytics/pe_ratio_tab_analytics.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/analytics/pe_ratio_tab_view_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';

import 'package:bizzie/core/interfaces/i_config_service.dart';

class MockGetPeRatioUseCase extends Mock implements GetPeRatioUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockPeRatioTabAnalytics extends Mock implements PeRatioTabAnalytics {}

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
  late CompanyPeRatioBloc bloc;
  late MockGetPeRatioUseCase mockGetPeRatio;
  late MockConfigService mockConfigService;
  late MockPeRatioTabAnalytics mockAnalytics;

  setUp(() {
    mockGetPeRatio = MockGetPeRatioUseCase();
    mockConfigService = MockConfigService();
    mockAnalytics = MockPeRatioTabAnalytics();

    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    when(
      () => mockAnalytics.logViewSummary(any(), isFinal: any(named: 'isFinal')),
    ).thenAnswer((_) async {});

    bloc = CompanyPeRatioBloc(
      mockGetPeRatio,
      mockConfigService,
      mockAnalytics,
      PeRatioMetricsService(),
      stubbedTimeProvider(),
      stubbedGetAuthStream(),
    );
  });

  setUpAll(() {
    registerFallbackValue(
      const PeRatioTabViewState(ticker: 'AAPL', timestamp: ''),
    );
  });

  const tTicker = 'AAPL';
  const tRatios = [
    PeRatio(
      symbol: tTicker,
      date: '2018-10-01',
      period: 'FY',
      priceToEarningsRatio: 18.0,
    ),
    PeRatio(
      symbol: tTicker,
      date: '2023-09-30',
      period: 'FY',
      priceToEarningsRatio: 28.0,
    ),
  ];

  test('initialState_isCorrect', () {
    // Assert
    expect(bloc.state, const CompanyPeRatioState.initial());
  });

  group('CompanyPeRatioBloc - loadRequested', () {
    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetPeRatio(tTicker)).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // Assert
        return [
          const CompanyPeRatioState.loading(),
          isA<CompanyPeRatioState>()
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.currentValue,
                  orElse: () => null,
                ),
                'currentValue',
                28.0,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.growthPercentage,
                  orElse: () => null,
                ),
                'growthPercentage',
                ((28.0 - 18.0) / 18.0) * 100,
              )
              .having(
                (s) =>
                    s.maybeMap(loaded: (l) => l.dataOrigin, orElse: () => null),
                'dataOrigin',
                CompanyProfileDataOrigin.api,
              ),
        ];
      },
      verify: (_) {
        // Assert
        verify(() => mockGetPeRatio(tTicker)).called(1);
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetPeRatio(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // Assert
        return [
          const CompanyPeRatioState.loading(),
          const CompanyPeRatioState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // Arrange
        return bloc;
      },
      seed: () => const CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // Assert
        return [];
      },
      verify: (_) {
        // Assert
        verifyNever(() => mockGetPeRatio(any()));
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetPeRatio(tTicker)).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // Act
        bloc.add(
          const CompanyPeRatioEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // Assert
        return [
          const CompanyPeRatioState.loading(),
          isA<CompanyPeRatioState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            28.0,
          ),
        ];
      },
      verify: (_) {
        // Assert
        verify(() => mockGetPeRatio(tTicker)).called(1);
      },
    );
  });

  group('CompanyPeRatioBloc - stalenessCheckRequested', () {
    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetPeRatio(tTicker)).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // Assert
        return [
          const CompanyPeRatioState.loading(),
          isA<CompanyPeRatioState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            28.0,
          ),
        ];
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // Arrange
        return bloc;
      },
      seed: () => CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // Assert
        return [];
      },
      verify: (_) {
        // Assert
        verifyNever(() => mockGetPeRatio(any()));
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetPeRatio(tTicker)).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // Assert
        return [
          const CompanyPeRatioState.loading(),
          isA<CompanyPeRatioState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            28.0,
          ),
        ];
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetPeRatio('MSFT')).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyPeRatioState.loaded(
        ticker: 'AAPL',
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) => bloc.add(const CompanyPeRatioEvent.loadRequested('MSFT')),
      expect: () => [
        const CompanyPeRatioState.loading(),
        isA<CompanyPeRatioState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );
  });

  group('CompanyPeRatioBloc - Analytics Orchestration', () {
    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'tabShown_afterSuccessfulLoad_initializesSessionWithPersistedMetrics',
      build: () {
        when(() => mockGetPeRatio(tTicker)).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const CompanyPeRatioEvent.loadRequested(tTicker));
        await Future.delayed(const Duration(milliseconds: 200));
        bloc.add(const CompanyPeRatioEvent.tabShown(tTicker));
      },
      expect: () => [
        const CompanyPeRatioState.loading(),
        isA<CompanyPeRatioState>(),
      ],
      verify: (bloc) {
        bloc.state.maybeMap(
          loaded: (l) {
            expect(l.ticker, tTicker);
            expect(l.isSuccess, true);
          },
          orElse: () => fail('Should be in loaded state'),
        );
        expect(bloc.analyticsSession, isNotNull);
        expect(bloc.analyticsSession?.isSuccess, isTrue);
        verifyNever(
          () => mockAnalytics.logViewSummary(
            any(),
            isFinal: any(named: 'isFinal'),
          ),
        );
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'tabShown_callsOnTabShownAndUpdatesAnalyticsState',
      build: () => bloc,
      seed: () => const CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) => bloc.add(const CompanyPeRatioEvent.tabShown(tTicker)),
      expect: () => const <CompanyPeRatioState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession, isNotNull);
        verifyNever(
          () => mockAnalytics.logViewSummary(
            any(),
            isFinal: any(named: 'isFinal'),
          ),
        );
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'viewAllTapped_updatesInteractionFlags',
      build: () => bloc,
      seed: () => const CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) async {
        bloc.add(const CompanyPeRatioEvent.tabShown(tTicker));
        await Future.delayed(Duration.zero);
        bloc.add(const CompanyPeRatioEvent.viewAllTapped(isChart: true));
      },
      expect: () => const <CompanyPeRatioState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession?.tappedChartViewAll, isTrue);
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'tabHidden_logsTabSessionAndResetsAnalytics',
      build: () => bloc,
      seed: () => const CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) async {
        bloc.add(const CompanyPeRatioEvent.tabShown(tTicker));
        await Future.delayed(Duration.zero);
        bloc.add(const CompanyPeRatioEvent.tabHidden());
      },
      expect: () => const <CompanyPeRatioState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession, isNull);
        verify(
          () => mockAnalytics.logViewSummary(any(), isFinal: true),
        ).called(1);
      },
    );
  });
}
