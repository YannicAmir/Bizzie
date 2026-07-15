import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/business/domain/usecases/get_business_profile_usecase.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_bloc.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_event.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_state.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/tab_content_freshness_service.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bizzie/features/company_profile/business/presentation/analytics/business_tab_analytics.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';

class MockGetBusinessProfileUseCase extends Mock
    implements GetBusinessProfileUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockBusinessTabAnalytics extends Mock implements BusinessTabAnalytics {}

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
  late CompanyBusinessBloc bloc;
  late MockGetBusinessProfileUseCase mockGetBusinessProfileUseCase;
  late MockConfigService mockConfigService;
  late MockBusinessTabAnalytics mockBusinessTabAnalytics;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;
  late MockTabContentFreshnessService mockFreshnessService;

  const tTicker = 'AAPL';
  final tBusinessProfile = BusinessProfile(
    symbol: tTicker,
    companyName: 'Apple Inc.',
    sector: 'Technology',
    industry: 'Consumer Electronics',
    description: 'Tech giant',
    ceo: 'Tim Cook',
    website: 'https://apple.com',
    address: '1 Infinite Loop',
    city: 'Cupertino',
    state: 'CA',
    zip: '95014',
    phone: '1-408-996-1010',
    fullTimeEmployees: '100000',
    annualFilings: [],
    quarterlyFilings: [],
  );

  final tAnalyticsState = BusinessTabViewState(
    ticker: tTicker,
    timestamp: '2024-01-01T00:00:00Z',
    isSuccess: true,
    dataSource: CompanyProfileDataOrigin.api,
  );

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      const BusinessTabViewState(
        ticker: 'fallback',
        timestamp: '2024-01-01T00:00:00Z',
      ),
    );
  });

  setUp(() {
    mockGetBusinessProfileUseCase = MockGetBusinessProfileUseCase();
    mockConfigService = MockConfigService();
    mockBusinessTabAnalytics = MockBusinessTabAnalytics();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();
    mockFreshnessService = MockTabContentFreshnessService();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    when(
      () => mockWatchActiveTabUseCase(any()),
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockFreshnessService.isStale(any())).thenReturn(false);
    when(() => mockGetBusinessProfileUseCase(any())).thenAnswer(
      (_) async => Right((tBusinessProfile, CompanyProfileDataOrigin.cache)),
    );
    bloc = CompanyBusinessBloc(
      mockGetBusinessProfileUseCase,
      mockConfigService,
      mockBusinessTabAnalytics,
      mockWatchActiveTabUseCase,
      mockFreshnessService,
      stubbedTimeProvider(),
      stubbedGetAuthStream(),
    );
  });

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyBusinessState.initial());
  });

  group('CompanyBusinessBloc - loadRequested', () {
    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(() => mockGetBusinessProfileUseCase(tTicker)).thenAnswer(
          (_) async => Right((tBusinessProfile, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyBusinessState.loading(),
          isA<CompanyBusinessState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.businessProfile,
              orElse: () => null,
            ),
            'businessProfile',
            tBusinessProfile,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetBusinessProfileUseCase(tTicker)).called(1);
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetBusinessProfileUseCase(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyBusinessState.loading(),
          const CompanyBusinessState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        when(() => mockGetBusinessProfileUseCase(tTicker)).thenAnswer(
          (_) async => Right((tBusinessProfile, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyBusinessState.loaded(
        tBusinessProfile,
        historyLimit: 7,
        analyticsState: tAnalyticsState,
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetBusinessProfileUseCase(any()));
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoaded',
      build: () {
        // arrange
        when(() => mockGetBusinessProfileUseCase(tTicker)).thenAnswer(
          (_) async => Right((tBusinessProfile, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyBusinessState.loaded(
        tBusinessProfile,
        historyLimit: 7,
        analyticsState: tAnalyticsState,
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyBusinessEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
        // SILENT REFRESH: Should NOT emit loading if already loaded.
        return [
          isA<CompanyBusinessState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.businessProfile,
              orElse: () => null,
            ),
            'businessProfile',
            tBusinessProfile,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetBusinessProfileUseCase(tTicker)).called(1);
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'loadRequested_differentTicker_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(() => mockGetBusinessProfileUseCase('TSLA')).thenAnswer(
          (_) async => Right((
            tBusinessProfile.copyWith(symbol: 'TSLA'),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      seed: () => CompanyBusinessState.loaded(
        tBusinessProfile,
        historyLimit: 7,
        analyticsState: tAnalyticsState,
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.loadRequested('TSLA'));
      },
      expect: () {
        // assert
        return [
          const CompanyBusinessState.loading(),
          isA<CompanyBusinessState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.businessProfile.symbol,
              orElse: () => null,
            ),
            'businessProfile.symbol',
            'TSLA',
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetBusinessProfileUseCase('TSLA')).called(1);
      },
    );
  });

  group('CompanyBusinessBloc - stalenessCheckRequested', () {
    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockGetBusinessProfileUseCase(tTicker)).thenAnswer(
          (_) async => Right((tBusinessProfile, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyBusinessState.loading(),
          isA<CompanyBusinessState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.businessProfile,
              orElse: () => null,
            ),
            'businessProfile',
            tBusinessProfile,
          ),
        ];
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyBusinessState.loaded(
        tBusinessProfile,
        historyLimit: 7,
        analyticsState: tAnalyticsState,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetBusinessProfileUseCase(any()));
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockFreshnessService.isStale(any())).thenReturn(true);
        when(() => mockGetBusinessProfileUseCase(tTicker)).thenAnswer(
          (_) async => Right((tBusinessProfile, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyBusinessState.loaded(
        tBusinessProfile,
        historyLimit: 7,
        analyticsState: tAnalyticsState,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          isA<CompanyBusinessState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.businessProfile,
              orElse: () => null,
            ),
            'businessProfile',
            tBusinessProfile,
          ),
        ];
      },
    );
  });

  group('CompanyBusinessBloc - reset', () {
    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'reset_loadedState_emitsInitial',
      build: () => bloc,
      seed: () => CompanyBusinessState.loaded(
        tBusinessProfile,
        historyLimit: 7,
        analyticsState: tAnalyticsState,
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.reset());
      },
      expect: () {
        // assert
        return [const CompanyBusinessState.initial()];
      },
    );
  });

  group('CompanyBusinessBloc - Analytics', () {
    const tTicker = 'AAPL';

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'tabShown_startsSession',
      build: () => bloc,
      act: (bloc) => bloc.add(const CompanyBusinessEvent.tabShown(tTicker)),
      skip:
          2, // tabShown triggers stalenessCheck → loadRequested → loading + loaded
      expect: () => [],
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'analyticsInteractionOccurred_multipleInteractions_accumulatesState',
      build: () => bloc,
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.tabShown(tTicker));
        bloc.add(
          const CompanyBusinessEvent.analyticsInteractionOccurred(
            tappedWebsite: true,
          ),
        );
        bloc.add(
          const CompanyBusinessEvent.analyticsInteractionOccurred(
            didExpandDescription: true,
          ),
        );
      },
      skip:
          4, // tabShown → loading + loaded; each interaction emits an analytics state
      expect: () => [],
      verify: (bloc) {
        // assert
        verifyNever(
          () => mockBusinessTabAnalytics.logViewSummary(
            any(),
            isFinal: any(named: 'isFinal'),
          ),
        );
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'tabHidden_viewActive_logsFinalSummary',
      build: () {
        // arrange
        when(
          () => mockBusinessTabAnalytics.logViewSummary(
            any(),
            isFinal: any(named: 'isFinal'),
          ),
        ).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) async {
        // act
        bloc.add(const CompanyBusinessEvent.tabShown(tTicker));
        await Future.delayed(Duration.zero);
        bloc.add(
          const CompanyBusinessEvent.analyticsInteractionOccurred(
            tappedWebsite: true,
          ),
        );
        await Future.delayed(Duration.zero);
        bloc.add(const CompanyBusinessEvent.tabHidden());
      },
      skip: 3, // tabShown → loading + loaded; analyticsInteraction emits state
      expect: () => [],
      verify: (bloc) {
        // assert
        verify(
          () => mockBusinessTabAnalytics.logViewSummary(
            any(
              that: isA<BusinessTabViewState>()
                  .having((s) => s.ticker, 'ticker', tTicker)
                  .having((s) => s.tappedWebsite, 'tappedWebsite', true),
            ),
            isFinal: true,
          ),
        ).called(1);
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'appBackgrounded_logsNonFinalSummary',
      build: () {
        when(
          () => mockBusinessTabAnalytics.logViewSummary(
            any(),
            isFinal: any(named: 'isFinal'),
          ),
        ).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const CompanyBusinessEvent.tabShown(tTicker));
        bloc.add(const CompanyBusinessEvent.appBackgrounded());
      },
      skip: 2, // tabShown → loading + loaded
      expect: () => [],
      verify: (bloc) {
        verify(
          () => mockBusinessTabAnalytics.logViewSummary(any(), isFinal: false),
        ).called(1);
      },
    );
  });
}
