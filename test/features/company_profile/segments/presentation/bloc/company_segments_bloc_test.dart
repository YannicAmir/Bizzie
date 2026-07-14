import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_geographic_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_product_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/segments/domain/usecases/get_revenue_geographic_segments_usecase.dart';
import 'package:bizzie/features/company_profile/segments/domain/usecases/get_revenue_product_segments_usecase.dart';
import 'package:bizzie/features/company_profile/segments/presentation/analytics/segments_tab_analytics.dart';
import 'package:bizzie/features/company_profile/segments/presentation/analytics/segments_tab_view_state.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_bloc.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_event.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRevenueProductSegmentsUseCase extends Mock
    implements GetRevenueProductSegmentsUseCase {}

class MockGetRevenueGeographicSegmentsUseCase extends Mock
    implements GetRevenueGeographicSegmentsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockSegmentsTabAnalytics extends Mock implements SegmentsTabAnalytics {}

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

const tTicker = 'AAPL';

const tProductAnnual2025 = RevenueSegment(
  date: '2025-09-27',
  fiscalYear: 2025,
  period: 'FY',
  reportedCurrency: 'USD',
  data: {'iPhone': 200.0, 'Mac': 50.0},
);

const tProductAnnual2024 = RevenueSegment(
  date: '2024-09-28',
  fiscalYear: 2024,
  period: 'FY',
  reportedCurrency: 'USD',
  data: {'iPhone': 180.0, 'Mac': 60.0, 'iPod': 5.0},
);

const tProductQuarter = RevenueSegment(
  date: '2026-03-28',
  fiscalYear: 2026,
  period: 'Q2',
  reportedCurrency: 'USD',
  data: {'iPhone': 90.0, 'Watch': 10.0},
);

const tGeographicAnnual2025 = RevenueSegment(
  date: '2025-09-27',
  fiscalYear: 2025,
  period: 'FY',
  reportedCurrency: 'USD',
  data: {'Americas': 150.0, 'Europe': 100.0},
);

const tGeographicQuarter = RevenueSegment(
  date: '2026-03-28',
  fiscalYear: 2026,
  period: 'Q2',
  reportedCurrency: 'USD',
  data: {'Americas': 60.0},
);

const tProductSegments = RevenueProductSegments(
  symbol: tTicker,
  reportedCurrency: 'USD',
  annual: [tProductAnnual2025, tProductAnnual2024],
  quarterly: [tProductQuarter],
);

const tGeographicSegments = RevenueGeographicSegments(
  symbol: tTicker,
  reportedCurrency: 'USD',
  annual: [tGeographicAnnual2025],
  quarterly: [tGeographicQuarter],
);

const tFailure = Failure.server('Server error');

final tNow = DateTime(2026, 7, 13, 12);

