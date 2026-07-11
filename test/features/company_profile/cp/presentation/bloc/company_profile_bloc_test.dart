import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
import 'package:bizzie/core/interfaces/i_lifecycle_service.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_analytics.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_session_summary.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:async';

class MockCompanyProfileAnalytics extends Mock
    implements CompanyProfileAnalytics {}

class MockLifecycleService extends Mock implements ILifecycleService {}

void main() {
  late CompanyProfileBloc bloc;
  late MockCompanyProfileAnalytics mockAnalytics;
  late MockLifecycleService mockLifecycleService;
  late StreamController<BizzieLifecycleState> lifecycleController;

  setUpAll(() {
    registerFallbackValue(
      CompanyProfileSessionSummary(
        sessionId: '',
        ticker: '',
        companyName: '',
        tabsCount: 0,
        tabsList: [],
        durationSeconds: 0,
        isWatchlisted: false,
        initWatchlisted: false,
        isCompany: false,
        isEtf: false,
        isFund: false,
        isFinal: false,
      ),
    );
  });

  setUp(() {
    mockAnalytics = MockCompanyProfileAnalytics();
    mockLifecycleService = MockLifecycleService();
    lifecycleController = StreamController<BizzieLifecycleState>.broadcast();

    when(
      () => mockLifecycleService.onLifecycleChanged,
    ).thenAnswer((_) => lifecycleController.stream);

    when(() => mockAnalytics.logSessionSummary(any())).thenAnswer((_) async {});

    bloc = CompanyProfileBloc(mockAnalytics, mockLifecycleService);
  });

  tearDown(() {
    lifecycleController.close();
    bloc.close();
  });

  group('CompanyProfileBloc', () {
    test('initialState_noEvents_isInitial', () {
      // Assert
      expect(bloc.state, const CompanyProfileState.initial());
    });

    blocTest<CompanyProfileBloc, CompanyProfileState>(
      'opened_validEvent_emitsActiveState',
      build: () => bloc,
      // Act
      act: (bloc) => bloc.add(
        const CompanyProfileEvent.opened(
          ticker: 'AAPL',
          companyName: 'Apple Inc.',
          industry: 'Tech',
          sector: 'Technology',
          initialTabName: 'security',
          isWatchlisted: false,
          isCompany: true,
          isEtf: false,
          isFund: false,
        ),
      ),
      // Assert
      expect: () => [
        isA<CompanyProfileState>()
            .having(
              (s) => s.maybeMap(active: (a) => a.sessionId, orElse: () => ''),
              'sessionId',
              isNotEmpty,
            )
            .having(
              (s) => s.maybeMap(active: (a) => a.ticker, orElse: () => ''),
              'ticker',
              'AAPL',
            ),
      ],
      verify: (_) {
        verifyNever(() => mockAnalytics.logSessionSummary(any()));
      },
    );

    blocTest<CompanyProfileBloc, CompanyProfileState>(
      'opened_duplicateTicker_isIdempotent',
      build: () => bloc,
      seed: () => CompanyProfileState.active(
        sessionId: 'old-session-id',
        ticker: 'AAPL',
        companyName: 'Apple Inc.',
        industry: 'Tech',
        sector: 'Technology',
        initiallyWatchlisted: false,
        currentWatchlisted: false,
        isCompany: true,
        isEtf: false,
        isFund: false,
        viewedTabs: const {'security'},
        activeTabName: 'security',
        accumulatedSeconds: 0,
        lastActiveStartTime: DateTime.now(),
        lifecycleState: BizzieLifecycleState.foreground,
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyProfileEvent.opened(
          ticker: 'AAPL',
          companyName: 'Apple Inc.',
          industry: 'Tech',
          sector: 'Technology',
          initialTabName: 'security',
          isWatchlisted: false,
          isCompany: true,
          isEtf: false,
          isFund: false,
        ),
      ),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockAnalytics.logSessionSummary(any()));
      },
    );

    blocTest<CompanyProfileBloc, CompanyProfileState>(
      'tabViewed_validTab_updatesViewedTabs',
      // Arrange
      seed: () => CompanyProfileState.active(
        sessionId: '123',
        ticker: 'AAPL',
        companyName: 'Apple Inc.',
        industry: 'Tech',
        sector: 'Technology',
        initiallyWatchlisted: false,
        currentWatchlisted: false,
        isCompany: true,
        isEtf: false,
        isFund: false,
        viewedTabs: const {},
        activeTabName: 'Overview',
        accumulatedSeconds: 0,
        lastActiveStartTime: DateTime.now(),
        lifecycleState: BizzieLifecycleState.foreground,
      ),
      build: () => bloc,
      // Act
      act: (bloc) =>
          bloc.add(const CompanyProfileEvent.tabViewed(tabName: 'News')),
      // Assert
      expect: () => [
        isA<CompanyProfileState>().having(
          (s) => s.maybeMap(active: (a) => a.viewedTabs, orElse: () => {}),
          'viewedTabs',
          contains('News'),
        ),
      ],
    );

    blocTest<CompanyProfileBloc, CompanyProfileState>(
      'lifecycleChanged_background_triggersSnapshot',
      // Arrange
      seed: () => CompanyProfileState.active(
        sessionId: '123',
        ticker: 'AAPL',
        companyName: 'Apple Inc.',
        industry: 'Tech',
        sector: 'Technology',
        initiallyWatchlisted: false,
        currentWatchlisted: false,
        isCompany: true,
        isEtf: false,
        isFund: false,
        viewedTabs: const {'Overview'},
        activeTabName: 'Overview',
        accumulatedSeconds: 10,
        lastActiveStartTime: DateTime.now().subtract(
          const Duration(seconds: 5),
        ),
        lifecycleState: BizzieLifecycleState.foreground,
      ),
      build: () => bloc,
      // Act
      act: (bloc) => bloc.add(
        const CompanyProfileEvent.lifecycleChanged(
          state: BizzieLifecycleState.background,
        ),
      ),
      // Assert
      verify: (_) {
        verify(
          () => mockAnalytics.logSessionSummary(
            any(
              that: predicate((CompanyProfileSessionSummary summary) {
                return summary.ticker == 'AAPL' && !summary.isFinal;
              }),
            ),
          ),
        ).called(1);
      },
    );

    blocTest<CompanyProfileBloc, CompanyProfileState>(
      'lifecycleChanged_foreground_updatesStartTime',
      // Arrange
      seed: () => CompanyProfileState.active(
        sessionId: '123',
        ticker: 'AAPL',
        companyName: 'Apple Inc.',
        industry: 'Tech',
        sector: 'Technology',
        initiallyWatchlisted: false,
        currentWatchlisted: false,
        isCompany: true,
        isEtf: false,
        isFund: false,
        viewedTabs: const {'Overview'},
        activeTabName: 'Overview',
        accumulatedSeconds: 10,
        lastActiveStartTime: DateTime.now().subtract(const Duration(hours: 1)),
        lifecycleState: BizzieLifecycleState.background,
      ),
      build: () => bloc,
      // Act
      act: (bloc) => bloc.add(
        const CompanyProfileEvent.lifecycleChanged(
          state: BizzieLifecycleState.foreground,
        ),
      ),
      // Assert
      expect: () => [
        isA<CompanyProfileState>().having(
          (s) => s.maybeMap(
            active: (a) => a.lastActiveStartTime,
            orElse: () => DateTime(0),
          ),
          'lastActiveStartTime',
          predicate(
            (DateTime d) =>
                d.isAfter(DateTime.now().subtract(const Duration(seconds: 5))),
          ),
        ),
      ],
    );

    blocTest<CompanyProfileBloc, CompanyProfileState>(
      'watchlistStatusChanged_validEvent_updatesState',
      // Arrange
      seed: () => CompanyProfileState.active(
        sessionId: '123',
        ticker: 'AAPL',
        companyName: 'Apple Inc.',
        industry: 'Tech',
        sector: 'Technology',
        initiallyWatchlisted: false,
        currentWatchlisted: false,
        isCompany: true,
        isEtf: false,
        isFund: false,
        viewedTabs: const {'Overview'},
        activeTabName: 'Overview',
        accumulatedSeconds: 0,
        lastActiveStartTime: DateTime.now(),
        lifecycleState: BizzieLifecycleState.foreground,
      ),
      build: () => bloc,
      // Act
      act: (bloc) => bloc.add(
        const CompanyProfileEvent.watchlistStatusChanged(isWatchlisted: true),
      ),
      // Assert
      expect: () => [
        isA<CompanyProfileState>().having(
          (s) => s.maybeMap(
            active: (a) => a.currentWatchlisted,
            orElse: () => false,
          ),
          'currentWatchlisted',
          true,
        ),
      ],
    );

    blocTest<CompanyProfileBloc, CompanyProfileState>(
      'editTabsOpened_activeSession_logsEditTabsOpened',
      // Arrange
      seed: () => CompanyProfileState.active(
        sessionId: '123',
        ticker: 'AAPL',
        companyName: 'Apple Inc.',
        industry: 'Tech',
        sector: 'Technology',
        initiallyWatchlisted: false,
        currentWatchlisted: false,
        isCompany: true,
        isEtf: false,
        isFund: false,
        viewedTabs: const {'Overview'},
        activeTabName: 'Overview',
        accumulatedSeconds: 0,
        lastActiveStartTime: DateTime.now(),
        lifecycleState: BizzieLifecycleState.foreground,
      ),
      build: () => bloc,
      setUp: () {
        when(
          () => mockAnalytics.logEditTabsOpened(
            ticker: any(named: 'ticker'),
            isSubscribed: any(named: 'isSubscribed'),
          ),
        ).thenAnswer((_) async {});
      },
      // Act
      act: (bloc) => bloc.add(
        const CompanyProfileEvent.editTabsOpened(isSubscribed: true),
      ),
      // Assert
      expect: () => [],
      verify: (_) {
        verify(
          () => mockAnalytics.logEditTabsOpened(
            ticker: 'AAPL',
            isSubscribed: true,
          ),
        ).called(1);
      },
    );

    blocTest<CompanyProfileBloc, CompanyProfileState>(
      'editTabsOpened_noActiveSession_doesNotLog',
      build: () => bloc,
      // Act
      act: (bloc) => bloc.add(
        const CompanyProfileEvent.editTabsOpened(isSubscribed: false),
      ),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(
          () => mockAnalytics.logEditTabsOpened(
            ticker: any(named: 'ticker'),
            isSubscribed: any(named: 'isSubscribed'),
          ),
        );
      },
    );

    blocTest<CompanyProfileBloc, CompanyProfileState>(
      'tabOrderSaved_activeSession_logsEditTabsSavedWithExactOrder',
      // Arrange
      seed: () => CompanyProfileState.active(
        sessionId: '123',
        ticker: 'AAPL',
        companyName: 'Apple Inc.',
        industry: 'Tech',
        sector: 'Technology',
        initiallyWatchlisted: false,
        currentWatchlisted: false,
        isCompany: true,
        isEtf: false,
        isFund: false,
        viewedTabs: const {'Overview'},
        activeTabName: 'Overview',
        accumulatedSeconds: 0,
        lastActiveStartTime: DateTime.now(),
        lifecycleState: BizzieLifecycleState.foreground,
      ),
      build: () => bloc,
      setUp: () {
        when(
          () => mockAnalytics.logEditTabsSaved(
            ticker: any(named: 'ticker'),
            isSubscribed: any(named: 'isSubscribed'),
            mainTabs: any(named: 'mainTabs'),
            moreTabs: any(named: 'moreTabs'),
          ),
        ).thenAnswer((_) async {});
      },
      // Act
      act: (bloc) => bloc.add(
        const CompanyProfileEvent.tabOrderSaved(
          isSubscribed: true,
          mainTabs: ['chat', 'fcps', 'revenue'],
          moreTabs: ['news', 'free_cash'],
        ),
      ),
      // Assert
      expect: () => [],
      verify: (_) {
        verify(
          () => mockAnalytics.logEditTabsSaved(
            ticker: 'AAPL',
            isSubscribed: true,
            mainTabs: const ['chat', 'fcps', 'revenue'],
            moreTabs: const ['news', 'free_cash'],
          ),
        ).called(1);
      },
    );

    blocTest<CompanyProfileBloc, CompanyProfileState>(
      'closed_validSession_emitsInitialAndLogsFinalSnapshot',
      // Arrange
      seed: () => CompanyProfileState.active(
        sessionId: '123',
        ticker: 'AAPL',
        companyName: 'Apple Inc.',
        industry: 'Tech',
        sector: 'Technology',
        initiallyWatchlisted: false,
        currentWatchlisted: true,
        isCompany: true,
        isEtf: false,
        isFund: false,
        viewedTabs: const {'Overview', 'News'},
        activeTabName: 'Overview',
        accumulatedSeconds: 20,
        lastActiveStartTime: DateTime.now().subtract(
          const Duration(seconds: 10),
        ),
        lifecycleState: BizzieLifecycleState.foreground,
      ),
      build: () => bloc,
      // Act
      act: (bloc) => bloc.add(const CompanyProfileEvent.closed()),
      // Assert
      expect: () => [const CompanyProfileState.initial()],
      verify: (_) {
        verify(
          () => mockAnalytics.logSessionSummary(
            any(
              that: predicate((CompanyProfileSessionSummary summary) {
                return summary.ticker == 'AAPL' &&
                    summary.isFinal &&
                    summary.tabsList.contains('News');
              }),
            ),
          ),
        ).called(1);
      },
    );
  });
}
