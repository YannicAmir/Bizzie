import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart' as auth;
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/domain/usecases/get_dashboard_reports_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/get_user_activity_use_case.dart';
import 'package:bizzie/features/reports/domain/usecases/mark_reports_viewed_use_case.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/user/domain/models/user_activity.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';
import 'package:bizzie/features/reports/presentation/analytics/reports_tracker.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDashboardReportsUseCase extends Mock
    implements GetDashboardReportsUseCase {}

class MockIWatchlistRepository extends Mock implements IWatchlistRepository {}

class MockIAuthRepository extends Mock implements IAuthRepository {}

class MockGetUserActivityUseCase extends Mock
    implements GetUserActivityUseCase {}

class MockMarkReportsViewedUseCase extends Mock
    implements MarkReportsViewedUseCase {}

class MockReportsTracker extends Mock implements ReportsTracker {}

class MockIUserRepository extends Mock implements IUserRepository {}

class MockILocalStorageService extends Mock implements ILocalStorageService {}

void main() {
  setUpAll(() {
    registerFallbackValue(ReportsEntrySource.nav);
    registerFallbackValue(ReportsNotificationType.earningsNotification);
  });

  late ReportsBloc bloc;
  late MockGetDashboardReportsUseCase mockGetReportsUseCase;
  late MockIWatchlistRepository mockWatchlistRepository;
  late MockIAuthRepository mockAuthRepository;
  late MockGetUserActivityUseCase mockGetUserActivityUseCase;
  late MockMarkReportsViewedUseCase mockMarkReportsViewedUseCase;
  late MockIUserRepository mockUserRepository;
  late auth.UserModel tUser;
  late MockReportsTracker mockTracker;
  late MockILocalStorageService mockLocalStorageService;

  setUp(() {
    mockGetReportsUseCase = MockGetDashboardReportsUseCase();
    mockWatchlistRepository = MockIWatchlistRepository();
    mockAuthRepository = MockIAuthRepository();
    mockGetUserActivityUseCase = MockGetUserActivityUseCase();
    mockMarkReportsViewedUseCase = MockMarkReportsViewedUseCase();
    mockUserRepository = MockIUserRepository();
    mockTracker = MockReportsTracker();
    mockLocalStorageService = MockILocalStorageService();

    tUser = const auth.UserModel(id: 'test_uid', email: 'test@example.com');

    when(() => mockAuthRepository.currentUser).thenReturn(tUser);
    when(
      () => mockUserRepository.userStream,
    ).thenAnswer((_) => const Stream<UserModel>.empty());

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

    when(() => mockLocalStorageService.getInt(any())).thenReturn(null);
    when(
      () => mockLocalStorageService.setInt(any(), any()),
    ).thenAnswer((_) async {});

    bloc = ReportsBloc(
      mockGetReportsUseCase,
      mockWatchlistRepository,
      mockAuthRepository,
      mockGetUserActivityUseCase,
      mockMarkReportsViewedUseCase,
      mockUserRepository,
      mockLocalStorageService,
      mockTracker,
    );
  });

  tearDown(() {
    bloc.close();
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
        when(
          () => mockGetUserActivityUseCase(any()),
        ).thenAnswer((_) => Stream.value(const Right(tUserActivity)));
        when(
          () => mockWatchlistRepository.getWatchlistStream(any()),
        ).thenAnswer((_) => Stream.value(const Right([])));
        when(
          () => mockGetReportsUseCase(any()),
        ).thenAnswer((_) => Stream.value(const Right(ReportsFeed())));
        return bloc;
      },
      act: (bloc) => bloc.add(const ReportsEvent.started(uid: 'test_uid')),
      expect: () => [
        const ReportsState.loading(),
        const ReportsState.loaded(
          ReportsFeed(),
          lastViewedReports: null,
          todaysFilings: [],
        ),
      ],
      verify: (_) {
        verify(() => mockGetUserActivityUseCase('test_uid')).called(1);
        verify(
          () => mockWatchlistRepository.getWatchlistStream('test_uid'),
        ).called(1);
        verify(() => mockGetReportsUseCase([])).called(1);
      },
    );
  });

  group('ReportsBloc - ReportsUpdated', () {
    const tReportsFeed = ReportsFeed();

    blocTest<ReportsBloc, ReportsState>(
      'reportsUpdated_success_emitsLoaded',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const ReportsEvent.reportsUpdated(Right(tReportsFeed))),
      expect: () => [
        const ReportsState.loaded(
          tReportsFeed,
          lastViewedReports: null,
          todaysFilings: [],
        ),
      ],
    );

    blocTest<ReportsBloc, ReportsState>(
      'reportsUpdated_failure_emitsFailure',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ReportsEvent.reportsUpdated(Left(Failure.server("Error"))),
      ),
      expect: () => [const ReportsState.failure(Failure.server("Error"))],
      verify: (_) {
        verify(() => mockTracker.logFetchFailed(error: 'Error')).called(1);
      },
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
        when(() => mockLocalStorageService.getInt(any())).thenReturn(5);
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ReportsEvent.viewed(
          unreadCount: 2,
          entrySource: ReportsEntrySource.nav,
        ),
      ),
      verify: (_) {
        verify(
          () => mockTracker.logFeedViewed(
            unreadCount: 2,
            entrySource: ReportsEntrySource.nav,
          ),
        ).called(1);
        verify(() => mockLocalStorageService.setInt(any(), 6)).called(1);
        verify(() => mockTracker.setReportsTotalViewed(6)).called(1);
      },
    );
  });
}
