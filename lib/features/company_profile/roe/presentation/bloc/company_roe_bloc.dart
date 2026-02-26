import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:bizzie/core/enums/data_origin.dart';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/roe/domain/usecases/get_roe_usecase.dart';

import 'company_roe_event.dart';
import 'company_roe_state.dart';

final _logger = BizzieLogger('CompanyRoeBloc');

@injectable
class CompanyRoeBloc extends Bloc<CompanyRoeEvent, CompanyRoeState> {
  final GetRoeUseCase _getRoeStats;
  final IConfigService _configService;

  CompanyRoeBloc(this._getRoeStats, this._configService)
    : super(const CompanyRoeState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyRoeState> emit,
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
        'Company ROE already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading ROE stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyRoeState.loading());
    }

    final result = await _getRoeStats(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load ROE stats', failure);
        emit(CompanyRoeState.failure(failure));
      },
      (tuple) {
        final (keyMetrics, origin) = tuple;
        _logger.info(
          'Successfully loaded ROE stats (origin: $origin): ${keyMetrics.length} points',
        );
        _emitLoadedState(event.ticker, keyMetrics, origin, emit);
      },
    );
  }

  void _emitLoadedState(
    String ticker,
    List<dynamic> keyMetrics,
    CompanyProfileDataOrigin origin,
    Emitter<CompanyRoeState> emit,
  ) {
    final sortedPoints = _extractSortedDataPoints(keyMetrics);

    if (sortedPoints.isEmpty) {
      _logger.info('ROE metrics empty after extraction');
      emit(_emptyLoadedState(ticker, origin));
      return;
    }

    final currentPoint = sortedPoints.last;
    final referencePoint = _findReferencePoint(sortedPoints, currentPoint);
    final growth = _calculateGrowth(currentPoint.value, referencePoint.value);
    final referenceLabel = _formatReferenceLabel(referencePoint);
    final chartData = _buildChartData(sortedPoints);

    _logger.info(
      'Emitting loaded state: current=${currentPoint.value}, growth=${growth.percentage}%',
    );
    emit(
      CompanyRoeState.loaded(
        ticker: ticker,
        dataPoints: sortedPoints,
        chartData: chartData,
        currentValue: currentPoint.value,
        growthPercentage: growth.percentage,
        absoluteDelta: growth.delta.abs(),
        isPositive: growth.delta >= 0,
        referenceLabel: referenceLabel,
        historyLimit: _configService.freePlanHistoryCount,
        dataOrigin: origin,
        lastUpdated: DateTime.now(),
      ),
    );
  }

  List<FinancialDataPoint> _extractSortedDataPoints(List<dynamic> keyMetrics) {
    final dataPoints = keyMetrics
        .map(
          (m) => FinancialDataPoint(
            date: m.date,
            period: m.period,
            value: m.returnOnEquity,
          ),
        )
        .toList();
    return dataPoints..sort((a, b) => a.date.compareTo(b.date));
  }

  FinancialDataPoint _findReferencePoint(
    List<FinancialDataPoint> sortedPoints,
    FinancialDataPoint currentPoint,
  ) {
    var referencePoint = sortedPoints.first;
    final currentDate = DateTime.tryParse(currentPoint.date);

    if (currentDate != null && sortedPoints.length > 1) {
      final cutoffDate = DateTime(
        currentDate.year - 5,
        currentDate.month,
        currentDate.day,
      );
      for (final p in sortedPoints) {
        final d = DateTime.tryParse(p.date);
        if (d != null && (d.isAfter(cutoffDate) || d == cutoffDate)) {
          referencePoint = p;
          break;
        }
      }
    }
    return referencePoint;
  }

  ({double delta, double percentage}) _calculateGrowth(
    double currentValue,
    double referenceValue,
  ) {
    final delta = currentValue - referenceValue;
    final percentage = referenceValue.abs() < 0.001
        ? 0.0
        : (delta / referenceValue.abs()) * 100;
    return (delta: delta, percentage: percentage);
  }

  String _formatReferenceLabel(FinancialDataPoint referencePoint) {
    final refDate = DateTime.tryParse(referencePoint.date);
    return refDate != null
        ? DateFormat('yyyy').format(refDate)
        : referencePoint.date;
  }

  List<ChartDataPoint> _buildChartData(List<FinancialDataPoint> sortedPoints) {
    return sortedPoints.map((p) {
      final date = DateTime.tryParse(p.date);
      final label = date != null ? DateFormat("MMM ''yy").format(date) : p.date;
      return ChartDataPoint(label: label, value: p.value * 100);
    }).toList();
  }

  CompanyRoeState _emptyLoadedState(
    String ticker,
    CompanyProfileDataOrigin origin,
  ) {
    return CompanyRoeState.loaded(
      ticker: ticker,
      dataPoints: [],
      chartData: [],
      currentValue: 0,
      growthPercentage: 0,
      absoluteDelta: 0,
      isPositive: false,
      referenceLabel: '',
      historyLimit: _configService.freePlanHistoryCount,
      dataOrigin: origin,
      lastUpdated: DateTime.now(),
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyRoeState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'ROE stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyRoeEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          } else {
            _logger.info('ROE still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('ROE lastUpdated is null. Triggering load.');
          add(CompanyRoeEvent.loadRequested(event.ticker, forceRefresh: true));
        }
      },
      failure: (_) {
        _logger.info('ROE in failure state. Triggering retry.');
        add(CompanyRoeEvent.loadRequested(event.ticker, forceRefresh: true));
      },
      initial: (_) {
        _logger.info('ROE in initial state. Triggering load.');
        add(CompanyRoeEvent.loadRequested(event.ticker, forceRefresh: true));
      },
    );
  }
}
