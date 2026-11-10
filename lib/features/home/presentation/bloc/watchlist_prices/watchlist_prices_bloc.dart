import 'dart:async';

import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/domain/usecases/watch_watchlist_prices_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'watchlist_prices_event.dart';
import 'watchlist_prices_state.dart';

final _logger = BizzieLogger('WatchlistPricesBloc');

@injectable
class WatchlistPricesBloc
    extends Bloc<WatchlistPricesEvent, WatchlistPricesState>
    with AuthSessionResetMixin<WatchlistPricesEvent, WatchlistPricesState> {
  final WatchWatchlistPricesUseCase _watchWatchlistPrices;
  final GetWatchlistUseCase _getWatchlist;
  final IConfigService _configService;

  StreamSubscription<UserModel?>? _authSubscription;
  StreamSubscription<Either<Failure, List<Company>>>? _watchlistSubscription;
  String? _currentUid;
  List<String> _currentTickers = const [];
  Set<String>? _lastRequestedTickers;

  WatchlistPricesBloc(
    this._watchWatchlistPrices,
    this._getWatchlist,
    this._configService,
    GetAuthStream getAuthStream,
  ) : super(const WatchlistPricesState.initial()) {
    on<WatchlistPricesEvent>(
      (event, emit) => event.map(
        loadRequested: (e) => _onLoadRequested(e, emit),
        refreshRequested: (e) => _onRefreshRequested(e, emit),
        reset: (e) async => _onReset(e, emit),
      ),
      transformer: _distinctRestartable(),
    );
    resetOnSessionEnd(getAuthStream, const WatchlistPricesEvent.reset());
    _authSubscription = getAuthStream().listen(_onAuthChanged);
  }

  EventTransformer<WatchlistPricesEvent> _distinctRestartable() {
    return (events, mapper) => restartable<WatchlistPricesEvent>()(
      events.where(_isNewRequest),
      mapper,
    );
  }

  bool _isNewRequest(WatchlistPricesEvent event) =>
      event.maybeMap(loadRequested: _isNewTickerSet, orElse: () => true);

  bool _isNewTickerSet(LoadRequested event) {
    final tickers = event.tickers.toSet();
    if (_lastRequestedTickers != null &&
        const SetEquality<String>().equals(_lastRequestedTickers!, tickers)) {
      return false;
    }
    _lastRequestedTickers = tickers;
    return true;
  }

  bool get _hasLoadedPrices =>
      state.maybeMap(loaded: (_) => true, orElse: () => false);

  Future<void> _onAuthChanged(UserModel? user) async {
    final uid = user?.id;
    if (uid == _currentUid) return;
    _currentUid = uid;

    await _watchlistSubscription?.cancel();
    _watchlistSubscription = null;

    if (uid == null) return;

    final stream = await _getWatchlist(uid);
    if (_currentUid != uid) return;
    _watchlistSubscription = stream.listen(_onWatchlistChanged);
  }

  void _onWatchlistChanged(Either<Failure, List<Company>> result) {
    result.fold(
      (failure) =>
          _logger.warning('Watchlist stream failed: ${failure.errorMessage}'),
      (companies) {
        final tickers = companies.map((company) => company.ticker).toList();
        add(WatchlistPricesEvent.loadRequested(tickers));
      },
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<WatchlistPricesState> emit,
  ) async {
    _currentTickers = event.tickers;
    await _watchPrices(event.tickers, emit);
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<WatchlistPricesState> emit,
  ) async {
    if (_currentTickers.isEmpty) return;
    await _watchPrices(_currentTickers, emit);
  }

  Future<void> _watchPrices(
    List<String> tickers,
    Emitter<WatchlistPricesState> emit,
  ) async {
    if (!_configService.showWatchlistPrice) {
      emit(const WatchlistPricesState.disabled());
      return;
    }

    _logger.info('Watching stock prices for ${tickers.length} tickers');
    if (!_hasLoadedPrices) emit(const WatchlistPricesState.loading());

    await emit.forEach<Either<Failure, List<WatchlistStockPrice>>>(
      _watchWatchlistPrices(tickers),
      onData: (result) => result.fold(
        _stateForFailure,
        (prices) => WatchlistPricesState.loaded(_toPriceMap(prices)),
      ),
      onError: (error, stack) {
        _logger.severe('Watchlist prices stream error', error, stack);
        return _stateForFailure(Failure.server(error.toString()));
      },
    );
  }

  WatchlistPricesState _stateForFailure(Failure failure) {
    _logger.warning('Failed to load stock prices: ${failure.errorMessage}');
    return _hasLoadedPrices ? state : WatchlistPricesState.failure(failure);
  }

  void _onReset(Reset event, Emitter<WatchlistPricesState> emit) {
    _currentTickers = const [];
    _lastRequestedTickers = null;
    emit(const WatchlistPricesState.initial());
  }

  Map<String, WatchlistStockPrice> _toPriceMap(
    List<WatchlistStockPrice> prices,
  ) {
    return {for (final price in prices) price.ticker: price};
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    await _watchlistSubscription?.cancel();
    return super.close();
  }
}
