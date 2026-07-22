import 'dart:async';

import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/domain/usecases/get_watchlist_prices_usecase.dart';
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
  final GetWatchlistPricesUseCase _getWatchlistPrices;
  final GetWatchlistUseCase _getWatchlist;
  final IConfigService _configService;

  StreamSubscription<UserModel?>? _authSubscription;
  StreamSubscription<Either<Failure, List<Company>>>? _watchlistSubscription;
  String? _currentUid;
  List<String> _currentTickers = const [];

  WatchlistPricesBloc(
    this._getWatchlistPrices,
    this._getWatchlist,
    this._configService,
    GetAuthStream getAuthStream,
  ) : super(const WatchlistPricesState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: _distinctRestartable());
    on<RefreshRequested>(_onRefreshRequested, transformer: restartable());
    on<Reset>(_onReset);
    resetOnSessionEnd(getAuthStream, const WatchlistPricesEvent.reset());
    _authSubscription = getAuthStream().listen(_onAuthChanged);
  }

  static EventTransformer<LoadRequested> _distinctRestartable() {
    return (events, mapper) => restartable<LoadRequested>()(
      events.distinct(
        (previous, next) => const SetEquality<String>().equals(
          previous.tickers.toSet(),
          next.tickers.toSet(),
        ),
      ),
      mapper,
    );
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
    await _loadPrices(event.tickers, emit);
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<WatchlistPricesState> emit,
  ) async {
    await _loadPrices(_currentTickers, emit);
  }

  Future<void> _loadPrices(
    List<String> tickers,
    Emitter<WatchlistPricesState> emit,
  ) async {
    if (!_configService.showWatchlistPrice) {
      emit(const WatchlistPricesState.disabled());
      return;
    }

    _logger.info('Loading stock prices for ${tickers.length} tickers');
    if (!_hasLoadedPrices) emit(const WatchlistPricesState.loading());

    final result = await _getWatchlistPrices(tickers);

    if (_tickersAreStale(tickers)) return;

    result.fold(
      (failure) => _emitLoadFailure(failure, emit),
      (prices) => emit(WatchlistPricesState.loaded(_toPriceMap(prices))),
    );
  }

  bool _tickersAreStale(List<String> loadedTickers) =>
      !const SetEquality<String>().equals(
        loadedTickers.toSet(),
        _currentTickers.toSet(),
      );

  void _emitLoadFailure(
    Failure failure,
    Emitter<WatchlistPricesState> emit,
  ) {
    _logger.warning('Failed to load stock prices: ${failure.errorMessage}');
    if (!_hasLoadedPrices) emit(WatchlistPricesState.failure(failure));
  }

  void _onReset(Reset event, Emitter<WatchlistPricesState> emit) {
    _currentTickers = const [];
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
