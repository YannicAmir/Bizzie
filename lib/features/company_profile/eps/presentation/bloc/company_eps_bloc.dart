import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/eps/domain/usecases/get_eps_stats_usecase.dart';
import 'company_eps_event.dart';
import 'company_eps_state.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyEpsBloc');

@injectable
class CompanyEpsBloc extends Bloc<CompanyEpsEvent, CompanyEpsState> {
  final GetEpsStatsUseCase _getEpsStatsUseCase;
  final IConfigService _configService;

  CompanyEpsBloc(this._getEpsStatsUseCase, this._configService)
    : super(const CompanyEpsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyEpsState> emit,
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
        'Company EPS already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading EPS stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyEpsState.loading());
    }

    final result = await _getEpsStatsUseCase(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load EPS stats', failure);
        emit(CompanyEpsState.failure(failure));
      },
      (tuple) {
        final (stats, origin) = tuple;
        _logger.info('Successfully loaded EPS stats (origin: $origin)');
        emit(
          CompanyEpsState.loaded(
            ticker: event.ticker,
            epsStats: stats,
            annualChartData: _toChartData(stats.annualEps, isAnnual: true),
            quarterlyChartData: _toChartData(
              stats.quarterlyEps,
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
    Emitter<CompanyEpsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'EPS stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          } else {
            _logger.info('EPS still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('EPS lastUpdated is null. Triggering load.');
          add(CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true));
        }
      },
      failure: (_) {
        _logger.info('EPS in failure state. Triggering retry.');
        add(CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true));
      },
      initial: (_) {
        _logger.info('EPS in initial state. Triggering load.');
        add(CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true));
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
