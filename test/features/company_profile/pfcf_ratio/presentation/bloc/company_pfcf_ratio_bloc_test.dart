import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/models/pfcf_ratio_stats.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/usecases/get_pfcf_ratio_usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/tab_content_freshness_service.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/bloc/company_pfcf_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/bloc/company_pfcf_ratio_event.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/bloc/company_pfcf_ratio_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/analytics/pfcf_ratio_tab_analytics.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/analytics/pfcf_ratio_tab_view_state.dart';

class MockGetPfcfRatioUseCase extends Mock implements GetPfcfRatioUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockPfcfRatioTabAnalytics extends Mock implements PfcfRatioTabAnalytics {}

class MockTabContentFreshnessService extends Mock
    implements TabContentFreshnessService {}

class PfcfRatioTabViewStateFake extends Fake implements PfcfRatioTabViewState {}

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
    registerFallbackValue(PfcfRatioTabViewStateFake());
    registerFallbackValue(DateTime(2020));
  });

  late CompanyPfcfRatioBloc bloc;
  late MockGetPfcfRatioUseCase mockGetPfcfRatio;
  late MockConfigService mockConfigService;
  late MockPfcfRatioTabAnalytics mockAnalytics;
  late MockTabContentFreshnessService mockFreshnessService;

  setUp(() {
    mockGetPfcfRatio = MockGetPfcfRatioUseCase();
    mockConfigService = MockConfigService();
    mockAnalytics = MockPfcfRatioTabAnalytics();
    mockFreshnessService = MockTabContentFreshnessService();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    bloc = CompanyPfcfRatioBloc(
      mockGetPfcfRatio,
      mockConfigService,
      mockAnalytics,
      mockFreshnessService,
      stubbedTimeProvider(),
      stubbedGetAuthStream(),
    );
  });

  const tTicker = 'AAPL';
  const tStats = PfcfRatioStats(
    dataPoints: [
      FinancialDataPoint(date: '2018-10-01', period: 'FY', value: 15.0),
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 25.0),
    ],
    currentValue: 25.0,
    growthPercentage: ((25.0 - 15.0) / 15.0) * 100,
    absoluteDelta: 10.0,
    isPositive: true,
    referenceDate: '2018-10-01',
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyPfcfRatioState.initial());
  });

  group('CompanyPfcfRatioBloc - loadRequested', () {
    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(() => mockGetPfcfRatio(tTicker)).thenAnswer(
          (_) async => const Right((tStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyPfcfRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyPfcfRatioState.loading(),
          isA<CompanyPfcfRatioState>()
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.currentValue,
                  orElse: () => null,
                ),
                'currentValue',
                25.0,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.growthPercentage,
                  orElse: () => null,
                ),
                'growthPercentage',
                ((25.0 - 15.0) / 15.0) * 100,
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
        verify(() => mockGetPfcfRatio(tTicker)).called(1);
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetPfcfRatio(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyPfcfRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyPfcfRatioState.loading(),
          const CompanyPfcfRatioState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyPfcfRatioState.loaded(
        ticker: tTicker,
        dataPoints: [],
        chartData: [],
        currentValue: 25.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyPfcfRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetPfcfRatio(any()));
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'loadRequested_instrumentation_tracksTimingAndSuccess',
      build: () {
        when(() => mockGetPfcfRatio(tTicker)).thenAnswer(
          (_) async => const Right((tStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const CompanyPfcfRatioEvent.loadRequested(tTicker)),
      expect: () => [
        const CompanyPfcfRatioState.loading(),
        isA<CompanyPfcfRatioState>().having(
          (s) => s.maybeMap(
            loaded: (l) => l.loadTimeMs! >= 0 && l.isSuccess,
            orElse: () => false,
          ),
          'metrics correctly instrumented',
          true,
        ),
      ],
    );
  });

  group('CompanyPfcfRatioBloc - Analytics Orchestration', () {
    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'tabShown_startsAnalyticsSession',
      build: () => bloc,
      act: (bloc) => bloc.add(const CompanyPfcfRatioEvent.tabShown(tTicker)),
      verify: (_) {
        expect(bloc.analyticsSession, isNotNull);
        expect(bloc.analyticsSession!.ticker, tTicker);
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'tabHidden_finalizesAnalyticsSession',
      build: () {
        when(
          () => mockAnalytics.logViewSummary(
            any(),
            isFinal: any(named: 'isFinal'),
          ),
        ).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const CompanyPfcfRatioEvent.tabShown(tTicker));
        bloc.add(const CompanyPfcfRatioEvent.tabHidden());
      },
      verify: (_) {
        verify(
          () => mockAnalytics.logViewSummary(
            any(that: isA<PfcfRatioTabViewState>()),
            isFinal: true,
          ),
        ).called(1);
        expect(bloc.analyticsSession, isNull);
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'viewAllTapped_updatesAnalyticsInteractionFlags',
      build: () => bloc,
      act: (bloc) {
        bloc.add(const CompanyPfcfRatioEvent.tabShown(tTicker));
        bloc.add(const CompanyPfcfRatioEvent.viewAllTapped(isChart: true));
        bloc.add(const CompanyPfcfRatioEvent.viewAllTapped(isChart: false));
      },
      verify: (_) {
        expect(bloc.analyticsSession!.tappedChartViewAll, true);
        expect(bloc.analyticsSession!.tappedTableViewAll, true);
      },
    );
  });

  group('CompanyPfcfRatioBloc - stalenessCheckRequested', () {
    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockGetPfcfRatio(tTicker)).thenAnswer(
          (_) async => const Right((tStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyPfcfRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyPfcfRatioState.loading(),
          isA<CompanyPfcfRatioState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            25.0,
          ),
        ];
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        when(() => mockFreshnessService.isStale(any())).thenReturn(false);
        return bloc;
      },
      seed: () => CompanyPfcfRatioState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 25.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyPfcfRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetPfcfRatio(any()));
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockFreshnessService.isStale(any())).thenReturn(true);
        when(() => mockGetPfcfRatio(tTicker)).thenAnswer(
          (_) async => const Right((tStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyPfcfRatioState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 25.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyPfcfRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyPfcfRatioState.loading(),
          isA<CompanyPfcfRatioState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            25.0,
          ),
        ];
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        when(() => mockGetPfcfRatio('MSFT')).thenAnswer(
          (_) async => const Right((tStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyPfcfRatioState.loaded(
        ticker: 'AAPL',
        dataPoints: [],
        chartData: [],
        currentValue: 25.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) =>
          bloc.add(const CompanyPfcfRatioEvent.loadRequested('MSFT')),
      expect: () => [
        const CompanyPfcfRatioState.loading(),
        isA<CompanyPfcfRatioState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );
  });
}
