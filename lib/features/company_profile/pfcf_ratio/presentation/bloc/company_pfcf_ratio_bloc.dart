import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/usecases/get_pfcf_ratio_usecase.dart';

import 'company_pfcf_ratio_event.dart';
import 'company_pfcf_ratio_state.dart';

final _logger = BizzieLogger('CompanyPfcfRatioBloc');

@injectable
class CompanyPfcfRatioBloc
    extends Bloc<CompanyPfcfRatioEvent, CompanyPfcfRatioState> {
  final GetPfcfRatioUseCase _getPfcfRatio;

  CompanyPfcfRatioBloc(this._getPfcfRatio)
    : super(const CompanyPfcfRatioState.initial()) {
    on<CompanyPfcfRatioEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyPfcfRatioEvent event,
    Emitter<CompanyPfcfRatioState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyPfcfRatioState> emit,
  ) async {
    if (_shouldSkipLoad(event.forceRefresh)) {
      _logger.info(
        'Skip loading PFCF Ratio: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading PFCF Ratio stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanyPfcfRatioState.loading());

    final result = await _getPfcfRatio(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load PFCF Ratio stats', failure);
        emit(CompanyPfcfRatioState.failure(failure));
      },
      (ratios) {
        _logger.info(
          'Successfully loaded PFCF Ratio stats: ${ratios.length} points',
        );
        _emitLoadedState(ratios, emit);
      },
    );
  }

  bool _shouldSkipLoad(bool forceRefresh) {
    return !forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false);
  }

  void _emitLoadedState(
    List<dynamic> ratios,
    Emitter<CompanyPfcfRatioState> emit,
  ) {
    final sortedPoints = _extractSortedDataPoints(ratios);

    if (sortedPoints.isEmpty) {
      _logger.info('PFCF Ratio data points empty after extraction');
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
      CompanyPfcfRatioState.loaded(
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

  List<FinancialDataPoint> _extractSortedDataPoints(List<dynamic> ratios) {
    final allPoints = ratios
        .map(
          (r) => FinancialDataPoint(
            date: r.date,
            period: r.period,
            value: r.priceToFreeCashFlowRatio,
          ),
        )
        .toList();

    final validPoints = allPoints.where((p) => p.value != 0).toList();

    if (validPoints.length != allPoints.length) {
      _logger.info(
        'Filtered ${allPoints.length - validPoints.length} zero-value P/FCF points',
      );
    }

    return validPoints..sort((a, b) => a.date.compareTo(b.date));
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
      return ChartDataPoint(label: label, value: p.value);
    }).toList();
  }

  CompanyPfcfRatioState _emptyLoadedState() {
    return CompanyPfcfRatioState.loaded(
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
              'PFCF Ratio stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyPfcfRatioEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('PFCF Ratio still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('PFCF Ratio lastUpdated is null. Triggering load.');
          add(
            CompanyPfcfRatioEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('PFCF Ratio in failure state. Triggering retry.');
        add(
          CompanyPfcfRatioEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('PFCF Ratio in initial state. Triggering load.');
        add(
          CompanyPfcfRatioEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
    );
  }
}
