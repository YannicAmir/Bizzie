import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:injectable/injectable.dart';
import 'package:bizzie/features/company_profile/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/shares_summary_data.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_share_stats_usecase.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'company_shares_event.dart';
import 'company_shares_state.dart';

@injectable
class CompanySharesBloc extends Bloc<CompanySharesEvent, CompanySharesState> {
  final GetShareStatsUseCase _getShareStats;
  CompanySharesBloc(this._getShareStats)
    : super(const CompanySharesState.initial()) {
    on<CompanySharesEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanySharesEvent event,
    Emitter<CompanySharesState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanySharesState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      return;
    }

    emit(const CompanySharesState.loading());

    final result = await _getShareStats(event.ticker);

    result.fold(
      (failure) => emit(CompanySharesState.failure(failure)),
      (data) => emit(
        CompanySharesState.loaded(
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
          lastUpdated: DateTime.now(),
        ),
      ),
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
              CompanySharesEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          }
        }
      },
      failure: (_) => add(
        CompanySharesEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
      initial: (_) => add(
        CompanySharesEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
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
