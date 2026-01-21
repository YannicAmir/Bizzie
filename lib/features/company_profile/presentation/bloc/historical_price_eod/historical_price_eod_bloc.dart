import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_historical_eod_prices_use_case.dart';
import 'historical_price_eod_event.dart';
import 'historical_price_eod_state.dart';

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
      return;
    }

    emit(const HistoricalPriceEodState.loading());

    final result = await _getPrices(event.ticker);

    result.fold(
      (failure) => emit(HistoricalPriceEodState.failure(failure)),
      (prices) => emit(
        HistoricalPriceEodState.loaded(prices, lastUpdated: DateTime.now()),
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
              HistoricalPriceEodEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          }
        }
      },
      failure: (_) => add(
        HistoricalPriceEodEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
      initial: (_) => add(
        HistoricalPriceEodEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
    );
  }
}
