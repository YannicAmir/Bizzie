import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/roe/domain/models/roe.dart';
import 'package:bizzie/features/company_profile/roe/domain/usecases/get_roe_usecase.dart';
import 'package:bizzie/features/company_profile/roe/presentation/bloc/company_roe_bloc.dart';
import 'package:bizzie/features/company_profile/roe/presentation/bloc/company_roe_event.dart';
import 'package:bizzie/features/company_profile/roe/presentation/bloc/company_roe_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/roe/presentation/analytics/roe_tab_analytics.dart';
import 'package:bizzie/features/company_profile/roe/presentation/analytics/roe_tab_view_state.dart';

class MockGetRoeUseCase extends Mock implements GetRoeUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockRoeTabAnalytics extends Mock implements RoeTabAnalytics {}

void main() {
  late CompanyRoeBloc bloc;
  late MockGetRoeUseCase mockGetRoe;
  late MockConfigService mockConfigService;
  late MockRoeTabAnalytics mockAnalytics;

  setUpAll(() {
    registerFallbackValue(
      const RoeTabViewState(ticker: 'AAPL', timestamp: '2024-01-01'),
    );
  });

  setUp(() {
    mockGetRoe = MockGetRoeUseCase();
    mockConfigService = MockConfigService();
    mockAnalytics = MockRoeTabAnalytics();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    bloc = CompanyRoeBloc(mockGetRoe, mockConfigService, mockAnalytics);
  });

  const tTicker = 'AAPL';
  const tTimestamp = '2024-01-01T00:00:00Z';
  const tRoeMetrics = [
    Roe(
      symbol: tTicker,
      date: '2018-10-01',
      period: 'FY',
      returnOnEquity: 0.35,
    ),
    Roe(
      symbol: tTicker,
      date: '2023-09-30',
      period: 'FY',
      returnOnEquity: 0.45,
    ),
  ];

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyRoeState.initial());
  });

  group('CompanyRoeBloc - loadRequested', () {
    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(() => mockGetRoe(tTicker)).thenAnswer(
          (_) async => const Right((tRoeMetrics, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRoeState.loading(),
          isA<CompanyRoeState>()
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.currentValue,
                  orElse: () => null,
                ),
                'currentValue',
                0.45,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.growthPercentage,
                  orElse: () => null,
                ),
                'growthPercentage',
                ((0.45 - 0.35) / 0.35) * 100,
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
        // assert
        verify(() => mockGetRoe(tTicker)).called(1);
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetRoe(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRoeState.loading(),
          const CompanyRoeState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyRoeState.loaded(
        ticker: tTicker,
        dataPoints: [],
        chartData: [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetRoe(any()));
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(() => mockGetRoe(tTicker)).thenAnswer(
          (_) async => const Right((tRoeMetrics, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyRoeState.loaded(
        ticker: tTicker,
        dataPoints: [],
        chartData: [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyRoeEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyRoeState.loading(),
          isA<CompanyRoeState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            0.45,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetRoe(tTicker)).called(1);
      },
    );
  });

  group('CompanyRoeBloc - stalenessCheckRequested', () {
    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockGetRoe(tTicker)).thenAnswer(
          (_) async => const Right((tRoeMetrics, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRoeState.loading(),
          isA<CompanyRoeState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            0.45,
          ),
        ];
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyRoeState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetRoe(any()));
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockGetRoe(tTicker)).thenAnswer(
          (_) async => const Right((tRoeMetrics, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyRoeState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRoeState.loading(),
          isA<CompanyRoeState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            0.45,
          ),
        ];
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        when(() => mockGetRoe('MSFT')).thenAnswer(
          (_) async => const Right((tRoeMetrics, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyRoeState.loaded(
        ticker: 'AAPL',
        dataPoints: [],
        chartData: [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) => bloc.add(const CompanyRoeEvent.loadRequested('MSFT')),
      expect: () => [
        const CompanyRoeState.loading(),
        isA<CompanyRoeState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );
  });

  group('CompanyRoeBloc - Analytics', () {
    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'tabShown_initializesAnalyticsState',
      build: () => bloc,
      seed: () => CompanyRoeState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) => bloc.add(const CompanyRoeEvent.tabShown(tTicker)),
      expect: () => [
        isA<CompanyRoeState>().having(
          (s) =>
              s.maybeMap(loaded: (l) => l.analyticsState, orElse: () => null),
          'analyticsState',
          isNotNull,
        ),
      ],
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'viewAllTapped_updatesInteractionFlags',
      build: () => bloc,
      seed: () => CompanyRoeState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        analyticsState: const RoeTabViewState(
          ticker: tTicker,
          timestamp: tTimestamp,
        ),
      ),
      act: (bloc) => bloc
        ..add(const CompanyRoeEvent.tabShown(tTicker))
        ..add(const CompanyRoeEvent.viewAllTapped(isChart: true)),
      expect: () => [
        isA<CompanyRoeState>(), // from tabShown
        isA<CompanyRoeState>().having(
          (s) => s.maybeMap(
            loaded: (l) => l.analyticsState?.tappedChartViewAll,
            orElse: () => null,
          ),
          'tappedChartViewAll',
          true,
        ),
      ],
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'tabHidden_logsAnalyticsAndResetsState',
      build: () {
        when(
          () => mockAnalytics.logViewSummary(
            any(),
            isFinal: any(named: 'isFinal'),
          ),
        ).thenAnswer((_) async {});
        return bloc;
      },
      seed: () => CompanyRoeState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        analyticsState: const RoeTabViewState(
          ticker: tTicker,
          timestamp: tTimestamp,
        ),
      ),
      act: (bloc) => bloc
        ..add(const CompanyRoeEvent.tabShown(tTicker))
        ..add(const CompanyRoeEvent.tabHidden()),
      expect: () => [
        isA<CompanyRoeState>(),
        isA<CompanyRoeState>().having(
          (s) => s.maybeMap(loaded: (l) => l.analyticsState, orElse: () => 1),
          'analyticsState',
          isNull,
        ),
      ],
      verify: (_) {
        verify(
          () => mockAnalytics.logViewSummary(any(), isFinal: true),
        ).called(1);
      },
    );
  });
}
