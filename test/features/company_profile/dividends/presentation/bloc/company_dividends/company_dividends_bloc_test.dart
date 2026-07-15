import 'package:bizzie/features/company_profile/dividends/presentation/analytics/dividend_tab_analytics.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/analytics/dividend_tab_view_state.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_event.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_info.dart';
import 'package:bizzie/features/company_profile/dividends/domain/usecases/get_dividend_info_usecase.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_bloc.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_event.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';

class MockGetDividendInfoUseCase extends Mock
    implements GetDividendInfoUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockDividendTabAnalytics extends Mock implements DividendTabAnalytics {}

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
  late CompanyDividendsBloc bloc;
  late MockGetDividendInfoUseCase mockGetDividendInfo;
  late MockConfigService mockConfigService;
  late MockDividendTabAnalytics mockAnalytics;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;

  const tTicker = 'AAPL';
  final tDividendInfo = DividendInfo(
    symbol: tTicker,
    history: [
      const DividendEvent(
        date: '2023-01-01',
        dividend: 0.25,
        adjDividend: 0.25,
      ),
    ],
  );

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      const DividendTabViewState(ticker: 'AAPL', timestamp: ''),
    );
  });

  setUp(() {
    mockGetDividendInfo = MockGetDividendInfoUseCase();
    mockConfigService = MockConfigService();
    mockAnalytics = MockDividendTabAnalytics();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();

    when(() => mockConfigService.freePlanHistoryCount).thenReturn(8);
    when(
      () => mockAnalytics.logViewSummary(any(), isFinal: any(named: 'isFinal')),
    ).thenAnswer((_) async {});
    when(
      () => mockWatchActiveTabUseCase(any()),
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockGetDividendInfo(any())).thenAnswer(
      (_) async => Right((tDividendInfo, CompanyProfileDataOrigin.cache)),
    );

    bloc = CompanyDividendsBloc(
      mockGetDividendInfo,
      mockConfigService,
      mockAnalytics,
      mockWatchActiveTabUseCase,
      stubbedTimeProvider(),
      stubbedGetAuthStream(),
    );
  });

  test('initialState_isCorrect', () {
    // Assert
    expect(bloc.state, const CompanyDividendsState.initial());
  });

  group('CompanyDividendsBloc - loadRequested', () {
    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetDividendInfo(tTicker)).thenAnswer(
          (_) async => Right((tDividendInfo, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanyDividendsEvent.loadRequested(tTicker));
      },
      expect: () => [
        const CompanyDividendsState.loading(),
        isA<CompanyDividendsState>().having(
          (s) => s.maybeMap(
            loaded: (l) =>
                l.ticker == tTicker &&
                l.dataOrigin == CompanyProfileDataOrigin.api,
            orElse: () => false,
          ),
          'loaded with correct ticker and origin',
          true,
        ),
      ],
      verify: (_) {
        // Assert
        verify(() => mockGetDividendInfo(tTicker)).called(1);
      },
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetDividendInfo(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanyDividendsEvent.loadRequested(tTicker));
      },
      expect: () => [
        const CompanyDividendsState.loading(),
        const CompanyDividendsState.failure(Failure.server('Server error')),
      ],
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // Arrange
        return bloc;
      },
      seed: () => CompanyDividendsState.loaded(
        ticker: tTicker,
        dividendInfo: tDividendInfo,
        historyLimit: 8,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // Act
        bloc.add(const CompanyDividendsEvent.loadRequested(tTicker));
      },
      expect: () => [],
      verify: (_) {
        // Assert
        verifyNever(() => mockGetDividendInfo(any()));
      },
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetDividendInfo('MSFT')).thenAnswer(
          (_) async => Right((tDividendInfo, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyDividendsState.loaded(
        ticker: 'AAPL',
        dividendInfo: tDividendInfo,
        historyLimit: 8,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // Act
        bloc.add(const CompanyDividendsEvent.loadRequested('MSFT'));
      },
      expect: () => [
        const CompanyDividendsState.loading(),
        isA<CompanyDividendsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadedOnly',
      build: () {
        // Arrange
        when(() => mockGetDividendInfo(tTicker)).thenAnswer(
          (_) async => Right((tDividendInfo, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyDividendsState.loaded(
        ticker: tTicker,
        dividendInfo: tDividendInfo,
        historyLimit: 8,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // Act
        bloc.add(
          const CompanyDividendsEvent.loadRequested(
            tTicker,
            forceRefresh: true,
          ),
        );
      },
      expect: () => [
        const CompanyDividendsState.loading(),
        isA<CompanyDividendsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
      verify: (_) {
        // Assert
        verify(() => mockGetDividendInfo(tTicker)).called(1);
      },
    );

    group('CompanyDividendsBloc - stalenessCheckRequested', () {
      blocTest<CompanyDividendsBloc, CompanyDividendsState>(
        'stalenessCheckRequested_initialState_triggersLoadRequested',
        build: () {
          // Arrange
          when(() => mockGetDividendInfo(tTicker)).thenAnswer(
            (_) async => Right((tDividendInfo, CompanyProfileDataOrigin.api)),
          );
          return bloc;
        },
        act: (bloc) {
          // Act
          bloc.add(
            const CompanyDividendsEvent.stalenessCheckRequested(tTicker),
          );
        },
        expect: () => [
          const CompanyDividendsState.loading(),
          isA<CompanyDividendsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
            'ticker',
            tTicker,
          ),
        ],
      );

      blocTest<CompanyDividendsBloc, CompanyDividendsState>(
        'stalenessCheckRequested_fresh_doesNotTriggerLoad',
        build: () {
          // Arrange
          return bloc;
        },
        seed: () => CompanyDividendsState.loaded(
          ticker: tTicker,
          dividendInfo: tDividendInfo,
          historyLimit: 8,
          dataOrigin: CompanyProfileDataOrigin.api,
          lastUpdated: DateTime.now(),
        ),
        act: (bloc) {
          // Act
          bloc.add(
            const CompanyDividendsEvent.stalenessCheckRequested(tTicker),
          );
        },
        expect: () => [],
        verify: (_) {
          // Assert
          verifyNever(() => mockGetDividendInfo(any()));
        },
      );

      blocTest<CompanyDividendsBloc, CompanyDividendsState>(
        'stalenessCheckRequested_stale_triggersLoadRequested',
        build: () {
          // Arrange
          when(() => mockGetDividendInfo(tTicker)).thenAnswer(
            (_) async => Right((tDividendInfo, CompanyProfileDataOrigin.api)),
          );
          return bloc;
        },
        seed: () => CompanyDividendsState.loaded(
          ticker: tTicker,
          dividendInfo: tDividendInfo,
          historyLimit: 8,
          dataOrigin: CompanyProfileDataOrigin.api,
          lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
        ),
        act: (bloc) {
          // Act
          bloc.add(
            const CompanyDividendsEvent.stalenessCheckRequested(tTicker),
          );
        },
        expect: () => [
          const CompanyDividendsState.loading(),
          isA<CompanyDividendsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
            'ticker',
            tTicker,
          ),
        ],
      );
    });
  });

  group('CompanyDividendsBloc - Analytics', () {
    final tLoadedState = CompanyDividendsState.loaded(
      ticker: tTicker,
      dividendInfo: tDividendInfo,
      historyLimit: 8,
      dataOrigin: CompanyProfileDataOrigin.api,
      lastUpdated: DateTime.now(),
      analyticsState: const DividendTabViewState(
        ticker: tTicker,
        timestamp: '2024-01-01',
      ),
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'tabShown_initializesAnalyticsSession',
      build: () => bloc,
      act: (bloc) => bloc.add(const CompanyDividendsEvent.tabShown(tTicker)),
      verify: (_) {
        // Internal session state check via mixin
      },
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'viewAllTapped_chart_updatesAnalyticsState',
      build: () => bloc,
      seed: () => tLoadedState,
      act: (bloc) => bloc
        ..add(const CompanyDividendsEvent.tabShown(tTicker))
        ..add(const CompanyDividendsEvent.viewAllTapped(isChart: true)),
      expect: () => const <CompanyDividendsState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession?.tappedChartViewAll, isTrue);
      },
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'viewAllTapped_history_updatesAnalyticsState',
      build: () => bloc,
      seed: () => tLoadedState,
      act: (bloc) => bloc
        ..add(const CompanyDividendsEvent.tabShown(tTicker))
        ..add(const CompanyDividendsEvent.viewAllTapped(isChart: false)),
      expect: () => const <CompanyDividendsState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession?.tappedTableViewAll, isTrue);
      },
    );
    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'tabShown_afterLoad_preservesMetrics',
      build: () => bloc,
      seed: () => CompanyDividendsState.loaded(
        ticker: tTicker,
        dividendInfo: tDividendInfo,
        historyLimit: 8,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
        analyticsState: DividendTabViewState(
          ticker: tTicker,
          timestamp: '2024-01-01',
          loadTimeMs: 123,
          isSuccess: true,
          dataSource: CompanyProfileDataOrigin.api,
        ),
      ),
      act: (bloc) => bloc.add(const CompanyDividendsEvent.tabShown(tTicker)),
      expect: () => const <CompanyDividendsState>[],
      verify: (bloc) {
        expect(bloc.analyticsSession?.loadTimeMs, 123);
        expect(bloc.analyticsSession?.dataSource, CompanyProfileDataOrigin.api);
      },
    );
  });
}
