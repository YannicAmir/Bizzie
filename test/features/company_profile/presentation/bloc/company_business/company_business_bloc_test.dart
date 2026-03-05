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
import 'package:mocktail/mocktail.dart';

import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/business/presentation/analytics/business_tab_analytics.dart';

class MockGetBusinessProfileUseCase extends Mock
    implements GetBusinessProfileUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockBusinessTabAnalytics extends Mock implements BusinessTabAnalytics {}

void main() {
  late CompanyBusinessBloc bloc;
  late MockGetBusinessProfileUseCase mockGetBusinessProfileUseCase;
  late MockConfigService mockConfigService;
  late MockBusinessTabAnalytics mockBusinessTabAnalytics;

  setUpAll(() {
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
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    bloc = CompanyBusinessBloc(
      mockGetBusinessProfileUseCase,
      mockConfigService,
      mockBusinessTabAnalytics,
    );
  });

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
    executives: [],
    annualFilings: [],
    quarterlyFilings: [],
  );

  final tAnalyticsState = BusinessTabViewState(
    ticker: tTicker,
    timestamp: '2024-01-01T00:00:00Z',
    isSuccess: true,
    dataSource: CompanyProfileDataOrigin.api,
  );

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

  group('CompanyBusinessBloc - Analytics', () {
    const tTicker = 'AAPL';

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'tabShown_startsSession',
      build: () => bloc,
      act: (bloc) => bloc.add(const CompanyBusinessEvent.tabShown(tTicker)),
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
      expect: () => [],
      verify: (bloc) {
        verify(
          () => mockBusinessTabAnalytics.logViewSummary(any(), isFinal: false),
        ).called(1);
      },
    );
  });
}
