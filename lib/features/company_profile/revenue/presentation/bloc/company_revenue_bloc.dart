import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/revenue/domain/usecases/get_revenue_stats_usecase.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_state.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyRevenueBloc');

@injectable
class CompanyRevenueBloc
    extends Bloc<CompanyRevenueEvent, CompanyRevenueState> {
  final GetRevenueStatsUseCase _getRevenueStatsUseCase;

  CompanyRevenueBloc(this._getRevenueStatsUseCase)
    : super(const CompanyRevenueState.initial()) {
    on<CompanyRevenueEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyRevenueEvent event,
    Emitter<CompanyRevenueState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyRevenueState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      _logger.info('Skip loading Revenue: already loaded and no force refresh');
      return;
    }

    _logger.info(
      'Loading Revenue stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanyRevenueState.loading());

    final result = await _getRevenueStatsUseCase(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load Revenue stats', failure);
        emit(CompanyRevenueState.failure(failure));
      },
      (stats) {
        _logger.info('Successfully loaded Revenue stats');
        emit(
          CompanyRevenueState.loaded(
            revenueStats: stats,
            annualChartData: _toChartData(stats.annualRevenue, isAnnual: true),
            quarterlyChartData: _toChartData(
              stats.quarterlyRevenue,
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
              'Revenue stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyRevenueEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('Revenue still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('Revenue lastUpdated is null. Triggering load.');
          add(
            CompanyRevenueEvent.loadRequested(event.ticker, forceRefresh: true),
          );
        }
      },
      failure: (_) {
        _logger.info('Revenue in failure state. Triggering retry.');
        add(
          CompanyRevenueEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Revenue in initial state. Triggering load.');
        add(
          CompanyRevenueEvent.loadRequested(event.ticker, forceRefresh: true),
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
