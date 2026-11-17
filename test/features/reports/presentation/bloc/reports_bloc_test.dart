import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
import 'package:bizzie/core/interfaces/i_lifecycle_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/core/domain/models/weekly_report.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart' as auth;
import 'package:bizzie/features/reports/domain/models/mark_reports_viewed_params.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/domain/usecases/get_dashboard_reports_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/get_seen_weekly_report_ids_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/get_user_activity_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/increment_reports_feed_view_count_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/mark_reports_viewed_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/save_seen_weekly_report_ids_usecase.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/user/domain/models/user_activity.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';
import 'package:bizzie/features/reports/presentation/analytics/reports_tracker.dart';
import 'package:bizzie/shared/models/filing_view_model.dart';
import 'dart:async';

import 'package:bizzie/core/domain/models/company.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDashboardReportsUseCase extends Mock
    implements GetDashboardReportsUseCase {}

class MockGetWatchlistUseCase extends Mock implements GetWatchlistUseCase {}

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

class MockGetUserActivityUseCase extends Mock
    implements GetUserActivityUseCase {}

class MockMarkReportsViewedUseCase extends Mock
    implements MarkReportsViewedUseCase {}

class MockReportsTracker extends Mock implements ReportsTracker {}

class MockGetSeenWeeklyReportIdsUseCase extends Mock
    implements GetSeenWeeklyReportIdsUseCase {}

class MockSaveSeenWeeklyReportIdsUseCase extends Mock
    implements SaveSeenWeeklyReportIdsUseCase {}

class MockIncrementReportsFeedViewCountUseCase extends Mock
    implements IncrementReportsFeedViewCountUseCase {}

class MockTimeProvider extends Mock implements ITimeProvider {}

class MockLifecycleService extends Mock implements ILifecycleService {}

const tMetric = FinancialMetric(
  amount: 1,
  changeAmount: 0,
  changePercent: 0,
  citationPage: 1,
);
const tDriverMetric = FinancialMetricWithDriver(
  amount: 1,
  changeAmount: 0,
  changePercent: 0,
  citationPage: 1,
);

FinancialReport tReport(String id, String formType, DateTime filingDate) =>
    FinancialReport(
      id: id,
      ticker: 'AAPL',
      dateAnalyzed: null,
      filingDate: filingDate,
      formType: formType,
      summary: const ReportSummary(
        ticker: 'AAPL',
        forwardLooking: '',
        citationPage: 1,
        reportingCurrency: 'USD',
      ),
      balanceSheet: const ReportBalanceSheet(
        equity: tMetric,
        totalAssets: tMetric,
        totalLiabilities: tMetric,
      ),
      cashFlow: const ReportCashFlow(freeCashFlow: tDriverMetric),
      income: const ReportIncome(
        costOfRevenue: tMetric,
        eps: tMetric,
        netIncome: tDriverMetric,
        revenue: tDriverMetric,
        totalExpenses: tDriverMetric,
      ),
      stockActivity: const ReportStockActivity(citationPage: 1),
    );

SecFiling tFiling(String id, String formType, DateTime date) => SecFiling(
  id: id,
  symbol: 'AAPL',
  companyName: 'Apple Inc.',
  filingDate: date,
  formType: formType,
  link: 'https://sec.gov/$id',
  summary: 'Summary',
  createdAt: date,
  analyzedAt: null,
);

