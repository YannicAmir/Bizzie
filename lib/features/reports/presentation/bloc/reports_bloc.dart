import 'dart:async';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
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
    on<FilingCardCompanyClicked>(_onFilingCardCompanyClicked);
    on<EmptyCtaClicked>(_onEmptyCtaClicked);
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

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  void _onReset(Reset event, Emitter<ReportsState> emit) {
    _logger.info('Resetting ReportsBloc');
    _lastViewedReports = null;
    emit(const ReportsState.initial());
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

    final activityStream = _getUserActivityUseCase(uid);
    final watchlistStream = _watchlistRepository.getWatchlistStream(uid);

    final activityFuture = emit.onEach(
      activityStream,
      onData: (result) {
        result.fold(
          (failure) => _logger.warning(
            'Failed to receive user activity: ${failure.message}',
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

    final watchlistFuture = emit.onEach(
      watchlistStream,
      onData: (result) {
        result.fold(
          (failure) =>
              _logger.warning('Failed to fetch watchlist: ${failure.message}'),
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

    await Future.wait([activityFuture, watchlistFuture]);
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

  Future<void> _onReportsUpdated(
    ReportsUpdated event,
    Emitter<ReportsState> emit,
  ) async {
    event.result.fold(
      (failure) {
        _tracker.logFetchFailed(error: failure.message);
        emit(ReportsState.failure(failure));
      },
      (feed) {
        final currentLastViewed =
            _lastViewedReports ??
            state.mapOrNull(loaded: (s) => s.lastViewedReports);

        final now = DateTime.now();
        final todaysFilings = feed.filings
            .where((f) {
              return f.createdAt != null &&
                  f.createdAt!.year == now.year &&
                  f.createdAt!.month == now.month &&
                  f.createdAt!.day == now.day;
            })
            .map((filing) {
              final report = feed.currentReports
                  .cast<FinancialReport?>()
                  .firstWhere(
                    (r) =>
                        r?.ticker == filing.symbol &&
                        r?.formType == filing.formType,
                    orElse: () => null,
                  );
              return FilingViewModel(filing: filing, report: report);
            })
            .toList();

        emit(
          ReportsState.loaded(
            feed,
            lastViewedReports: currentLastViewed,
            todaysFilings: todaysFilings,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(Refresh event, Emitter<ReportsState> emit) async {
    add(const ReportsEvent.started());
  }

  Future<void> _onActivityUpdated(
    ActivityUpdated event,
    Emitter<ReportsState> emit,
  ) async {
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

    final newestTime = _calculateNewestFilingDate(currentState.feed);
    if (newestTime == null) return;

    final lastViewed = currentState.lastViewedReports;

    if (lastViewed == null || newestTime.isAfter(lastViewed)) {
      final now = DateTime.now();

      _lastViewedReports = now;
      emit(currentState.copyWith(lastViewedReports: now));

      try {
        await _markReportsViewedUseCase(
          MarkReportsViewedParams(uid: uid, timestamp: now),
        );
      } catch (e) {
        _logger.severe("Failed to mark reports viewed: $e");
      }
    }
  }

  DateTime? _calculateNewestFilingDate(ReportsFeed feed) {
    if (feed.filings.isEmpty) return null;

    final validFilings = feed.filings
        .where((f) => f.createdAt != null)
        .toList();

    if (validFilings.isEmpty) return null;

    final newestFiling = validFilings.reduce((a, b) {
      return a.createdAt!.isAfter(b.createdAt!) ? a : b;
    });

    return newestFiling.createdAt;
  }
}