void main() {
  late CompanySegmentsBloc bloc;
  late MockGetRevenueProductSegmentsUseCase mockGetProductSegments;
  late MockGetRevenueGeographicSegmentsUseCase mockGetGeographicSegments;
  late MockConfigService mockConfigService;
  late MockSegmentsTabAnalytics mockAnalytics;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;
  late MockTimeProvider mockTimeProvider;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      const SegmentsTabViewState(ticker: tTicker, timestamp: ''),
    );
  });

  setUp(() {
    mockGetProductSegments = MockGetRevenueProductSegmentsUseCase();
    mockGetGeographicSegments = MockGetRevenueGeographicSegmentsUseCase();
    mockConfigService = MockConfigService();
    mockAnalytics = MockSegmentsTabAnalytics();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();
    mockTimeProvider = stubbedTimeProvider();

    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    when(
      () => mockAnalytics.logViewSummary(any(), isFinal: any(named: 'isFinal')),
    ).thenAnswer((_) async {});
    when(
      () => mockWatchActiveTabUseCase(any()),
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockGetProductSegments(any())).thenAnswer(
      (_) async => const Right((tProductSegments, CompanyProfileDataOrigin.api)),
    );
    when(() => mockGetGeographicSegments(any())).thenAnswer(
      (_) async =>
          const Right((tGeographicSegments, CompanyProfileDataOrigin.cache)),
    );

    bloc = CompanySegmentsBloc(
      mockGetProductSegments,
      mockGetGeographicSegments,
      mockConfigService,
      mockAnalytics,
      mockWatchActiveTabUseCase,
      mockTimeProvider,
      stubbedGetAuthStream(),
    );
  });

  tearDown(() => bloc.close());

  CompanySegmentsState tLoadedState({
    DateTime? lastUpdated,
    bool isAnnualView = true,
    String? selectedAnnualKey = '2025',
    String? selectedQuarterlyKey = 'Q2 2026',
    SegmentsTabViewState analyticsState = const SegmentsTabViewState(
      ticker: tTicker,
      timestamp: '2026-01-01',
    ),
  }) => CompanySegmentsState.loaded(
    ticker: tTicker,
    productSegments: tProductSegments,
    geographicSegments: tGeographicSegments,
    annualPeriodKeys: const ['2025', '2024'],
    quarterlyPeriodKeys: const ['Q2 2026'],
    productColorIndices: const {'iPhone': 0, 'Watch': 1, 'Mac': 2, 'iPod': 3},
    geographicColorIndices: const {'Americas': 0, 'Europe': 1},
    historyLimit: 7,
    dataOrigin: CompanyProfileDataOrigin.api,
    isAnnualView: isAnnualView,
    selectedAnnualKey: selectedAnnualKey,
    selectedQuarterlyKey: selectedQuarterlyKey,
    lastUpdated: lastUpdated ?? DateTime.now(),
    analyticsState: analyticsState,
  );

  T? loadedField<T>(CompanySegmentsState state, T? Function(CompanySegmentsLoaded) pick) =>
      state.mapOrNull(loaded: pick);

  test('initialState_isCorrect', () {
    expect(bloc.state, const CompanySegmentsState.initial());
  });

  group('CompanySegmentsBloc - loadRequested', () {
    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'loadRequested_bothBreakdownsSucceed_emitsLoadingAndLoadedWithDerivedKeys',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const CompanySegmentsEvent.loadRequested(tTicker)),
      expect: () => [
        const CompanySegmentsState.loading(),
        isA<CompanySegmentsState>()
            .having((s) => loadedField(s, (l) => l.ticker), 'ticker', tTicker)
            .having(
              (s) => loadedField(s, (l) => l.annualPeriodKeys),
              'annualPeriodKeys',
              ['2025', '2024'],
            )
            .having(
              (s) => loadedField(s, (l) => l.quarterlyPeriodKeys),
              'quarterlyPeriodKeys',
              ['Q2 2026'],
            )
            .having(
              (s) => loadedField(s, (l) => l.selectedAnnualKey),
              'selectedAnnualKey',
              '2025',
            )
            .having(
              (s) => loadedField(s, (l) => l.selectedQuarterlyKey),
              'selectedQuarterlyKey',
              'Q2 2026',
            )
            .having(
              (s) => loadedField(s, (l) => l.isAnnualView),
              'isAnnualView',
              true,
            )
            .having(
              (s) => loadedField(s, (l) => l.productColorIndices),
              'productColorIndices',
              {'iPhone': 0, 'Watch': 1, 'Mac': 2, 'iPod': 3},
            )
            .having(
              (s) => loadedField(s, (l) => l.geographicColorIndices),
              'geographicColorIndices',
              {'Americas': 0, 'Europe': 1},
            )
            .having(
              (s) => loadedField(s, (l) => l.dataOrigin),
              'dataOrigin',
              CompanyProfileDataOrigin.api,
            )
            .having(
              (s) => loadedField(s, (l) => l.historyLimit),
              'historyLimit',
              7,
            ),
      ],
      verify: (_) {
        verify(() => mockGetProductSegments(tTicker)).called(1);
        verify(() => mockGetGeographicSegments(tTicker)).called(1);
      },
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'loadRequested_productFailsGeographicSucceeds_emitsLoadedWithEmptyProduct',
      build: () {
        when(
          () => mockGetProductSegments(tTicker),
        ).thenAnswer((_) async => const Left(tFailure));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const CompanySegmentsEvent.loadRequested(tTicker)),
      expect: () => [
        const CompanySegmentsState.loading(),
        isA<CompanySegmentsState>()
            .having(
              (s) => loadedField(s, (l) => l.productSegments.annual),
              'product annual',
              isEmpty,
            )
            .having(
              (s) => loadedField(s, (l) => l.geographicSegments),
              'geographicSegments',
              tGeographicSegments,
            )
            .having(
              (s) => loadedField(s, (l) => l.dataOrigin),
              'dataOrigin',
              CompanyProfileDataOrigin.cache,
            ),
      ],
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'loadRequested_bothBreakdownsFail_emitsLoadingAndFailure',
      build: () {
        when(
          () => mockGetProductSegments(tTicker),
        ).thenAnswer((_) async => const Left(tFailure));
        when(
          () => mockGetGeographicSegments(tTicker),
        ).thenAnswer((_) async => const Left(Failure.server('geo error')));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const CompanySegmentsEvent.loadRequested(tTicker)),
      expect: () => [
        const CompanySegmentsState.loading(),
        const CompanySegmentsState.failure(tFailure),
      ],
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'loadRequested_alreadyLoadedSameTickerWithoutForce_skipsReload',
      build: () => bloc,
      seed: tLoadedState,
      act: (bloc) =>
          bloc.add(const CompanySegmentsEvent.loadRequested(tTicker)),
      expect: () => const <CompanySegmentsState>[],
      verify: (_) {
        verifyNever(() => mockGetProductSegments(any()));
        verifyNever(() => mockGetGeographicSegments(any()));
      },
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'loadRequested_refreshWithExistingSelection_preservesSelectedKeysAndView',
      build: () => bloc,
      seed: () => tLoadedState(isAnnualView: false, selectedAnnualKey: '2024'),
      act: (bloc) => bloc.add(
        const CompanySegmentsEvent.loadRequested(tTicker, forceRefresh: true),
      ),
      expect: () => [
        const CompanySegmentsState.loading(),
        isA<CompanySegmentsState>()
            .having(
              (s) => loadedField(s, (l) => l.selectedAnnualKey),
              'selectedAnnualKey',
              '2024',
            )
            .having(
              (s) => loadedField(s, (l) => l.selectedQuarterlyKey),
              'selectedQuarterlyKey',
              'Q2 2026',
            )
            .having(
              (s) => loadedField(s, (l) => l.isAnnualView),
              'isAnnualView',
              false,
            ),
      ],
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'loadRequested_refreshWithVanishedSelection_fallsBackToNewestKeys',
      build: () => bloc,
      seed: () => tLoadedState(
        selectedAnnualKey: '1999',
        selectedQuarterlyKey: 'Q4 1999',
      ),
      act: (bloc) => bloc.add(
        const CompanySegmentsEvent.loadRequested(tTicker, forceRefresh: true),
      ),
      expect: () => [
        const CompanySegmentsState.loading(),
        isA<CompanySegmentsState>()
            .having(
              (s) => loadedField(s, (l) => l.selectedAnnualKey),
              'selectedAnnualKey',
              '2025',
            )
            .having(
              (s) => loadedField(s, (l) => l.selectedQuarterlyKey),
              'selectedQuarterlyKey',
              'Q2 2026',
            ),
      ],
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'tabShown_staleDataAndBothBreakdownsFail_clearsAnalyticsDataSource',
      build: () {
        when(() => mockTimeProvider.nowLocal).thenReturn(tNow);
        when(
          () => mockGetProductSegments(tTicker),
        ).thenAnswer((_) async => const Left(tFailure));
        when(
          () => mockGetGeographicSegments(tTicker),
        ).thenAnswer((_) async => const Left(tFailure));
        return bloc;
      },
      seed: () => tLoadedState(
        lastUpdated: tNow.subtract(const Duration(minutes: 61)),
        analyticsState: const SegmentsTabViewState(
          ticker: tTicker,
          timestamp: '2026-01-01',
          isSuccess: true,
          loadTimeMs: 120,
          dataSource: CompanyProfileDataOrigin.api,
        ),
      ),
      act: (bloc) => bloc.add(const CompanySegmentsEvent.tabShown(tTicker)),
      expect: () => [
        const CompanySegmentsState.loading(),
        const CompanySegmentsState.failure(tFailure),
      ],
      verify: (bloc) {
        expect(bloc.analyticsSession?.isSuccess, isFalse);
        expect(bloc.analyticsSession?.dataSource, isNull);
      },
    );
  });

  group('CompanySegmentsBloc - stalenessCheckRequested', () {
    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'stalenessCheckRequested_initialState_triggersLoad',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const CompanySegmentsEvent.stalenessCheckRequested(tTicker)),
      expect: () => [
        const CompanySegmentsState.loading(),
        isA<CompanySegmentsState>().having(
          (s) => loadedField(s, (l) => l.ticker),
          'ticker',
          tTicker,
        ),
      ],
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'stalenessCheckRequested_freshLoadedState_doesNotReload',
      build: () => bloc,
      seed: tLoadedState,
      act: (bloc) =>
          bloc.add(const CompanySegmentsEvent.stalenessCheckRequested(tTicker)),
      expect: () => const <CompanySegmentsState>[],
      verify: (_) {
        verifyNever(() => mockGetProductSegments(any()));
      },
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'stalenessCheckRequested_staleLoadedState_triggersForceReload',
      build: () {
        when(() => mockTimeProvider.nowLocal).thenReturn(tNow);
        return bloc;
      },
      seed: () => tLoadedState(
        lastUpdated: tNow.subtract(const Duration(minutes: 61)),
      ),
      act: (bloc) =>
          bloc.add(const CompanySegmentsEvent.stalenessCheckRequested(tTicker)),
      expect: () => [
        const CompanySegmentsState.loading(),
        isA<CompanySegmentsState>()
            .having((s) => loadedField(s, (l) => l.ticker), 'ticker', tTicker)
            .having(
              (s) => loadedField(s, (l) => l.lastUpdated),
              'lastUpdated',
              tNow,
            ),
      ],
      verify: (_) {
        verify(() => mockGetProductSegments(tTicker)).called(1);
        verify(() => mockGetGeographicSegments(tTicker)).called(1);
      },
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'stalenessCheckRequested_nullLastUpdated_triggersForceReload',
      build: () => bloc,
      seed: () => (tLoadedState() as CompanySegmentsLoaded).copyWith(
        lastUpdated: null,
      ),
      act: (bloc) =>
          bloc.add(const CompanySegmentsEvent.stalenessCheckRequested(tTicker)),
      expect: () => [
        const CompanySegmentsState.loading(),
        isA<CompanySegmentsState>().having(
          (s) => loadedField(s, (l) => l.ticker),
          'ticker',
          tTicker,
        ),
      ],
      verify: (_) {
        verify(() => mockGetProductSegments(tTicker)).called(1);
      },
    );
  });

  group('CompanySegmentsBloc - periodChanged', () {
    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'periodChanged_toQuarterly_emitsUpdatedIsAnnualViewAndMarksAnalytics',
      build: () => bloc,
      seed: tLoadedState,
      act: (bloc) => bloc
        ..add(const CompanySegmentsEvent.tabShown(tTicker))
        ..add(const CompanySegmentsEvent.periodChanged(isAnnual: false)),
      expect: () => [
        isA<CompanySegmentsState>().having(
          (s) => loadedField(s, (l) => l.isAnnualView),
          'isAnnualView',
          false,
        ),
      ],
      verify: (bloc) {
        expect(bloc.analyticsSession?.viewedQtrlySegTab, isTrue);
      },
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'tabShown_loadedWithAnnualData_marksYearlyPeriodViewed',
      build: () => bloc,
      seed: tLoadedState,
      act: (bloc) => bloc.add(const CompanySegmentsEvent.tabShown(tTicker)),
      expect: () => const <CompanySegmentsState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession?.viewedYearlySegTab, isTrue);
      },
    );
  });

  group('CompanySegmentsBloc - periodKeySelected', () {
    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'periodKeySelected_annualKey_updatesSelectedAnnualKeyAndMarksAnalytics',
      build: () => bloc,
      seed: tLoadedState,
      act: (bloc) => bloc
        ..add(const CompanySegmentsEvent.tabShown(tTicker))
        ..add(
          const CompanySegmentsEvent.periodKeySelected('2024', isAnnual: true),
        ),
      expect: () => [
        isA<CompanySegmentsState>().having(
          (s) => loadedField(s, (l) => l.selectedAnnualKey),
          'selectedAnnualKey',
          '2024',
        ),
      ],
      verify: (bloc) {
        expect(bloc.analyticsSession?.changedYrDate, isTrue);
      },
    );

    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'periodKeySelected_quarterlyKey_updatesSelectedQuarterlyKeyAndMarksAnalytics',
      build: () => bloc,
      seed: tLoadedState,
      act: (bloc) => bloc
        ..add(const CompanySegmentsEvent.tabShown(tTicker))
        ..add(
          const CompanySegmentsEvent.periodKeySelected(
            'Q1 2026',
            isAnnual: false,
          ),
        ),
      expect: () => [
        isA<CompanySegmentsState>().having(
          (s) => loadedField(s, (l) => l.selectedQuarterlyKey),
          'selectedQuarterlyKey',
          'Q1 2026',
        ),
      ],
      verify: (bloc) {
        expect(bloc.analyticsSession?.changedQtrDate, isTrue);
      },
    );
  });

  group('CompanySegmentsBloc - reset', () {
    blocTest<CompanySegmentsBloc, CompanySegmentsState>(
      'reset_fromLoadedState_emitsInitial',
      build: () => bloc,
      seed: tLoadedState,
      act: (bloc) => bloc.add(const CompanySegmentsEvent.reset()),
      expect: () => [const CompanySegmentsState.initial()],
    );
  });
}
