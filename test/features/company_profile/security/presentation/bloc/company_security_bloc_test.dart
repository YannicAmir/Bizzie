import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_security_details_usecase.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/analytics/security_tab_analytics.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/market_hours_freshness_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';

class MockGetSecurityDetailsUseCase extends Mock
    implements GetSecurityDetailsUseCase {}

class MockSecurityTabAnalytics extends Mock implements SecurityTabAnalytics {}

class MockWatchActiveTabUseCase extends Mock implements WatchActiveTabUseCase {}

class MockGetAuthStream extends Mock implements GetAuthStream {}

class MockMarketHoursFreshnessService extends Mock
    implements MarketHoursFreshnessService {}

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
  late CompanySecurityBloc bloc;
  late MockGetSecurityDetailsUseCase mockGetSecurityDetails;
  late MockSecurityTabAnalytics mockTracker;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;
  late MockMarketHoursFreshnessService mockFreshnessService;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      const SecurityTabViewState(
        ticker: 'AAPL',
        securityType: 'company',
        timestamp: '2024-01-01T00:00:00Z',
      ),
    );
  });

  setUp(() {
    mockGetSecurityDetails = MockGetSecurityDetailsUseCase();
    mockTracker = MockSecurityTabAnalytics();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();
    mockFreshnessService = MockMarketHoursFreshnessService();

    when(
      () => mockWatchActiveTabUseCase(any()),
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockFreshnessService.isStale(any())).thenReturn(false);
    bloc = CompanySecurityBloc(
      mockGetSecurityDetails,
      mockTracker,
      mockWatchActiveTabUseCase,
      mockFreshnessService,
      stubbedTimeProvider(),
      stubbedGetAuthStream(),
    );
  });

  tearDown(() => bloc.close());

  const tTicker = 'AAPL';
  const tSecurityDetails = SecurityDetails(
    ticker: tTicker,
    name: 'Apple Inc.',
    sector: 'Technology',
    industry: 'Consumer Electronics',
    description: 'Apple description',
    currency: 'USD',
    isEtf: false,
    isFund: false,
    isActivelyTrading: true,
  );
  final tAnalyticsState = SecurityTabViewState(
    ticker: tTicker,
    securityType: 'company',
    timestamp: '2024-01-01T00:00:00Z',
    isSuccess: true,
    dataSource: CompanyProfileDataOrigin.api,
    loadTimeMs: 0,
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanySecurityState.initial());
  });

  group('CompanySecurityBloc - loadRequested', () {
    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(() => mockGetSecurityDetails(tTicker)).thenAnswer(
          (_) async =>
              const Right((tSecurityDetails, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySecurityState.loading(),
          isA<CompanySecurityState>()
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.securityDetails,
                  orElse: () => null,
                ),
                'securityDetails',
                tSecurityDetails,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.analyticsState.ticker,
                  orElse: () => '',
                ),
                'analyticsState.ticker',
                tTicker,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.analyticsState.isSuccess,
                  orElse: () => false,
                ),
                'analyticsState.isSuccess',
                true,
              ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetSecurityDetails(tTicker)).called(1);
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetSecurityDetails(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySecurityState.loading(),
          const CompanySecurityState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanySecurityState.loaded(
        tSecurityDetails,
        analyticsState: tAnalyticsState,
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.loadRequested(tTicker));
      },
      expect: () => [],
      verify: (_) {
        // assert
        verifyNever(() => mockGetSecurityDetails(any()));
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(() => mockGetSecurityDetails(tTicker)).thenAnswer(
          (_) async =>
              const Right((tSecurityDetails, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanySecurityState.loaded(
        tSecurityDetails,
        analyticsState: tAnalyticsState,
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanySecurityEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
        return [
          isA<CompanySecurityState>()
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.securityDetails,
                  orElse: () => null,
                ),
                'securityDetails',
                tSecurityDetails,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.analyticsState.ticker,
                  orElse: () => '',
                ),
                'analyticsState.ticker',
                tTicker,
              ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetSecurityDetails(tTicker)).called(1);
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'loadRequested_unsupported_emitsLoadingAndUnsupported',
      build: () {
        // arrange
        const unsupportedDetails = SecurityDetails(
          ticker: tTicker,
          name: 'ETF',
          sector: 'N/A',
          industry: 'N/A',
          description: '',
          currency: 'USD',
          isEtf: true,
          isFund: false,
          isActivelyTrading: true,
        );
        when(() => mockGetSecurityDetails(tTicker)).thenAnswer(
          (_) async =>
              const Right((unsupportedDetails, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySecurityState.loading(),
          isA<CompanySecurityState>()
              .having(
                (s) => s.maybeMap(
                  unsupported: (u) => u.securityDetails.isEtf,
                  orElse: () => false,
                ),
                'isEtf',
                true,
              )
              .having(
                (s) => s.maybeMap(
                  unsupported: (u) => u.analyticsState.securityType,
                  orElse: () => '',
                ),
                'analyticsState.securityType',
                'etf',
              ),
        ];
      },
    );
  });

  group('CompanySecurityBloc - stalenessCheckRequested', () {
    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockGetSecurityDetails(tTicker)).thenAnswer(
          (_) async =>
              const Right((tSecurityDetails, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySecurityState.loading(),
          isA<CompanySecurityState>()
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.securityDetails,
                  orElse: () => null,
                ),
                'securityDetails',
                tSecurityDetails,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.analyticsState.ticker,
                  orElse: () => '',
                ),
                'analyticsState.ticker',
                tTicker,
              ),
        ];
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanySecurityState.loaded(
        tSecurityDetails,
        analyticsState: tAnalyticsState,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetSecurityDetails(any()));
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockFreshnessService.isStale(any())).thenReturn(true);
        when(() => mockGetSecurityDetails(tTicker)).thenAnswer(
          (_) async =>
              const Right((tSecurityDetails, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanySecurityState.loaded(
        tSecurityDetails,
        analyticsState: tAnalyticsState,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          isA<CompanySecurityState>()
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.securityDetails,
                  orElse: () => null,
                ),
                'securityDetails',
                tSecurityDetails,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.analyticsState.ticker,
                  orElse: () => '',
                ),
                'analyticsState.ticker',
                tTicker,
              ),
        ];
      },
    );
  });

  group('CompanySecurityBloc - Lifecycle Orchestration', () {
    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'tabHidden_viewActive_logsFinalSummary',
      build: () {
        // arrange
        when(
          () =>
              mockTracker.logViewSummary(any(), isFinal: any(named: 'isFinal')),
        ).thenAnswer((_) async {});
        return bloc;
      },
      seed: () => CompanySecurityState.loaded(
        tSecurityDetails,
        analyticsState: tAnalyticsState,
      ),
      act: (bloc) async {
        // act
        bloc.add(const CompanySecurityEvent.tabShown(tTicker));
        await Future.delayed(Duration.zero);
        bloc.add(const CompanySecurityEvent.tabHidden());
      },
      verify: (_) {
        // assert
        verify(
          () => mockTracker.logViewSummary(any(), isFinal: true),
        ).called(1);
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'appBackgrounded_viewActive_logsNonFinalSummary',
      build: () {
        // arrange
        when(
          () =>
              mockTracker.logViewSummary(any(), isFinal: any(named: 'isFinal')),
        ).thenAnswer((_) async {});
        return bloc;
      },
      seed: () => CompanySecurityState.loaded(
        tSecurityDetails,
        analyticsState: tAnalyticsState,
      ),
      act: (bloc) async {
        // act
        bloc.add(const CompanySecurityEvent.tabShown(tTicker));
        await Future.delayed(Duration.zero);
        bloc.add(const CompanySecurityEvent.appBackgrounded());
      },
      verify: (_) {
        // assert
        verify(
          () => mockTracker.logViewSummary(any(), isFinal: false),
        ).called(1);
      },
    );
  });
}
