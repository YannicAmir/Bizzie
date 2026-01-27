import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/shares_summary_data.dart';
import 'package:bizzie/features/company_profile/shares/domain/usecases/get_shares_usecase.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'company_shares_event.dart';
import 'company_shares_state.dart';

final _logger = BizzieLogger('CompanySharesBloc');

@injectable
class CompanySharesBloc extends Bloc<CompanySharesEvent, CompanySharesState> {
  final GetSharesUseCase _getShares;
  CompanySharesBloc(this._getShares)
    : super(const CompanySharesState.initial()) {
    on<CompanySharesEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanySharesEvent event,
    Emitter<CompanySharesState> emit,
  ) async {
    _logger.info('Handling event: $event');
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
      _logger.info('Skip loading Shares: already loaded and no force refresh');
      return;
    }

    _logger.info(
      'Loading Shares stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanySharesState.loading());

    final result = await _getShares(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load Shares stats', failure);
        emit(CompanySharesState.failure(failure));
      },
      (data) {
        _logger.info('Successfully loaded Shares stats');
        emit(
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
        );
      },
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