String tDateId(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

void main() {
  setUpAll(() {
    registerFallbackValue(ReportsEntrySource.nav);
    registerFallbackValue(ReportsNotificationType.earningsNotification);
    registerFallbackValue(<String>{});
    registerFallbackValue(
      MarkReportsViewedParams(uid: '', timestamp: DateTime(0)),
    );
  });

  late ReportsBloc bloc;
  late MockGetDashboardReportsUseCase mockGetReportsUseCase;
  late MockGetWatchlistUseCase mockGetWatchlistUseCase;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
  late MockGetUserActivityUseCase mockGetUserActivityUseCase;
  late MockMarkReportsViewedUseCase mockMarkReportsViewedUseCase;
  late MockGetSeenWeeklyReportIdsUseCase mockGetSeenWeeklyReportIdsUseCase;
  late MockSaveSeenWeeklyReportIdsUseCase mockSaveSeenWeeklyReportIdsUseCase;
  late MockIncrementReportsFeedViewCountUseCase
  mockIncrementFeedViewCountUseCase;
  late auth.UserModel tUser;
  late MockReportsTracker mockTracker;
  late MockTimeProvider mockTimeProvider;
  late MockLifecycleService mockLifecycleService;
  late StreamController<BizzieLifecycleState> tLifecycleController;
  late DateTime tClock;

  final tNow = DateTime(2026, 5, 27, 10);
  final tToday = DateTime(2026, 5, 27);
  final tTomorrow = DateTime(2026, 5, 28);

  ReportsBloc buildBloc() => ReportsBloc(
    mockGetReportsUseCase,
    mockGetWatchlistUseCase,
    mockGetCurrentUserUseCase,
    mockGetUserActivityUseCase,
    mockMarkReportsViewedUseCase,
    mockGetSeenWeeklyReportIdsUseCase,
    mockSaveSeenWeeklyReportIdsUseCase,
    mockIncrementFeedViewCountUseCase,
    mockTracker,
    mockTimeProvider,
    mockLifecycleService,
  );

  void arrangeSession({
    required Stream<Either<Failure, ReportsFeed>> feed,
    Stream<Either<Failure, UserActivity>> activity = const Stream.empty(),
  }) {
    when(() => mockGetUserActivityUseCase(any())).thenAnswer((_) => activity);
    when(
      () => mockGetWatchlistUseCase(any()),
    ).thenAnswer((_) async => Stream.value(const Right(<Company>[])));
    when(() => mockGetReportsUseCase(any())).thenAnswer((_) => feed);
  }

  setUp(() {
    mockGetReportsUseCase = MockGetDashboardReportsUseCase();
    mockGetWatchlistUseCase = MockGetWatchlistUseCase();
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    mockGetUserActivityUseCase = MockGetUserActivityUseCase();
    mockMarkReportsViewedUseCase = MockMarkReportsViewedUseCase();
    mockGetSeenWeeklyReportIdsUseCase = MockGetSeenWeeklyReportIdsUseCase();
    mockSaveSeenWeeklyReportIdsUseCase = MockSaveSeenWeeklyReportIdsUseCase();
    mockIncrementFeedViewCountUseCase =
        MockIncrementReportsFeedViewCountUseCase();
    mockTracker = MockReportsTracker();
    mockTimeProvider = MockTimeProvider();
    mockLifecycleService = MockLifecycleService();
    tLifecycleController = StreamController<BizzieLifecycleState>.broadcast();
    tClock = tNow;

    when(() => mockTimeProvider.nowLocal).thenAnswer((_) => tClock);
    when(
      () => mockLifecycleService.onLifecycleChanged,
    ).thenAnswer((_) => tLifecycleController.stream);

    tUser = const auth.UserModel(id: 'test_uid', email: 'test@example.com');

    when(() => mockGetCurrentUserUseCase()).thenReturn(tUser);
    when(
      () => mockGetSeenWeeklyReportIdsUseCase(),
    ).thenReturn(const Right(<String>{}));
    when(
      () => mockSaveSeenWeeklyReportIdsUseCase(any()),
    ).thenAnswer((_) async => const Right(unit));
    when(
      () => mockIncrementFeedViewCountUseCase(),
    ).thenAnswer((_) async => const Right(1));
    when(
      () => mockMarkReportsViewedUseCase(any()),
    ).thenAnswer((_) async => const Right(unit));

    when(
      () => mockTracker.logFetchFailed(error: any(named: 'error')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logFeedViewed(
        unreadCount: any(named: 'unreadCount'),
        entrySource: any(named: 'entrySource'),
        notificationType: any(named: 'notificationType'),
      ),
    ).thenAnswer((_) async {});
    when(
      () =>
          mockTracker.logFilingCardCompanyClicked(ticker: any(named: 'ticker')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logUpcomingCompanyClicked(ticker: any(named: 'ticker')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logYtdCompanyClicked(ticker: any(named: 'ticker')),
    ).thenAnswer((_) async {});
    when(() => mockTracker.setLastFilingTicker(any())).thenAnswer((_) async {});
    when(
      () => mockTracker.setReportsTotalViewed(any()),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logMarketNewsOpened(
        publisher: any(named: 'publisher'),
        site: any(named: 'site'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logMarketNewsFetchFailed(error: any(named: 'error')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logSummaryViewed(
        ticker: any(named: 'ticker'),
        filingType: any(named: 'filingType'),
        wasPreviouslyPending: any(named: 'wasPreviouslyPending'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logAnalysisPendingViewed(
        ticker: any(named: 'ticker'),
        filingType: any(named: 'filingType'),
      ),
    ).thenAnswer((_) async {});

    bloc = buildBloc();
  });

  tearDown(() {
    bloc.close();
    tLifecycleController.close();
  });

  test('initialState_isCorrect', () {
    expect(bloc.state, const ReportsState.initial());
  });

  group('ReportsBloc - MarketNewsArticleOpened', () {
    blocTest<ReportsBloc, ReportsState>(
      'marketNewsArticleOpened_logsTrackerEventAndEmitsNoState',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ReportsEvent.marketNewsArticleOpened(
          publisher: 'Reuters',
          site: 'reuters.com',
        ),
      ),
      expect: () => const <ReportsState>[],
      verify: (_) {
        verify(
          () => mockTracker.logMarketNewsOpened(
            publisher: 'Reuters',
            site: 'reuters.com',
          ),
        ).called(1);
      },
    );
  });

  group('ReportsBloc - MarketNewsLoadFailed', () {
    blocTest<ReportsBloc, ReportsState>(
      'marketNewsLoadFailed_logsTrackerEventAndEmitsNoState',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ReportsEvent.marketNewsLoadFailed(error: 'Stream Error'),
      ),
      expect: () => const <ReportsState>[],
      verify: (_) {
        verify(
          () => mockTracker.logMarketNewsFetchFailed(error: 'Stream Error'),
        ).called(1);
      },
    );
  });

  group('ReportsBloc - Started', () {
    const tUserActivity = UserActivity(lastViewedReports: null);

    blocTest<ReportsBloc, ReportsState>(
      'started_subscribesToStreamsAndEmitsLoadingLoaded',
      build: () {
        arrangeSession(
          feed: Stream.value(const Right(ReportsFeed())),
          activity: Stream.value(const Right(tUserActivity)),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const ReportsEvent.started(uid: 'test_uid')),
      expect: () => [
        const ReportsState.loading(),
        ReportsState.loaded(const ReportsFeed(), today: tToday),
      ],
      verify: (_) {
        verify(() => mockGetUserActivityUseCase('test_uid')).called(1);
        verify(() => mockGetWatchlistUseCase('test_uid')).called(1);
        verify(() => mockGetReportsUseCase([])).called(1);
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'started_withoutUidAndNoCurrentUser_emitsFailure',
      build: () {
        when(() => mockGetCurrentUserUseCase()).thenReturn(null);
        return bloc;
      },
      act: (bloc) => bloc.add(const ReportsEvent.started()),
      expect: () => [
        const ReportsState.failure(Failure.server('User not authenticated')),
      ],
    );

    blocTest<ReportsBloc, ReportsState>(
      'started_reportsStreamFails_emitsFailureAndLogsFetchFailed',
      build: () {
        arrangeSession(feed: Stream.value(const Left(Failure.server('Error'))));
        return bloc;
      },
      act: (bloc) => bloc.add(const ReportsEvent.started(uid: 'test_uid')),
      expect: () => [
        const ReportsState.loading(),
        const ReportsState.failure(Failure.server('Error')),
      ],
      verify: (_) {
        verify(() => mockTracker.logFetchFailed(error: 'Error')).called(1);
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'started_reportsStreamFailsAfterLoaded_keepsLoadedStateAndLogsFailure',
      build: () {
        arrangeSession(
          feed: Stream.fromIterable(const [
            Right(ReportsFeed()),
            Left(Failure.server('Error')),
          ]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const ReportsEvent.started(uid: 'test_uid')),
      expect: () => [
        const ReportsState.loading(),
        ReportsState.loaded(const ReportsFeed(), today: tToday),
      ],
      verify: (_) {
        verify(() => mockTracker.logFetchFailed(error: 'Error')).called(1);
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'started_seenWeeklyIdsPersisted_emitsLoadedWithSeenWeeklyIds',
      build: () {
        when(
          () => mockGetSeenWeeklyReportIdsUseCase(),
        ).thenReturn(const Right({'AAPL_2026-01-01'}));
        arrangeSession(feed: Stream.value(const Right(ReportsFeed())));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ReportsEvent.started(uid: 'test_uid')),
      expect: () => [
        const ReportsState.loading(),
        ReportsState.loaded(
          const ReportsFeed(),
          today: tToday,
          seenWeeklyReportIds: const {'AAPL_2026-01-01'},
        ),
      ],
    );

    blocTest<ReportsBloc, ReportsState>(
      'started_seenWeeklyIdsLoadFails_emitsLoadedWithNoSeenWeeklyIds',
      build: () {
        when(
          () => mockGetSeenWeeklyReportIdsUseCase(),
        ).thenReturn(const Left(Failure.cache('Corrupt')));
        arrangeSession(feed: Stream.value(const Right(ReportsFeed())));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ReportsEvent.started(uid: 'test_uid')),
      expect: () => [
        const ReportsState.loading(),
        ReportsState.loaded(const ReportsFeed(), today: tToday),
      ],
    );
  });

  group('ReportsBloc - Reset', () {
    late StreamController<Either<Failure, ReportsFeed>> tFeedController;

    setUp(() {
      tFeedController =
          StreamController<Either<Failure, ReportsFeed>>.broadcast();
    });

    tearDown(() => tFeedController.close());

    blocTest<ReportsBloc, ReportsState>(
      'reset_afterStarted_cancelsSessionStreamsAndEmitsInitial',
      build: () {
        arrangeSession(feed: tFeedController.stream);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const ReportsEvent.started(uid: 'test_uid'));
        await Future<void>.delayed(Duration.zero);
        tFeedController.add(const Right(ReportsFeed()));
        await Future<void>.delayed(Duration.zero);
        bloc.add(const ReportsEvent.reset());
        await Future<void>.delayed(Duration.zero);
        tFeedController.add(const Right(ReportsFeed()));
      },
      expect: () => [
        const ReportsState.loading(),
        ReportsState.loaded(const ReportsFeed(), today: tToday),
        const ReportsState.initial(),
      ],
      verify: (_) {
        expect(tFeedController.hasListener, isFalse);
        verify(() => mockSaveSeenWeeklyReportIdsUseCase(<String>{})).called(1);
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'reset_afterPendingSummary_clearsPendingSummaryRequests',
      build: () => bloc,
      act: (bloc) async {
        bloc.add(
          const ReportsEvent.summaryRequested(
            ticker: 'AAPL',
            filingType: '10-Q',
            isReady: false,
          ),
        );
        bloc.add(const ReportsEvent.reset());
        bloc.add(
          const ReportsEvent.summaryRequested(
            ticker: 'AAPL',
            filingType: '10-Q',
            isReady: true,
          ),
        );
      },
      expect: () => [const ReportsState.initial()],
      verify: (_) {
        verify(
          () => mockTracker.logSummaryViewed(
            ticker: 'AAPL',
            filingType: '10-Q',
            wasPreviouslyPending: false,
          ),
        ).called(1);
      },
    );
  });

  group('ReportsBloc - Started past year', () {
    final tMorning = DateTime(2026, 5, 27, 9);
    final tSixMonthsAgo = DateTime(2025, 11, 27);
    final tTwoYearsAgo = DateTime(2024, 5, 27);

    final tTodayFiling = tFiling('today', '10-Q', tMorning);
    final tPastFiling = tFiling('past', '10-K/A', tSixMonthsAgo);
    final tExpiredFiling = tFiling('expired', '10-Q', tTwoYearsAgo);
    final tTodayReport = tReport('r-today', '10-Q', tMorning);
    final tPastReport = tReport('r-past', '10-K_A', tSixMonthsAgo);
    final tOtherQuarterReport = tReport(
      'r-other',
      '10-Q',
      DateTime(2026, 2, 27),
    );
    final tTodayWeekly = WeeklyReport(ticker: 'AAPL', id: tDateId(tMorning));
    final tPastWeekly = WeeklyReport(
      ticker: 'AAPL',
      id: tDateId(tSixMonthsAgo),
    );
    final tExpiredWeekly = WeeklyReport(
      ticker: 'AAPL',
      id: tDateId(tTwoYearsAgo),
    );

    final tFeed = ReportsFeed(
      currentReports: [tTodayReport],
      pastReports: [tOtherQuarterReport, tPastReport],
      filings: [tTodayFiling, tPastFiling, tExpiredFiling],
      weeklyReports: [tTodayWeekly, tPastWeekly, tExpiredWeekly],
    );

    blocTest<ReportsBloc, ReportsState>(
      'started_feedSpansYears_emitsOnlyPastYearItemsWithMatchingReports',
      build: () {
        arrangeSession(feed: Stream.value(Right(tFeed)));
        return bloc;
      },
      act: (bloc) => bloc.add(const ReportsEvent.started(uid: 'test_uid')),
      expect: () => [
        const ReportsState.loading(),
        ReportsState.loaded(
          tFeed,
          today: tToday,
          recentFilings: [
            FilingViewModel(filing: tTodayFiling, report: tTodayReport),
            FilingViewModel(filing: tPastFiling, report: tPastReport),
          ],
          recentWeeklyReports: [tTodayWeekly, tPastWeekly],
          todaysWeeklyReports: [tTodayWeekly],
        ),
      ],
    );

    blocTest<ReportsBloc, ReportsState>(
      'started_noAnalysisForFilingDate_emitsFilingWithoutReport',
      build: () {
        arrangeSession(
          feed: Stream.value(
            Right(
              ReportsFeed(
                pastReports: [tOtherQuarterReport],
                filings: [tPastFiling],
              ),
            ),
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const ReportsEvent.started(uid: 'test_uid')),
      expect: () => [
        const ReportsState.loading(),
        ReportsState.loaded(
          ReportsFeed(
            pastReports: [tOtherQuarterReport],
            filings: [tPastFiling],
          ),
          today: tToday,
          recentFilings: [FilingViewModel(filing: tPastFiling)],
        ),
      ],
    );

    blocTest<ReportsBloc, ReportsState>(
      'viewed_unseenWeeklyReportToday_persistsAndEmitsSeenWeeklyIds',
      build: () => bloc,
      seed: () => ReportsState.loaded(
        ReportsFeed(weeklyReports: [tTodayWeekly]),
        today: tToday,
        todaysWeeklyReports: [tTodayWeekly],
      ),
      act: (bloc) => bloc.add(
        const ReportsEvent.viewed(entrySource: ReportsEntrySource.nav),
      ),
      expect: () => [
        isA<ReportsLoaded>()
            .having((s) => s.seenWeeklyReportIds, 'seenWeeklyReportIds', {
              tTodayWeekly.seenKey,
            })
            .having((s) => s.lastViewedReports, 'lastViewedReports', isNotNull),
      ],
      verify: (_) {
        verify(
          () => mockSaveSeenWeeklyReportIdsUseCase({tTodayWeekly.seenKey}),
        ).called(1);
        verifyNever(() => mockMarkReportsViewedUseCase(any()));
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'viewed_onlyIfUnreadWithUnseenWeeklyReport_logsStateUnreadCount',
      build: () => bloc,
      seed: () => ReportsState.loaded(
        ReportsFeed(weeklyReports: [tTodayWeekly]),
        today: tToday,
        todaysWeeklyReports: [tTodayWeekly],
      ),
      act: (bloc) => bloc.add(
        const ReportsEvent.viewed(
          entrySource: ReportsEntrySource.nav,
          onlyIfUnread: true,
        ),
      ),
      verify: (_) {
        verify(
          () => mockTracker.logFeedViewed(
            unreadCount: 1,
            entrySource: ReportsEntrySource.nav,
          ),
        ).called(1);
        verify(
          () => mockSaveSeenWeeklyReportIdsUseCase({tTodayWeekly.seenKey}),
        ).called(1);
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'viewed_weeklyReportAlreadySeen_emitsNoStateAndSkipsPersistence',
      build: () {
        when(
          () => mockGetSeenWeeklyReportIdsUseCase(),
        ).thenReturn(Right({tTodayWeekly.seenKey}));
        return buildBloc();
      },
      seed: () => ReportsState.loaded(
        const ReportsFeed(),
        today: tToday,
        seenWeeklyReportIds: {tTodayWeekly.seenKey},
        todaysWeeklyReports: [tTodayWeekly],
      ),
      act: (bloc) => bloc.add(
        const ReportsEvent.viewed(entrySource: ReportsEntrySource.nav),
      ),
      expect: () => const <ReportsState>[],
      verify: (_) {
        verifyNever(() => mockSaveSeenWeeklyReportIdsUseCase(any()));
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'dayCheckRequested_dayChanged_emitsStateRecomputedForNewDay',
      build: () {
        tClock = DateTime(2026, 5, 28, 0, 0, 1);
        return bloc;
      },
      seed: () => ReportsState.loaded(
        tFeed,
        today: tToday,
        todaysWeeklyReports: [tTodayWeekly],
      ),
      act: (bloc) => bloc.add(const ReportsEvent.dayCheckRequested()),
      expect: () => [
        ReportsState.loaded(
          tFeed,
          today: tTomorrow,
          recentFilings: [
            FilingViewModel(filing: tTodayFiling, report: tTodayReport),
            FilingViewModel(filing: tPastFiling, report: tPastReport),
          ],
          recentWeeklyReports: [tTodayWeekly, tPastWeekly],
        ),
      ],
    );

    blocTest<ReportsBloc, ReportsState>(
      'dayCheckRequested_sameDay_emitsNoState',
      build: () => bloc,
      seed: () => ReportsState.loaded(tFeed, today: tToday),
      act: (bloc) => bloc.add(const ReportsEvent.dayCheckRequested()),
      expect: () => const <ReportsState>[],
    );

    blocTest<ReportsBloc, ReportsState>(
      'dayCheckRequested_initialState_emitsNoState',
      build: () {
        tClock = DateTime(2026, 5, 28, 0, 0, 1);
        return bloc;
      },
      act: (bloc) => bloc.add(const ReportsEvent.dayCheckRequested()),
      expect: () => const <ReportsState>[],
    );

    blocTest<ReportsBloc, ReportsState>(
      'appForegrounded_dayChanged_emitsStateForNewDay',
      build: () {
        tClock = DateTime(2026, 5, 28, 8);
        return bloc;
      },
      seed: () => ReportsState.loaded(const ReportsFeed(), today: tToday),
      act: (bloc) async {
        tLifecycleController.add(BizzieLifecycleState.foreground);
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [
        ReportsState.loaded(const ReportsFeed(), today: tTomorrow),
      ],
    );

    blocTest<ReportsBloc, ReportsState>(
      'appBackgrounded_dayChanged_emitsNoState',
      build: () {
        tClock = DateTime(2026, 5, 28, 8);
        return bloc;
      },
      seed: () => ReportsState.loaded(const ReportsFeed(), today: tToday),
      act: (bloc) async {
        tLifecycleController.add(BizzieLifecycleState.background);
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => const <ReportsState>[],
    );

    blocTest<ReportsBloc, ReportsState>(
      'started_midnightPasses_emitsStateForNewDay',
      build: () {
        tClock = DateTime(2026, 5, 27, 23, 59, 59, 950);
        arrangeSession(feed: Stream.value(const Right(ReportsFeed())));
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const ReportsEvent.started(uid: 'test_uid'));
        await Future<void>.delayed(const Duration(milliseconds: 10));
        tClock = DateTime(2026, 5, 28, 0, 0, 0, 10);
      },
      wait: const Duration(milliseconds: 150),
      expect: () => [
        const ReportsState.loading(),
        ReportsState.loaded(const ReportsFeed(), today: tToday),
        ReportsState.loaded(const ReportsFeed(), today: tTomorrow),
      ],
    );
  });

  group('ReportsBloc - Analytics', () {
    blocTest<ReportsBloc, ReportsState>(
      'filingCardCompanyClicked_logsAnalytics',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const ReportsEvent.filingCardCompanyClicked(ticker: 'AAPL')),
      verify: (_) {
        verify(
          () => mockTracker.logFilingCardCompanyClicked(ticker: 'AAPL'),
        ).called(1);
        verify(() => mockTracker.setLastFilingTicker('AAPL')).called(1);
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'upcomingCompanyClicked_logsAnalytics',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const ReportsEvent.upcomingCompanyClicked(ticker: 'TSLA')),
      verify: (_) {
        verify(
          () => mockTracker.logUpcomingCompanyClicked(ticker: 'TSLA'),
        ).called(1);
        verify(() => mockTracker.setLastFilingTicker('TSLA')).called(1);
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'ytdCompanyClicked_logsAnalytics',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const ReportsEvent.ytdCompanyClicked(ticker: 'FTNT')),
      verify: (_) {
        verify(
          () => mockTracker.logYtdCompanyClicked(ticker: 'FTNT'),
        ).called(1);
        verify(() => mockTracker.setLastFilingTicker('FTNT')).called(1);
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'viewed_logsAnalyticsAndSetsUserProperty',
      build: () {
        when(
          () => mockIncrementFeedViewCountUseCase(),
        ).thenAnswer((_) async => const Right(6));
        return bloc;
      },
      seed: () => ReportsState.loaded(const ReportsFeed(), today: tToday),
      act: (bloc) => bloc.add(
        const ReportsEvent.viewed(entrySource: ReportsEntrySource.nav),
      ),
      verify: (_) {
        verify(
          () => mockTracker.logFeedViewed(
            unreadCount: 0,
            entrySource: ReportsEntrySource.nav,
          ),
        ).called(1);
        verify(() => mockIncrementFeedViewCountUseCase()).called(1);
        verify(() => mockTracker.setReportsTotalViewed(6)).called(1);
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'viewed_stateNotLoaded_skipsFeedView',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ReportsEvent.viewed(entrySource: ReportsEntrySource.nav),
      ),
      expect: () => const <ReportsState>[],
      verify: (_) {
        verifyNever(
          () => mockTracker.logFeedViewed(
            unreadCount: any(named: 'unreadCount'),
            entrySource: any(named: 'entrySource'),
            notificationType: any(named: 'notificationType'),
          ),
        );
        verifyNever(() => mockIncrementFeedViewCountUseCase());
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'viewed_onlyIfUnreadWithNothingUnread_skipsFeedView',
      build: () => bloc,
      seed: () => ReportsState.loaded(const ReportsFeed(), today: tToday),
      act: (bloc) => bloc.add(
        const ReportsEvent.viewed(
          entrySource: ReportsEntrySource.nav,
          onlyIfUnread: true,
        ),
      ),
      expect: () => const <ReportsState>[],
      verify: (_) {
        verifyNever(
          () => mockTracker.logFeedViewed(
            unreadCount: any(named: 'unreadCount'),
            entrySource: any(named: 'entrySource'),
            notificationType: any(named: 'notificationType'),
          ),
        );
        verifyNever(() => mockIncrementFeedViewCountUseCase());
      },
    );

    blocTest<ReportsBloc, ReportsState>(
      'viewed_viewCountIncrementFails_logsFeedViewedWithoutTotalViewed',
      build: () {
        when(
          () => mockIncrementFeedViewCountUseCase(),
        ).thenAnswer((_) async => const Left(Failure.cache('Error')));
        return bloc;
      },
      seed: () => ReportsState.loaded(const ReportsFeed(), today: tToday),
      act: (bloc) => bloc.add(
        const ReportsEvent.viewed(entrySource: ReportsEntrySource.nav),
      ),
      expect: () => const <ReportsState>[],
      verify: (_) {
        verify(
          () => mockTracker.logFeedViewed(
            unreadCount: 0,
            entrySource: ReportsEntrySource.nav,
          ),
        ).called(1);
        verifyNever(() => mockTracker.setReportsTotalViewed(any()));
      },
    );
  });
}
