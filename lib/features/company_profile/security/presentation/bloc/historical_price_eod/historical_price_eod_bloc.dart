import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_historical_eod_prices_use_case.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/market_hours_freshness_service.dart';
import 'historical_price_eod_event.dart';
import 'historical_price_eod_state.dart';

final _logger = BizzieLogger('HistoricalPriceEodBloc');

@injectable
class HistoricalPriceEodBloc
    extends Bloc<HistoricalPriceEodEvent, HistoricalPriceEodState>
    with
        AuthSessionResetMixin<HistoricalPriceEodEvent, HistoricalPriceEodState> {
  final GetHistoricalEodPricesUseCase _getPrices;
  final MarketHoursFreshnessService _freshnessService;
  final ITimeProvider _timeProvider;

  HistoricalPriceEodBloc(
    this._getPrices,
    this._freshnessService,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const HistoricalPriceEodState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(_onStalenessCheckRequested);
    on<EodReset>(_onReset);
    resetOnSessionEnd(getAuthStream, const HistoricalPriceEodEvent.reset());
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<HistoricalPriceEodState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      _logger.info(
        'Skip loading EOD prices: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading EOD prices for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const HistoricalPriceEodState.loading());

    final result = await _getPrices(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load EOD prices', failure);
        emit(HistoricalPriceEodState.failure(failure));
      },
      (tuple) {
        final prices = tuple.$1;
        final origin = tuple.$2;

        _logger.info('Successfully loaded EOD prices: ${prices.length} points');
        emit(
          HistoricalPriceEodState.loaded(
            prices,
            dataSource: origin,
            lastUpdated: _timeProvider.nowLocal,
          ),
        );
      },
    );
  }

  void _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<HistoricalPriceEodState> emit,
  ) {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final isStale = _freshnessService.isStale(loadedState.lastUpdated);
        if (isStale) {
          _triggerForceReload(event.ticker, reason: 'stale');
        } else {
          _logger.info('EOD prices still fresh (market hours freshness check)');
        }
      },
      failure: (_) => _triggerForceReload(event.ticker, reason: 'failure state'),
      initial: (_) => _triggerForceReload(event.ticker, reason: 'initial state'),
    );
  }

  void _triggerForceReload(String ticker, {required String reason}) {
    _logger.info('EOD prices $reason. Triggering load.');
    add(HistoricalPriceEodEvent.loadRequested(ticker, forceRefresh: true));
  }

  void _onReset(EodReset event, Emitter<HistoricalPriceEodState> emit) =>
      emit(const HistoricalPriceEodState.initial());
}
