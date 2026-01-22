import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import 'package:bizzie/features/company_profile/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_ratios_usecase.dart';

import 'company_pe_ratio_event.dart';
import 'company_pe_ratio_state.dart';

@injectable
class CompanyPeRatioBloc
    extends Bloc<CompanyPeRatioEvent, CompanyPeRatioState> {
  final GetRatiosUseCase _getRatios;

  CompanyPeRatioBloc(this._getRatios)
    : super(const CompanyPeRatioState.initial()) {
    on<CompanyPeRatioEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyPeRatioEvent event,
    Emitter<CompanyPeRatioState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyPeRatioState> emit,
  ) async {
    if (_shouldSkipLoad(event.forceRefresh)) return;

    emit(const CompanyPeRatioState.loading());

    final result = await _getRatios(event.ticker);

    result.fold(
      (failure) => emit(CompanyPeRatioState.failure(failure)),
      (ratios) => _emitLoadedState(ratios, emit),
    );
  }

  bool _shouldSkipLoad(bool forceRefresh) {
    return !forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false);
  }

  void _emitLoadedState(
    List<dynamic> ratios,
    Emitter<CompanyPeRatioState> emit,
  ) {
    final sortedPoints = _extractSortedDataPoints(ratios);

    if (sortedPoints.isEmpty) {
      emit(_emptyLoadedState());
      return;
    }

    final currentPoint = sortedPoints.last;
    final referencePoint = _findReferencePoint(sortedPoints, currentPoint);
    final growth = _calculateGrowth(currentPoint.value, referencePoint.value);
    final referenceLabel = _formatReferenceLabel(referencePoint);
    final chartData = _buildChartData(sortedPoints);

    emit(
      CompanyPeRatioState.loaded(
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
    final dataPoints = ratios
        .map(
          (r) => FinancialDataPoint(
            date: r.date,
            period: r.period,
            value: r.priceToEarningsRatio,
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
      return ChartDataPoint(label: label, value: p.value);
    }).toList();
  }

  CompanyPeRatioState _emptyLoadedState() {
    return CompanyPeRatioState.loaded(
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
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            add(
              CompanyPeRatioEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          }
        }
      },
      failure: (_) => add(
        CompanyPeRatioEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
      initial: (_) => add(
        CompanyPeRatioEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
    );
  }
}
