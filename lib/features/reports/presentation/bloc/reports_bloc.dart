import 'dart:async';
import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
import 'package:bizzie/core/interfaces/i_lifecycle_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/core/domain/models/weekly_report.dart';
import 'package:bizzie/shared/models/filing_view_model.dart';
import 'package:bizzie/features/reports/domain/usecases/get_dashboard_reports_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/get_seen_weekly_report_ids_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/get_user_activity_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/increment_reports_feed_view_count_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/mark_reports_viewed_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/save_seen_weekly_report_ids_usecase.dart';
import 'package:bizzie/features/reports/domain/models/mark_reports_viewed_params.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'reports_event.dart';
import 'reports_state.dart';
import 'package:bizzie/features/reports/presentation/analytics/reports_tracker.dart';
import 'package:bizzie/features/reports/presentation/extensions/reports_state_extensions.dart';

final _logger = BizzieLogger('ReportsBloc');

@injectable
class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final GetDashboardReportsUseCase _getReportsUseCase;
  final GetWatchlistUseCase _getWatchlistUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final GetUserActivityUseCase _getUserActivityUseCase;
  final MarkReportsViewedUseCase _markReportsViewedUseCase;
  final GetSeenWeeklyReportIdsUseCase _getSeenWeeklyReportIdsUseCase;
  final SaveSeenWeeklyReportIdsUseCase _saveSeenWeeklyReportIdsUseCase;
  final IncrementReportsFeedViewCountUseCase _incrementFeedViewCountUseCase;
  final ReportsTracker _tracker;
  final ITimeProvider _timeProvider;
  final ILifecycleService _lifecycleService;

  StreamSubscription<BizzieLifecycleState>? _lifecycleSubscription;

  Timer? _dayCheckTimer;

  final _sessionEnded = StreamController<void>.broadcast(sync: true);

  final Set<String> _pendingSummaryRequests = {};

  DateTime? _lastViewedReports;

  Set<String> _seenWeeklyReportIds = {};

  ReportsBloc(
    this._getReportsUseCase,
    this._getWatchlistUseCase,
    this._getCurrentUserUseCase,
    this._getUserActivityUseCase,
    this._markReportsViewedUseCase,
    this._getSeenWeeklyReportIdsUseCase,
    this._saveSeenWeeklyReportIdsUseCase,
    this._incrementFeedViewCountUseCase,
    this._tracker,
    this._timeProvider,
    this._lifecycleService,
  ) : super(const ReportsState.initial()) {
    _seenWeeklyReportIds = _loadSeenWeeklyIds();

    _lifecycleSubscription = _lifecycleService.onLifecycleChanged
        .where((state) => state == BizzieLifecycleState.foreground)
        .listen((_) {
          if (!isClosed) add(const ReportsEvent.dayCheckRequested());
        });

    on<Started>(_onStarted, transformer: restartable());
    on<WatchlistUpdated>(_onWatchlistUpdated, transformer: restartable());
    on<Refresh>(_onRefresh);
    on<Viewed>(_onViewed, transformer: sequential());
    on<LinkOpened>(_onLinkOpened);
    on<SummaryRequested>(_onSummaryRequested);
    on<SummarizeLockedClicked>(_onSummarizeLockedClicked);
    on<UpcomingExpanded>(_onUpcomingExpanded);
    on<UpcomingCompanyClicked>(_onUpcomingCompanyClicked);
    on<YtdCompanyClicked>(_onYtdCompanyClicked);
    on<FilingCardCompanyClicked>(_onFilingCardCompanyClicked);
    on<EmptyCtaClicked>(_onEmptyCtaClicked);
    on<MarketNewsArticleOpened>(_onMarketNewsArticleOpened);
    on<MarketNewsLoadFailed>(_onMarketNewsLoadFailed);
    on<DayCheckRequested>(_onDayCheckRequested);
    on<Reset>(_onReset);
  }

  void _onLinkOpened(LinkOpened event, Emitter<ReportsState> emit) {
    _tracker.logLinkOpened(ticker: event.ticker, filingType: event.filingType);
    _tracker.setLastFilingTicker(event.ticker);
  }

  void _onSummaryRequested(SummaryRequested event, Emitter<ReportsState> emit) {
    if (event.isReady) {
      _tracker.logSummaryViewed(
        ticker: event.ticker,
        filingType: event.filingType,
        wasPreviouslyPending: _pendingSummaryRequests.contains(event.ticker),
      );
    } else {
      _tracker.logAnalysisPendingViewed(
        ticker: event.ticker,
        filingType: event.filingType,
      );
      _pendingSummaryRequests.add(event.ticker);
    }
    _tracker.setLastFilingTicker(event.ticker);
  }

  void _onSummarizeLockedClicked(
    SummarizeLockedClicked event,
    Emitter<ReportsState> emit,
  ) {
    _tracker.logSummarizeLockedClicked(
      ticker: event.ticker,
      filingType: event.filingType,
    );
    _tracker.setLastFilingTicker(event.ticker);
  }

  void _onUpcomingExpanded(UpcomingExpanded event, Emitter<ReportsState> emit) {
    _tracker.logUpcomingExpanded();
  }

  void _onUpcomingCompanyClicked(
    UpcomingCompanyClicked event,
    Emitter<ReportsState> emit,
  ) {
    _tracker.logUpcomingCompanyClicked(ticker: event.ticker);
    _tracker.setLastFilingTicker(event.ticker);
  }

  void _onYtdCompanyClicked(
    YtdCompanyClicked event,
    Emitter<ReportsState> emit,
  ) {
    _tracker.logYtdCompanyClicked(ticker: event.ticker);
    _tracker.setLastFilingTicker(event.ticker);
  }

  void _onFilingCardCompanyClicked(
    FilingCardCompanyClicked event,
    Emitter<ReportsState> emit,
  ) {
    _tracker.logFilingCardCompanyClicked(ticker: event.ticker);
    _tracker.setLastFilingTicker(event.ticker);
  }

  void _onEmptyCtaClicked(EmptyCtaClicked event, Emitter<ReportsState> emit) {
    _tracker.logEmptyCtaClicked();
  }

  void _onMarketNewsArticleOpened(
    MarketNewsArticleOpened event,
    Emitter<ReportsState> emit,
  ) {
    _tracker.logMarketNewsOpened(publisher: event.publisher, site: event.site);
  }

  void _onMarketNewsLoadFailed(
    MarketNewsLoadFailed event,
    Emitter<ReportsState> emit,
  ) {
    _tracker.logMarketNewsFetchFailed(error: event.error);
  }

  @override
  Future<void> close() async {
    _dayCheckTimer?.cancel();
    await _lifecycleSubscription?.cancel();
    await _sessionEnded.close();
    return super.close();
  }

  Future<void> _onReset(Reset event, Emitter<ReportsState> emit) async {
    _logger.info('Resetting ReportsBloc');
    _sessionEnded.add(null);
    _dayCheckTimer?.cancel();
    _lastViewedReports = null;
    _seenWeeklyReportIds = {};
    _pendingSummaryRequests.clear();
    emit(const ReportsState.initial());
    await _saveSeenWeeklyIds();
  }

  Set<String> _loadSeenWeeklyIds() {
    return _getSeenWeeklyReportIdsUseCase().fold((failure) {
      _logger.warning(
        'Failed to load seen weekly IDs, resetting: ${failure.errorMessage}',
      );
      return <String>{};
    }, (ids) => ids);
  }

  Future<void> _saveSeenWeeklyIds() async {
    final result = await _saveSeenWeeklyReportIdsUseCase(_seenWeeklyReportIds);
    result.fold(
      (failure) => _logger.warning(
        'Failed to save seen weekly IDs: ${failure.errorMessage}',
      ),
      (_) {},
    );
  }

  String? get _uid => _getCurrentUserUseCase()?.id;

  Stream<T> _untilSessionEnds<T>(Stream<T> stream) =>
      stream.takeUntil(_sessionEnded.stream);

  Future<void> _onStarted(Started event, Emitter<ReportsState> emit) async {
    final uid = event.uid ?? _uid;
    if (uid == null) {
      _logger.warning('Started event without UID and repository UID is null');
      emit(ReportsState.failure(Failure.server("User not authenticated")));
      return;
    }

    _logger.info('Starting ReportsBloc for UID: $uid');
    emit(const ReportsState.loading());
    _scheduleDayCheck();

    await Future.wait([
      _subscribeToActivityStream(uid, emit),
      _subscribeToWatchlistStream(uid, emit),
    ]);
  }

  Future<void> _subscribeToActivityStream(
    String uid,
    Emitter<ReportsState> emit,
  ) {
    return emit.onEach(
      _untilSessionEnds(_getUserActivityUseCase(uid)),
      onData: (result) {
        result.fold(
          (failure) => _logger.warning(
            'Failed to receive user activity: ${failure.errorMessage}',
          ),
          (activity) => _applyLastViewed(activity.lastViewedReports, emit),
        );
      },
      onError: (e, s) {
        _logger.severe('Failed to listen to user activity stream', e, s);
      },
    );
  }

  void _applyLastViewed(
    DateTime? lastViewedReports,
    Emitter<ReportsState> emit,
  ) {
    _lastViewedReports = lastViewedReports;
    _logger.info('Activity stream emitted: $_lastViewedReports');

    state.mapOrNull(
      loaded: (s) {
        emit(s.copyWith(lastViewedReports: _lastViewedReports));
      },
    );
  }

  Future<void> _subscribeToWatchlistStream(
    String uid,
    Emitter<ReportsState> emit,
  ) {
    final watchlist = Stream.fromFuture(
      _getWatchlistUseCase(uid),
    ).asyncExpand((stream) => stream);

    return emit.onEach(
      _untilSessionEnds(watchlist),
      onData: (result) {
        result.fold(
          (failure) => _logger.warning(
            'Failed to fetch watchlist: ${failure.errorMessage}',
          ),
          (companies) {
            final tickers = companies.map((c) => c.ticker).toList();
            add(ReportsEvent.watchlistUpdated(tickers));
          },
        );
      },
      onError: (e, s) {
        _logger.severe('Failed to listen to watchlist stream', e, s);
      },
    );
  }

  Future<void> _onWatchlistUpdated(
    WatchlistUpdated event,
    Emitter<ReportsState> emit,
  ) async {
    if (state is! ReportsLoaded) {
      emit(const ReportsState.loading());
    }

    await emit.onEach(
      _untilSessionEnds(_getReportsUseCase(event.tickers)),
      onData: (result) => _applyReportsResult(result, emit),
    );
  }

  void _applyReportsResult(
    Either<Failure, ReportsFeed> result,
    Emitter<ReportsState> emit,
  ) {
    result.fold(
      (failure) {
        _tracker.logFetchFailed(error: failure.errorMessage);
        if (state is! ReportsLoaded) emit(ReportsState.failure(failure));
      },
      (feed) {
        final currentLastViewed =
            _lastViewedReports ??
            state.mapOrNull(loaded: (s) => s.lastViewedReports);

        emit(_buildLoadedState(feed, lastViewedReports: currentLastViewed));
      },
    );
  }

  ReportsState _buildLoadedState(
    ReportsFeed feed, {
    required DateTime? lastViewedReports,
  }) {
    final today = _today;
    return ReportsState.loaded(
      feed,
      today: today,
      lastViewedReports: lastViewedReports,
      seenWeeklyReportIds: _seenWeeklyReportIds,
      recentFilings: _buildRecentFilings(feed, today),
      recentWeeklyReports: _buildRecentWeeklyReports(feed, today),
      todaysWeeklyReports: _buildTodaysWeeklyReports(feed, today),
    );
  }

  DateTime get _today {
    final now = _timeProvider.nowLocal;
    return DateTime(now.year, now.month, now.day);
  }

  DateTime _recentWindowStart(DateTime today) =>
      DateTime(today.year - 1, today.month, today.day);

  void _scheduleDayCheck() {
    _dayCheckTimer?.cancel();
    final now = _timeProvider.nowLocal;
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    _dayCheckTimer = Timer(nextMidnight.difference(now), () {
      if (!isClosed) add(const ReportsEvent.dayCheckRequested());
    });
  }

  void _onDayCheckRequested(
    DayCheckRequested event,
    Emitter<ReportsState> emit,
  ) {
    if (state is ReportsInitial) return;
    _scheduleDayCheck();

    final currentState = state;
    if (currentState is! ReportsLoaded || currentState.today == _today) return;

    _logger.info('Calendar day changed, recomputing reports for $_today');
    emit(
      _buildLoadedState(
        currentState.feed,
        lastViewedReports: currentState.lastViewedReports,
      ),
    );
  }

  List<FilingViewModel> _buildRecentFilings(ReportsFeed feed, DateTime today) {
    final since = _recentWindowStart(today);
    final reportsByTicker = groupBy([
      ...feed.currentReports,
      ...feed.pastReports,
    ], (FinancialReport report) => report.ticker);

    return feed.filings
        .where((f) => f.createdAt != null && !f.createdAt!.isBefore(since))
        .map((filing) {
          final report = reportsByTicker[filing.symbol]?.firstWhereOrNull(
            filing.isFiledAs,
          );
          return FilingViewModel(filing: filing, report: report);
        })
        .toList();
  }

  List<WeeklyReport> _buildRecentWeeklyReports(
    ReportsFeed feed,
    DateTime today,
  ) {
    final since = _recentWindowStart(today);
    return feed.weeklyReports.where((r) {
      final reportDate = r.reportDate;
      return reportDate != null && !reportDate.isBefore(since);
    }).toList();
  }

  List<WeeklyReport> _buildTodaysWeeklyReports(
    ReportsFeed feed,
    DateTime today,
  ) {
    return feed.weeklyReports.where((r) {
      final reportDate = DateTime.tryParse(r.id ?? '');
      return reportDate != null &&
          reportDate.year == today.year &&
          reportDate.month == today.month &&
          reportDate.day == today.day;
    }).toList();
  }

  void _onRefresh(Refresh event, Emitter<ReportsState> emit) {
    add(const ReportsEvent.started());
  }

  Future<void> _onViewed(Viewed event, Emitter<ReportsState> emit) async {
    if (state is! ReportsLoaded) return;
    final unreadCount = state.unreadCount;
    if (event.onlyIfUnread && unreadCount == 0) return;

    await _recordFeedView(event, unreadCount: unreadCount);

    final uid = _uid;
    if (uid == null) return;

    final currentState = state;
    if (currentState is! ReportsLoaded) return;

    final hasNewWeekly = await _markWeeklyReportsSeen(currentState);
    await _markFilingsViewed(uid, currentState, hasNewWeekly, emit);
  }

  Future<void> _recordFeedView(
    Viewed event, {
    required int unreadCount,
  }) async {
    _tracker.logFeedViewed(
      unreadCount: unreadCount,
      entrySource: event.entrySource,
      notificationType: event.notificationType,
    );

    final result = await _incrementFeedViewCountUseCase();
    result.fold(
      (failure) => _logger.warning(
        'Failed to increment reports feed view count: ${failure.errorMessage}',
      ),
      (count) {
        _tracker.setReportsTotalViewed(count);
      },
    );
  }

  Future<bool> _markWeeklyReportsSeen(ReportsLoaded currentState) async {
    final newlySeen = currentState.todaysWeeklyReports
        .map((r) => r.seenKey)
        .toSet();
    final hasNewWeekly = !newlySeen.every(_seenWeeklyReportIds.contains);
    if (hasNewWeekly) {
      _seenWeeklyReportIds = {..._seenWeeklyReportIds, ...newlySeen};
      await _saveSeenWeeklyIds();
    }
    return hasNewWeekly;
  }

  Future<void> _markFilingsViewed(
    String uid,
    ReportsLoaded currentState,
    bool hasNewWeekly,
    Emitter<ReportsState> emit,
  ) async {
    final newestTime = _calculateNewestFilingDate(currentState.feed);
    final lastViewed = currentState.lastViewedReports;
    final hasNewFilings =
        newestTime != null &&
        (lastViewed == null || newestTime.isAfter(lastViewed));

    if (hasNewFilings || hasNewWeekly) {
      final now = DateTime.now();
      _lastViewedReports = now;
      state.mapOrNull(
        loaded: (s) => emit(
          s.copyWith(
            lastViewedReports: now,
            seenWeeklyReportIds: _seenWeeklyReportIds,
          ),
        ),
      );

      if (hasNewFilings) {
        final result = await _markReportsViewedUseCase(
          MarkReportsViewedParams(uid: uid, timestamp: now),
        );
        result.fold(
          (failure) => _logger.severe(
            'Failed to mark reports viewed: ${failure.errorMessage}',
          ),
          (_) {},
        );
      }
    }
  }

  DateTime? _calculateNewestFilingDate(ReportsFeed feed) {
    final dates = <DateTime>[];

    for (final f in feed.filings) {
      if (f.createdAt != null) dates.add(f.createdAt!);
    }
    for (final r in feed.weeklyReports) {
      if (r.createdAt != null) dates.add(r.createdAt!);
    }

    if (dates.isEmpty) return null;
    return dates.reduce((a, b) => a.isAfter(b) ? a : b);
  }
}
