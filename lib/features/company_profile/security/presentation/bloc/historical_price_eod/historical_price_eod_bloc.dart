import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_historical_eod_prices_use_case.dart';
import 'package:bizzie/shared/utils/market_hours_helper.dart';
import 'historical_price_eod_event.dart';
import 'historical_price_eod_state.dart';

final _logger = BizzieLogger('HistoricalPriceEodBloc');

@injectable
class HistoricalPriceEodBloc
    extends Bloc<HistoricalPriceEodEvent, HistoricalPriceEodState> {
  final GetHistoricalEodPricesUseCase _getPrices;

  HistoricalPriceEodBloc(this._getPrices)
    : super(const HistoricalPriceEodState.initial()) {
    on<HistoricalPriceEodEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    HistoricalPriceEodEvent event,
    Emitter<HistoricalPriceEodState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
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
      (prices) {
        _logger.info('Successfully loaded EOD prices: ${prices.length} points');
        emit(
          HistoricalPriceEodState.loaded(prices, lastUpdated: DateTime.now()),
        );
      },
    );
  }

  Future<void> _onStalenessCheckRequested(StalenessCheckRequested event) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final isStale = MarketHoursHelper.isDataStale(loadedState.lastUpdated);
        if (isStale) {
          _logger.info(
            'EOD prices stale (MarketHoursHelper check). Triggering load.',
          );
          add(
            HistoricalPriceEodEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        } else {
          _logger.info('EOD prices still fresh (MarketHoursHelper check)');
        }
      },
      failure: (_) {
        _logger.info('EOD prices in failure state. Triggering retry.');
        add(
          HistoricalPriceEodEvent.loadRequested(
            event.ticker,
            forceRefresh: true,
          ),
        );
      },
      initial: (_) {
        _logger.info('EOD prices in initial state. Triggering load.');
        add(
          HistoricalPriceEodEvent.loadRequested(
            event.ticker,
            forceRefresh: true,
          ),
        );
      },
    );
  }
}
