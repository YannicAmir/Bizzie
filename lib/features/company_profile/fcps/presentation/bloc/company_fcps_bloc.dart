import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:injectable/injectable.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import '../../domain/usecases/get_fcps_stats_usecase.dart';
import 'company_fcps_event.dart';
import 'company_fcps_state.dart';

final _logger = BizzieLogger('CompanyFcpsBloc');

@injectable
class CompanyFcpsBloc extends Bloc<CompanyFcpsEvent, CompanyFcpsState> {
  final GetFcpsStatsUseCase _getFcpsStats;
  final IConfigService _configService;

  CompanyFcpsBloc(this._getFcpsStats, this._configService)
    : super(const CompanyFcpsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyFcpsState> emit,
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
        'Company FCPS already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading FCPS stats for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyFcpsState.loading());
    }

    final result = await _getFcpsStats(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load FCPS stats', failure);
        emit(CompanyFcpsState.failure(failure));
      },
      (tuple) {
        final (data, origin) = tuple;
        _logger.info('Successfully loaded FCPS stats (origin: $origin)');
        emit(
          CompanyFcpsState.loaded(
            ticker: event.ticker,
            fcpsStats: data,
            annualChartData: _toChartData(data.annualFcps, isAnnual: true),
            quarterlyChartData: _toChartData(
              data.quarterlyFcps,
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
    Emitter<CompanyFcpsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'FCPS stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          } else {
            _logger.info('FCPS still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('FCPS lastUpdated is null. Triggering load.');
          add(CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true));
        }
      },
      failure: (_) {
        _logger.info('FCPS in failure state. Triggering retry.');
        add(CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true));
      },
      initial: (_) {
        _logger.info('FCPS in initial state. Triggering load.');
        add(CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true));
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
