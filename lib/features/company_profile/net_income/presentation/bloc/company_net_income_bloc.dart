import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/net_income/domain/usecases/get_net_income_stats_usecase.dart';
import 'company_net_income_event.dart';
import 'company_net_income_state.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyNetIncomeBloc');

@injectable
class CompanyNetIncomeBloc
    extends Bloc<CompanyNetIncomeEvent, CompanyNetIncomeState> {
  final GetNetIncomeStatsUseCase _getNetIncomeStatsUseCase;
  final IConfigService _configService;

  CompanyNetIncomeBloc(this._getNetIncomeStatsUseCase, this._configService)
    : super(const CompanyNetIncomeState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyNetIncomeState> emit,
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
        'Company Net Income already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading Net Income stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyNetIncomeState.loading());
    }

    final result = await _getNetIncomeStatsUseCase(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load Net Income stats', failure);
        emit(CompanyNetIncomeState.failure(failure));
      },
      (tuple) {
        final (stats, origin) = tuple;
        _logger.info('Successfully loaded Net Income stats (origin: $origin)');
        emit(
          CompanyNetIncomeState.loaded(
            ticker: event.ticker,
            netIncomeStats: stats,
            annualChartData: _toChartData(
              stats.annualNetIncome,
              isAnnual: true,
            ),
            quarterlyChartData: _toChartData(
              stats.quarterlyNetIncome,
              isAnnual: false,
            ),
            historyLimit: _configService.freePlanHistoryCount,
            dataOrigin: origin,
            lastUpdated: DateTime.now(),
          ),
        );
      },
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyNetIncomeState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'Net Income stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyNetIncomeEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('Net Income still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('Net Income lastUpdated is null. Triggering load.');
          add(
            CompanyNetIncomeEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Net Income in failure state. Triggering retry.');
        add(
          CompanyNetIncomeEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Net Income in initial state. Triggering load.');
        add(
          CompanyNetIncomeEvent.loadRequested(event.ticker, forceRefresh: true),
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
