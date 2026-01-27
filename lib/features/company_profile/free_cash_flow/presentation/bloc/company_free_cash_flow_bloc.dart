import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import '../../domain/usecases/get_free_cash_flow_stats_usecase.dart';
import 'company_free_cash_flow_event.dart';
import 'company_free_cash_flow_state.dart';

final _logger = BizzieLogger('CompanyFreeCashFlowBloc');

@injectable
class CompanyFreeCashFlowBloc
    extends Bloc<CompanyFreeCashFlowEvent, CompanyFreeCashFlowState> {
  final GetFreeCashFlowStatsUseCase _getFreeCashFlowStats;
  CompanyFreeCashFlowBloc(this._getFreeCashFlowStats)
    : super(const CompanyFreeCashFlowState.initial()) {
    on<CompanyFreeCashFlowEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyFreeCashFlowEvent event,
    Emitter<CompanyFreeCashFlowState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyFreeCashFlowState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      _logger.info(
        'Skip loading Free Cash Flow: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading Free Cash Flow stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanyFreeCashFlowState.loading());

    final result = await _getFreeCashFlowStats(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load Free Cash Flow stats', failure);
        emit(CompanyFreeCashFlowState.failure(failure));
      },
      (data) {
        _logger.info('Successfully loaded Free Cash Flow stats');
        emit(
          CompanyFreeCashFlowState.loaded(
            fcfStats: data,
            annualChartData: _toChartData(data.annualFcf, isAnnual: true),
            quarterlyChartData: _toChartData(
              data.quarterlyFcf,
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
              'Free Cash Flow stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyFreeCashFlowEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info(
              'Free Cash Flow still fresh (Last updated: $lastUpdated)',
            );
          }
        } else {
          _logger.info('Free Cash Flow lastUpdated is null. Triggering load.');
          add(
            CompanyFreeCashFlowEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Free Cash Flow in failure state. Triggering retry.');
        add(
          CompanyFreeCashFlowEvent.loadRequested(
            event.ticker,
            forceRefresh: true,
          ),
        );
      },
      initial: (_) {
        _logger.info('Free Cash Flow in initial state. Triggering load.');
        add(
          CompanyFreeCashFlowEvent.loadRequested(
            event.ticker,
            forceRefresh: true,
          ),
        );
      },
    );
  }

  List<ChartDataPoint> _toChartData(
    List<FinancialDataPoint> dataPoints, {
    required bool isAnnual,
  }) {
    return dataPoints.reversed.map((p) {
      final label = BizzieDateFormatter.formatChartLabel(
        p.date,
        isAnnual: isAnnual,
      );
      return ChartDataPoint(label: label, value: p.value);
    }).toList();
  }
}
