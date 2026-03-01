import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/shares_summary_data.dart';
import 'package:bizzie/features/company_profile/shares/domain/usecases/get_shares_usecase.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/features/company_profile/shares/presentation/analytics/shares_tab_analytics.dart';
import 'package:bizzie/features/company_profile/shares/presentation/analytics/shares_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'company_shares_event.dart';
import 'company_shares_state.dart';

final _logger = BizzieLogger('CompanySharesBloc');

@injectable
class CompanySharesBloc extends Bloc<CompanySharesEvent, CompanySharesState>
    with
        CompanyProfileAnalyticsMixin<
          CompanySharesEvent,
          CompanySharesState,
          SharesTabViewState
        > {
  final GetSharesUseCase _getShares;
  final IConfigService _configService;
  final SharesTabAnalytics _analytics;

  CompanySharesBloc(this._getShares, this._configService, this._analytics)
    : super(const CompanySharesState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) async => await onTabHidden());
    on<AppBackgrounded>((_, __) async => await onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<PeriodViewed>(_onPeriodViewed);
    on<ViewAllTapped>(_onViewAllTapped);
  }

  @override
  CompanyProfileTabTracker<SharesTabViewState> get analyticsTracker =>
      _analytics;

  void _onTabShown(TabShown event, Emitter<CompanySharesState> emit) {
    onTabShown(
      event.ticker,
      SharesTabViewState(
        ticker: event.ticker,
        timestamp: DateTime.now().toIso8601String(),
      ),
    );
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  void _onPeriodViewed(PeriodViewed event, Emitter<CompanySharesState> emit) {
    updateAnalyticsState(
      (s) => event.isAnnual
          ? s.copyWith(viewedYearlySharesTab: true)
          : s.copyWith(viewedQtrlySharesTab: true),
    );
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  void _onViewAllTapped(ViewAllTapped event, Emitter<CompanySharesState> emit) {
    updateAnalyticsState((s) {
      if (event.isAnnual) {
        return event.isChart
            ? s.copyWith(tappedYrchartViewAll: true)
            : s.copyWith(tappedYrtableViewAll: true);
      } else {
        return event.isChart
            ? s.copyWith(tappedQtrchartViewAll: true)
            : s.copyWith(tappedQtrtableViewAll: true);
      }
    });

    state.maybeMap(
      loaded: (s) => emit(s.copyWith(analyticsState: analyticsSession)),
      orElse: () {},
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanySharesState> emit,
  ) async {
    final isAlreadyLoaded = state.maybeMap(
      loaded: (s) => true,
      orElse: () => false,
    );

    final isRightTicker = state.maybeMap(
      loaded: (s) => s.ticker == event.ticker,
      orElse: () => false,
    );

    if (isAlreadyLoaded && isRightTicker && !event.forceRefresh) {
      _logger.info(
        'Company Shares already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanySharesState.loading());
    }

    final stopwatch = Stopwatch()..start();
    final result = await _getShares(event.ticker);
    stopwatch.stop();

    result.fold(
      (failure) {
        _logger.severe('Failed to load Shares stats', failure);
        updateAnalyticsState(
          (s) => s.copyWith(
            isSuccess: false,
            loadTimeMs: stopwatch.elapsedMilliseconds,
          ),
        );
        emit(CompanySharesState.failure(failure));
      },
      (tuple) {
        final (data, origin) = tuple;
        _logger.info('Successfully loaded Shares stats (origin: $origin)');
        emit(
          CompanySharesState.loaded(
            ticker: event.ticker,
            shareStats: data,
            annualChartData: _toChartData(
              data.annualWeightedAverageShares,
              isAnnual: true,
            ),
            quarterlyChartData: _toChartData(
              data.quarterlyWeightedAverageShares,
              isAnnual: false,
            ),
            annualSummary: _computeSummary(
              data.annualWeightedAverageShares,
              isAnnual: true,
            ),
            quarterlySummary: _computeSummary(
              data.quarterlyWeightedAverageShares,
              isAnnual: false,
            ),
            historyLimit: _configService.freePlanHistoryCount,
            dataOrigin: origin,
            lastUpdated: DateTime.now(),
          ),
        );

        updateAnalyticsState(
          (s) => s.copyWith(
            isSuccess: true,
            dataSource: origin,
            loadTimeMs: stopwatch.elapsedMilliseconds,
          ),
        );
      },
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanySharesState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'Shares stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanySharesEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('Shares still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('Shares lastUpdated is null. Triggering load.');
          add(
            CompanySharesEvent.loadRequested(event.ticker, forceRefresh: true),
          );
        }
      },
      failure: (_) {
        _logger.info('Shares in failure state. Triggering retry.');
        add(CompanySharesEvent.loadRequested(event.ticker, forceRefresh: true));
      },
      initial: (_) {
        _logger.info('Shares in initial state. Triggering load.');
        add(CompanySharesEvent.loadRequested(event.ticker, forceRefresh: true));
      },
    );
  }

  List<ChartDataPoint> _toChartData(
    List<FinancialDataPoint> dataPoints, {
    required bool isAnnual,
  }) {
    final sorted = List<FinancialDataPoint>.from(dataPoints)
      ..sort((a, b) => a.date.compareTo(b.date));

    return sorted.map((p) {
      final label = BizzieDateFormatter.formatChartLabel(
        p.date,
        isAnnual: isAnnual,
      );
      return ChartDataPoint(label: label, value: p.value);
    }).toList();
  }

  SharesSummaryData _computeSummary(
    List<FinancialDataPoint> dataPoints, {
    required bool isAnnual,
  }) {
    if (dataPoints.isEmpty) {
      return const SharesSummaryData(
        currentValue: 0,
        growthPercentage: 0,
        absoluteDelta: 0,
        isPositive: false,
        referenceLabel: '',
      );
    }

    final sorted = List<FinancialDataPoint>.from(dataPoints)
      ..sort((a, b) => a.date.compareTo(b.date));

    final currentPoint = sorted.last;
    var referencePoint = sorted.first;

    final currentDate = DateTime.tryParse(currentPoint.date);
    if (currentDate != null) {
      final lookbackYears = isAnnual ? 5 : 1;
      final cutoffDate = DateTime(
        currentDate.year - lookbackYears,
        currentDate.month,
        currentDate.day,
      );

      for (final p in sorted) {
        final d = DateTime.tryParse(p.date);
        if (d != null && (d.isAfter(cutoffDate) || d == cutoffDate)) {
          referencePoint = p;
          break;
        }
      }
    }

    final currentValue = currentPoint.value;
    final referenceValue = referencePoint.value;
    final delta = currentValue - referenceValue;
    final growthPercentage = referenceValue == 0
        ? 0.0
        : (delta / referenceValue) * 100;

    final referenceLabel = BizzieDateFormatter.formatReferenceLabel(
      referencePoint.date,
      isAnnual: isAnnual,
    );

    return SharesSummaryData(
      currentValue: currentValue,
      growthPercentage: growthPercentage,
      absoluteDelta: delta.abs(),
      isPositive: delta >= 0,
      referenceLabel: referenceLabel,
    );
  }
}
