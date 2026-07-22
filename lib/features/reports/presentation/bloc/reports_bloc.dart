import 'dart:async';
import 'dart:convert';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/domain/models/weekly_report.dart';
import 'package:bizzie/features/reports/presentation/models/filing_view_model.dart';
import 'package:bizzie/features/reports/domain/usecases/get_dashboard_reports_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/get_user_activity_use_case.dart';
import 'package:bizzie/features/reports/domain/usecases/mark_reports_viewed_use_case.dart';
import 'package:bizzie/features/reports/domain/models/mark_reports_viewed_params.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

import 'reports_event.dart';
import 'reports_state.dart';
import 'package:bizzie/features/reports/presentation/analytics/reports_tracker.dart';

final _logger = BizzieLogger('ReportsBloc');

@injectable
class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final GetDashboardReportsUseCase _getReportsUseCase;
  final IWatchlistRepository _watchlistRepository;
  final IAuthRepository _authRepository;
  final GetUserActivityUseCase _getUserActivityUseCase;
  final MarkReportsViewedUseCase _markReportsViewedUseCase;
  final IUserRepository _userRepository;
  final ILocalStorageService _localStorageService;
  final ReportsTracker _tracker;
  StreamSubscription? _userSubscription;

  final Set<String> _pendingSummaryRequests = {};

  DateTime? _lastViewedReports;

  Set<String> _seenWeeklyReportIds = {};
  Set<String> get seenWeeklyReportIds => _seenWeeklyReportIds;

  static const _seenWeeklyStorageKey = 'seen_weekly_report_ids';

  ReportsBloc(
    this._getReportsUseCase,
    this._watchlistRepository,
    this._authRepository,
    this._getUserActivityUseCase,
    this._markReportsViewedUseCase,
    this._userRepository,
    this._localStorageService,
    this._tracker,
  ) : super(const ReportsState.initial()) {
    _seenWeeklyReportIds = _loadSeenWeeklyIds();
    _userSubscription = _userRepository.userStream.listen((_) {
      add(const ReportsEvent.started());
    });

    on<Started>(_onStarted, transformer: restartable());
    on<WatchlistUpdated>(_onWatchlistUpdated, transformer: restartable());
    on<ReportsUpdated>(_onReportsUpdated);
    on<Refresh>(_onRefresh);
    on<Viewed>(_onViewed);
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
    on<ActivityUpdated>(_onActivityUpdated);
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
    _tracker.logMarketNewsOpened(
      publisher: event.publisher,
      site: event.site,
    );
  }

  void _onMarketNewsLoadFailed(
    MarketNewsLoadFailed event,
    Emitter<ReportsState> emit,
  ) {
    _tracker.logMarketNewsFetchFailed(error: event.error);
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  void _onReset(Reset event, Emitter<ReportsState> emit) {
    _logger.info('Resetting ReportsBloc');
    _lastViewedReports = null;
    _seenWeeklyReportIds = {};
    _localStorageService.remove(_seenWeeklyStorageKey);
    emit(const ReportsState.initial());
  }

  Set<String> _loadSeenWeeklyIds() {
    final stored = _localStorageService.getString(_seenWeeklyStorageKey);
    if (stored == null) return {};
    try {
      return (jsonDecode(stored) as List).cast<String>().toSet();
    } catch (e) {
      _logger.warning('Failed to decode stored seen weekly IDs, resetting', e);
      return {};
    }
  }

  Future<void> _saveSeenWeeklyIds() async {
    await _localStorageService.setString(
      _seenWeeklyStorageKey,
      jsonEncode(_seenWeeklyReportIds.toList()),
    );
  }

  String? get _uid => _authRepository.currentUser?.id;

  Future<void> _onStarted(Started event, Emitter<ReportsState> emit) async {
    final uid = event.uid ?? _uid;
    if (uid == null) {
      _logger.warning('Started event without UID and repository UID is null');
      emit(ReportsState.failure(Failure.server("User not authenticated")));
      return;
    }

    _logger.info('Starting ReportsBloc for UID: $uid');
    emit(const ReportsState.loading());

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
      _getUserActivityUseCase(uid),
      onData: (result) {
        result.fold(
          (failure) => _logger.warning(
            'Failed to receive user activity: ${failure.errorMessage}',
          ),
          (activity) {
            _logger.info(
              'Activity stream emitted: ${activity.lastViewedReports}',
            );
            add(ReportsEvent.activityUpdated(activity.lastViewedReports));
          },
        );
      },
      onError: (e, s) {
        _logger.severe('Failed to listen to user activity stream', e, s);
      },
    );
  }

  Future<void> _subscribeToWatchlistStream(
    String uid,
    Emitter<ReportsState> emit,
  ) {
    return emit.onEach(
      _watchlistRepository.getWatchlistStream(uid),
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
    if (state is! Loaded) {
      emit(const ReportsState.loading());
    }

    final stream = _getReportsUseCase(event.tickers);

    await emit.onEach(
      stream,
      onData: (result) => add(ReportsEvent.reportsUpdated(result)),
    );
  }

  void _onReportsUpdated(ReportsUpdated event, Emitter<ReportsState> emit) {
    event.result.fold(
      (failure) {
        _tracker.logFetchFailed(error: failure.errorMessage);
        emit(ReportsState.failure(failure));
      },
      (feed) {
        final currentLastViewed =
            _lastViewedReports ??
            state.mapOrNull(loaded: (s) => s.lastViewedReports);

        emit(
          ReportsState.loaded(
            feed,
            lastViewedReports: currentLastViewed,
            todaysFilings: _buildTodaysFilings(feed),
            todaysWeeklyReports: _buildTodaysWeeklyReports(feed),
          ),
        );
      },
    );
  }

  List<FilingViewModel> _buildTodaysFilings(ReportsFeed feed) {
    final now = DateTime.now();
    final reportsByKey = <(String, String), FinancialReport>{};
    for (final report in feed.currentReports) {
      reportsByKey.putIfAbsent(
        (report.ticker, report.formType),
        () => report,
      );
    }

    return feed.filings
        .where((f) {
          return f.createdAt != null &&
              f.createdAt!.year == now.year &&
              f.createdAt!.month == now.month &&
              f.createdAt!.day == now.day;
        })
        .map((filing) {
          final report = reportsByKey[(filing.symbol, filing.formType)];
          return FilingViewModel(filing: filing, report: report);
        })
        .toList();
  }

  List<WeeklyReport> _buildTodaysWeeklyReports(ReportsFeed feed) {
    final now = DateTime.now();
    return feed.weeklyReports.where((r) {
      final reportDate = DateTime.tryParse(r.id ?? '');
      return reportDate != null &&
          reportDate.year == now.year &&
          reportDate.month == now.month &&
          reportDate.day == now.day;
    }).toList();
  }

  void _onRefresh(Refresh event, Emitter<ReportsState> emit) {
    add(const ReportsEvent.started());
  }

  void _onActivityUpdated(ActivityUpdated event, Emitter<ReportsState> emit) {
    _lastViewedReports = event.lastViewedReports;
    _logger.info("ActivityUpdated: New LastViewed=$_lastViewedReports");

    state.mapOrNull(
      loaded: (s) {
        emit(s.copyWith(lastViewedReports: _lastViewedReports));
      },
    );
  }

  Future<void> _onViewed(Viewed event, Emitter<ReportsState> emit) async {
    _tracker.logFeedViewed(
      unreadCount: event.unreadCount,
      entrySource: event.entrySource,
      notificationType: event.notificationType,
    );

    const storageKey = 'report_feed_total_views';
    final currentCount = _localStorageService.getInt(storageKey) ?? 0;
    final newCount = currentCount + 1;
    await _localStorageService.setInt(storageKey, newCount);
    _tracker.setReportsTotalViewed(newCount);

    final uid = _uid;
    if (uid == null) return;

    final currentState = state;
    if (currentState is! Loaded) return;

    final hasNewWeekly = await _markWeeklyReportsSeen(currentState);
    await _markFilingsViewed(uid, currentState, hasNewWeekly, emit);
  }

  Future<bool> _markWeeklyReportsSeen(Loaded currentState) async {
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
    Loaded currentState,
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
      emit(currentState.copyWith(lastViewedReports: now));

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
