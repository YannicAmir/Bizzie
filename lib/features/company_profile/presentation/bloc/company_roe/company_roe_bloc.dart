import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_key_metrics_usecase.dart';

import 'company_roe_event.dart';
import 'company_roe_state.dart';

final _logger = BizzieLogger('CompanyRoeBloc');

@injectable
class CompanyRoeBloc extends Bloc<CompanyRoeEvent, CompanyRoeState> {
  final GetKeyMetricsUseCase _getKeyMetrics;

  CompanyRoeBloc(this._getKeyMetrics) : super(const CompanyRoeState.initial()) {
    on<CompanyRoeEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyRoeEvent event,
    Emitter<CompanyRoeState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyRoeState> emit,
  ) async {
    if (_shouldSkipLoad(event.forceRefresh)) {
      _logger.info('Skip loading ROE: already loaded and no force refresh');
      return;
    }

    _logger.info(
      'Loading ROE stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanyRoeState.loading());

    final result = await _getKeyMetrics(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load ROE stats', failure);
        emit(CompanyRoeState.failure(failure));
      },
      (keyMetrics) {
        _logger.info(
          'Successfully loaded ROE stats: ${keyMetrics.length} points',
        );
        _emitLoadedState(keyMetrics, emit);
      },
    );
  }

  bool _shouldSkipLoad(bool forceRefresh) {
    return !forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false);
  }

  void _emitLoadedState(
    List<dynamic> keyMetrics,
    Emitter<CompanyRoeState> emit,
  ) {
    final sortedPoints = _extractSortedDataPoints(keyMetrics);

    if (sortedPoints.isEmpty) {
      _logger.info('ROE metrics empty after extraction');
      emit(_emptyLoadedState());
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
        dataPoints: sortedPoints,
        chartData: chartData,
        currentValue: currentPoint.value,
        growthPercentage: growth.percentage,
        absoluteDelta: growth.delta.abs(),
        isPositive: growth.delta >= 0,
        referenceLabel: referenceLabel,
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

  CompanyRoeState _emptyLoadedState() {
    return CompanyRoeState.loaded(
      dataPoints: [],
      chartData: [],
      currentValue: 0,
      growthPercentage: 0,
      absoluteDelta: 0,
      isPositive: false,
      referenceLabel: '',
      lastUpdated: DateTime.now(),
    );
  }

  Future<void> _onStalenessCheckRequested(StalenessCheckRequested event) async {
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
