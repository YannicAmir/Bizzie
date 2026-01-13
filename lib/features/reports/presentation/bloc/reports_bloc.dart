import 'dart:async';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';

import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/presentation/models/filing_view_model.dart';
import 'package:bizzie/features/reports/domain/usecases/get_dashboard_reports_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/get_user_activity_use_case.dart';
import 'package:bizzie/features/reports/domain/usecases/mark_reports_viewed_use_case.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'reports_event.dart';
import 'reports_state.dart';

final _logger = BizzieLogger('ReportsBloc');

@injectable
class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final GetDashboardReportsUseCase _getReportsUseCase;
  final IWatchlistRepository _watchlistRepository;
  final IAuthRepository _authRepository;
  final GetUserActivityUseCase _getUserActivityUseCase;
  final MarkReportsViewedUseCase _markReportsViewedUseCase;

  StreamSubscription? _watchlistSubscription;
  StreamSubscription? _reportsSubscription;
  StreamSubscription? _activitySubscription;
  DateTime? _lastViewedReports;

  ReportsBloc(
    this._getReportsUseCase,
    this._watchlistRepository,
    this._authRepository,
    this._getUserActivityUseCase,
    this._markReportsViewedUseCase,
  ) : super(const ReportsState.initial()) {
    on<Started>(_onStarted);
    on<WatchlistUpdated>(_onWatchlistUpdated);
    on<ReportsUpdated>(_onReportsUpdated);
    on<Refresh>(_onRefresh);
    on<Viewed>(_onViewed);
    on<ActivityUpdated>(_onActivityUpdated);
  }

  String? get _uid => _authRepository.currentUser?.id;

  @override
  Future<void> close() {
    _watchlistSubscription?.cancel();
    _reportsSubscription?.cancel();
    _activitySubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(Started event, Emitter<ReportsState> emit) async {
    final uid = _uid;
    if (uid == null) {
      emit(const ReportsState.failure("User not authenticated"));
      return;
    }

    emit(const ReportsState.loading());

    _activitySubscription?.cancel();
    _activitySubscription = _getUserActivityUseCase(uid).listen(
      (result) {
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

    _watchlistSubscription?.cancel();
    _watchlistSubscription = _watchlistRepository
        .getWatchlistStream(uid)
        .listen((result) {
          result.fold(
            (failure) => _logger.warning(
              'Failed to fetch watchlist: ${failure.message}',
            ),
            (companies) {
              final tickers = companies.map((c) => c.ticker).toList();
              add(ReportsEvent.watchlistUpdated(tickers));
            },
          );
        });
  }

  Future<void> _onWatchlistUpdated(
    WatchlistUpdated event,
    Emitter<ReportsState> emit,
  ) async {
    if (state is! Loaded) {
      emit(const ReportsState.loading());
    }

    _reportsSubscription?.cancel();
    _reportsSubscription = _getReportsUseCase(
      event.tickers,
    ).listen((result) => add(ReportsEvent.reportsUpdated(result)));
  }

  Future<void> _onReportsUpdated(
    ReportsUpdated event,
    Emitter<ReportsState> emit,
  ) async {
    event.result.fold(
      (failure) => emit(ReportsState.failure(failure.message)),
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
