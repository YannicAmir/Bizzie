import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_geographic_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_product_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/segments/domain/usecases/get_revenue_geographic_segments_usecase.dart';
import 'package:bizzie/features/company_profile/segments/domain/usecases/get_revenue_product_segments_usecase.dart';
import 'package:bizzie/features/company_profile/segments/presentation/analytics/segments_tab_analytics.dart';
import 'package:bizzie/features/company_profile/segments/presentation/analytics/segments_tab_view_state.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_event.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_state.dart';
import 'package:bizzie/features/company_profile/segments/presentation/utils/segment_period_key.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_load_guard_mixin.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanySegmentsBloc');

@injectable
class CompanySegmentsBloc
    extends Bloc<CompanySegmentsEvent, CompanySegmentsState>
    with
        CompanyProfileAnalyticsMixin<
          CompanySegmentsEvent,
          CompanySegmentsState,
          SegmentsTabViewState
        >,
        AuthSessionResetMixin<CompanySegmentsEvent, CompanySegmentsState>,
        CompanyProfileLoadGuardMixin {
  static const _refreshIntervalMinutes = 60;

  final GetRevenueProductSegmentsUseCase _getProductSegmentsUseCase;
  final GetRevenueGeographicSegmentsUseCase _getGeographicSegmentsUseCase;
  final IConfigService _configService;
  final SegmentsTabAnalytics _analytics;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final ITimeProvider _timeProvider;

  StreamSubscription<TabActivation>? _tabSubscription;

  CompanySegmentsBloc(
    this._getProductSegmentsUseCase,
    this._getGeographicSegmentsUseCase,
    this._configService,
    this._analytics,
    this._watchActiveTabUseCase,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanySegmentsState.initial()) {
    on<CompanySegmentsEvent>(_onEvent);
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) async => await onTabHidden());
    on<AppBackgrounded>((_, __) async => await onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<PeriodChanged>(_onPeriodChanged);
    on<PeriodKeySelected>(_onPeriodKeySelected);
    on<Reset>((_, emit) => emit(const CompanySegmentsState.initial()));
    resetOnSessionEnd(getAuthStream, const CompanySegmentsEvent.reset());
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.segments)
        .listen((activation) {
          final shouldHandle = state.maybeMap(
            loading: (_) => false,
            loaded: (s) => s.ticker == activation.ticker,
            orElse: () => true,
          );
          if (shouldHandle) {
            add(
              CompanySegmentsEvent.stalenessCheckRequested(activation.ticker),
            );
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  @override
  CompanyProfileTabTracker<SegmentsTabViewState> get analyticsTracker =>
      _analytics;

  @override
  String get featureName => 'Company Segments';

  @override
  String? get loadedTicker => state.mapOrNull(loaded: (s) => s.ticker);

  void _onEvent(
    CompanySegmentsEvent event,
    Emitter<CompanySegmentsState> emit,
  ) {
    _logger.info('Event: $event');
  }

  void _onTabShown(TabShown event, Emitter<CompanySegmentsState> emit) {
    onTabShown(event.ticker, _buildTabShownViewState(event.ticker));
    state.mapOrNull(loaded: _markVisiblePeriodViewed);
    add(CompanySegmentsEvent.stalenessCheckRequested(event.ticker));
  }

  SegmentsTabViewState _buildTabShownViewState(String ticker) {
    final existingState = state.maybeMap(
      loaded: (s) => s.analyticsState,
      orElse: () => null,
    );
    return SegmentsTabViewState(
      ticker: ticker,
      timestamp: _timeProvider.nowLocal.toIso8601String(),
      loadTimeMs: existingState?.loadTimeMs,
      isSuccess: existingState?.isSuccess ?? false,
      dataSource: existingState?.dataSource,
    );
  }

  void _onPeriodChanged(
    PeriodChanged event,
    Emitter<CompanySegmentsState> emit,
  ) {
    state.mapOrNull(
      loaded: (s) => emit(s.copyWith(isAnnualView: event.isAnnual)),
    );
    _markPeriodViewed(isAnnual: event.isAnnual);
  }

  void _markPeriodViewed({required bool isAnnual}) {
    updateAnalyticsState(
      (s) => isAnnual
          ? s.copyWith(viewedYearlySegTab: true)
          : s.copyWith(viewedQtrlySegTab: true),
    );
  }

  void _markVisiblePeriodViewed(CompanySegmentsLoaded loadedState) {
    final hasData = loadedState.isAnnualView
        ? loadedState.annualPeriodKeys.isNotEmpty
        : loadedState.quarterlyPeriodKeys.isNotEmpty;
    if (hasData) {
      _markPeriodViewed(isAnnual: loadedState.isAnnualView);
    }
  }

  void _onPeriodKeySelected(
    PeriodKeySelected event,
    Emitter<CompanySegmentsState> emit,
  ) {
    state.mapOrNull(
      loaded: (s) => emit(
        event.isAnnual
            ? s.copyWith(selectedAnnualKey: event.key)
            : s.copyWith(selectedQuarterlyKey: event.key),
      ),
    );
    updateAnalyticsState(
      (s) => event.isAnnual
          ? s.copyWith(changedYrDate: true)
          : s.copyWith(changedQtrDate: true),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanySegmentsState> emit,
  ) async {
    if (shouldSkipLoad(event.ticker, forceRefresh: event.forceRefresh)) {
      return;
    }

    _logger.info(
      'Loading Segments for ${event.ticker} (force=${event.forceRefresh})',
    );
    final previousView = _previousViewSelection();
    emit(const CompanySegmentsState.loading());

    final stopwatch = Stopwatch()..start();
    final (productResult, geographicResult) = await (
      _getProductSegmentsUseCase(event.ticker),
      _getGeographicSegmentsUseCase(event.ticker),
    ).wait;
    stopwatch.stop();

    final failure = _combinedFailure(productResult, geographicResult);
    if (failure != null) {
      _logger.severe('Failed to load Segments', failure);
      _recordLoadMetrics(
        ticker: event.ticker,
        isSuccess: false,
        loadTimeMs: stopwatch.elapsedMilliseconds,
      );
      emit(CompanySegmentsState.failure(failure));
      return;
    }

    _emitLoadedState(
      ticker: event.ticker,
      productResult: productResult,
      geographicResult: geographicResult,
      loadTimeMs: stopwatch.elapsedMilliseconds,
      previousView: previousView,
      emit: emit,
    );
  }

  ({bool isAnnualView, String? annualKey, String? quarterlyKey})
  _previousViewSelection() =>
      state.mapOrNull(
        loaded: (s) => (
          isAnnualView: s.isAnnualView,
          annualKey: s.selectedAnnualKey,
          quarterlyKey: s.selectedQuarterlyKey,
        ),
      ) ??
      (isAnnualView: true, annualKey: null, quarterlyKey: null);

  String? _resolveSelectedKey(String? previousKey, List<String> keys) =>
      previousKey != null && keys.contains(previousKey)
      ? previousKey
      : keys.firstOrNull;

  Failure? _combinedFailure(
    Either<Failure, (RevenueProductSegments, CompanyProfileDataOrigin)>
    productResult,
    Either<Failure, (RevenueGeographicSegments, CompanyProfileDataOrigin)>
    geographicResult,
  ) {
    if (productResult.isRight() || geographicResult.isRight()) return null;
    return productResult.fold((f) => f, (_) => null);
  }

  SegmentsTabViewState _recordLoadMetrics({
    required String ticker,
    required bool isSuccess,
    required int loadTimeMs,
    CompanyProfileDataOrigin? dataSource,
  }) {
    final session =
        analyticsSession ??
        SegmentsTabViewState(
          ticker: ticker,
          timestamp: _timeProvider.nowLocal.toIso8601String(),
        );
    final metrics = session.copyWith(
      isSuccess: isSuccess,
      dataSource: dataSource,
      loadTimeMs: loadTimeMs,
    );

    if (analyticsSession != null) {
      updateAnalyticsState((s) => metrics);
    }
    return metrics;
  }

  void _emitLoadedState({
    required String ticker,
    required Either<Failure, (RevenueProductSegments, CompanyProfileDataOrigin)>
    productResult,
    required Either<
      Failure,
      (RevenueGeographicSegments, CompanyProfileDataOrigin)
    >
    geographicResult,
    required int loadTimeMs,
    required ({bool isAnnualView, String? annualKey, String? quarterlyKey})
    previousView,
    required Emitter<CompanySegmentsState> emit,
  }) {
    final (product, productOrigin) = productResult.fold(
      (f) => (
        RevenueProductSegments(
          symbol: ticker,
          reportedCurrency: '',
          annual: const [],
          quarterly: const [],
        ),
        null,
      ),
      (tuple) => (tuple.$1, tuple.$2),
    );
    final (geographic, geographicOrigin) = geographicResult.fold(
      (f) => (
        RevenueGeographicSegments(
          symbol: ticker,
          reportedCurrency: '',
          annual: const [],
          quarterly: const [],
        ),
        null,
      ),
      (tuple) => (tuple.$1, tuple.$2),
    );

    final origin = _resolveOrigin([productOrigin, geographicOrigin]);
    _logger.info('Successfully loaded Segments (origin: $origin)');

    final metrics = _recordLoadMetrics(
      ticker: ticker,
      isSuccess: true,
      dataSource: origin,
      loadTimeMs: loadTimeMs,
    );

    final annualKeys = _periodKeys([
      ...product.annual,
      ...geographic.annual,
    ], isAnnual: true);
    final quarterlyKeys = _periodKeys([
      ...product.quarterly,
      ...geographic.quarterly,
    ], isAnnual: false);

    emit(
      CompanySegmentsState.loaded(
        ticker: ticker,
        productSegments: product,
        geographicSegments: geographic,
        annualPeriodKeys: annualKeys,
        quarterlyPeriodKeys: quarterlyKeys,
        isAnnualView: previousView.isAnnualView,
        selectedAnnualKey: _resolveSelectedKey(
          previousView.annualKey,
          annualKeys,
        ),
        selectedQuarterlyKey: _resolveSelectedKey(
          previousView.quarterlyKey,
          quarterlyKeys,
        ),
        productColorIndices: _assignColorIndices([
          ...product.annual,
          ...product.quarterly,
        ]),
        geographicColorIndices: _assignColorIndices([
          ...geographic.annual,
          ...geographic.quarterly,
        ]),
        historyLimit: _configService.freePlanHistoryCount,
        dataOrigin: origin,
        lastUpdated: _timeProvider.nowLocal,
        analyticsState: metrics,
      ),
    );
    state.mapOrNull(loaded: _markVisiblePeriodViewed);
  }

  CompanyProfileDataOrigin _resolveOrigin(
    List<CompanyProfileDataOrigin?> origins,
  ) {
    if (origins.contains(CompanyProfileDataOrigin.api)) {
      return CompanyProfileDataOrigin.api;
    }
    if (origins.contains(CompanyProfileDataOrigin.db)) {
      return CompanyProfileDataOrigin.db;
    }
    return CompanyProfileDataOrigin.cache;
  }

  List<String> _periodKeys(
    List<RevenueSegment> segments, {
    required bool isAnnual,
  }) {
    final sorted = List<RevenueSegment>.from(segments)
      ..sort((a, b) => b.date.compareTo(a.date));

    final keys = <String>{
      for (final segment in sorted)
        SegmentPeriodKey.of(segment, isAnnual: isAnnual),
    };
    return keys.toList();
  }

  Map<String, int> _assignColorIndices(List<RevenueSegment> segments) {
    final sorted = List<RevenueSegment>.from(segments)
      ..sort((a, b) => b.date.compareTo(a.date));

    final indices = <String, int>{};
    for (final segment in sorted) {
      final entries = segment.data.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      for (final entry in entries) {
        indices.putIfAbsent(entry.key, () => indices.length);
      }
    }
    return indices;
  }

  void _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanySegmentsState> emit,
  ) {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (s) => _evaluateStaleness(event.ticker, s.lastUpdated),
      failure: (_) => _triggerRefresh(
        event.ticker,
        'Segments in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerRefresh(
        event.ticker,
        'Segments in initial state. Triggering load.',
      ),
      loading: (_) =>
          _logger.info('Segments already loading, skipping staleness check.'),
    );
  }

  void _evaluateStaleness(String ticker, DateTime? lastUpdated) {
    if (lastUpdated == null) {
      _triggerRefresh(ticker, 'Segments lastUpdated is null. Triggering load.');
      return;
    }

    final difference = _timeProvider.nowLocal.difference(lastUpdated);
    if (difference.inMinutes >= _refreshIntervalMinutes) {
      _triggerRefresh(
        ticker,
        'Segments stale (TTL expired: ${difference.inMinutes}m). '
        'Triggering load.',
      );
    } else {
      _logger.info('Segments still fresh (Last updated: $lastUpdated)');
    }
  }

  void _triggerRefresh(String ticker, String reason) {
    _logger.info(reason);
    add(CompanySegmentsEvent.loadRequested(ticker, forceRefresh: true));
  }
}
