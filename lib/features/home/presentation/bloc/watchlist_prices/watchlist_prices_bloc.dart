import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/domain/usecases/get_watchlist_prices_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

import 'watchlist_prices_event.dart';
import 'watchlist_prices_state.dart';

final _logger = BizzieLogger('WatchlistPricesBloc');

@injectable
class WatchlistPricesBloc
    extends Bloc<WatchlistPricesEvent, WatchlistPricesState>
    with AuthSessionResetMixin<WatchlistPricesEvent, WatchlistPricesState> {
  final GetWatchlistPricesUseCase _getWatchlistPrices;
  final IConfigService _configService;

  WatchlistPricesBloc(
    this._getWatchlistPrices,
    this._configService,
    GetAuthStream getAuthStream,
  ) : super(const WatchlistPricesState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<Reset>((_, emit) => emit(const WatchlistPricesState.initial()));
    resetOnSessionEnd(getAuthStream, const WatchlistPricesEvent.reset());
  }

  bool get _hasLoadedPrices =>
      state.maybeMap(loaded: (_) => true, orElse: () => false);

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<WatchlistPricesState> emit,
  ) async {
    if (!_configService.showWatchlistPrice) {
      emit(const WatchlistPricesState.disabled());
      return;
    }

    _logger.info('Loading stock prices for ${event.tickers.length} tickers');
    if (!_hasLoadedPrices) emit(const WatchlistPricesState.loading());

    final result = await _getWatchlistPrices(event.tickers);

    result.fold(
      (failure) => _emitLoadFailure(failure, emit),
      (prices) => emit(WatchlistPricesState.loaded(_toPriceMap(prices))),
    );
  }

  void _emitLoadFailure(
    Failure failure,
    Emitter<WatchlistPricesState> emit,
  ) {
    _logger.warning('Failed to load stock prices: ${failure.errorMessage}');
    if (!_hasLoadedPrices) emit(WatchlistPricesState.failure(failure));
  }

  Map<String, WatchlistStockPrice> _toPriceMap(
    List<WatchlistStockPrice> prices,
  ) {
    return {for (final price in prices) price.ticker: price};
  }
}
