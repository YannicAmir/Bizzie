import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:bizzie/features/watchlist_ytd/domain/usecases/get_watchlist_ytd_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

import 'watchlist_ytd_event.dart';
import 'watchlist_ytd_state.dart';

final _logger = BizzieLogger('WatchlistYtdBloc');

@injectable
class WatchlistYtdBloc extends Bloc<WatchlistYtdEvent, WatchlistYtdState>
    with AuthSessionResetMixin<WatchlistYtdEvent, WatchlistYtdState> {
  final GetWatchlistYtdUseCase _getWatchlistYtd;

  WatchlistYtdBloc(this._getWatchlistYtd, GetAuthStream getAuthStream)
    : super(const WatchlistYtdState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<Reset>((_, emit) => emit(const WatchlistYtdState.initial()));
    resetOnSessionEnd(getAuthStream, const WatchlistYtdEvent.reset());
  }

  bool get _hasLoadedChanges =>
      state.maybeMap(loaded: (_) => true, orElse: () => false);

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<WatchlistYtdState> emit,
  ) async {
    _logger.info('Loading YTD price change for ${event.tickers.length} tickers');
    if (!_hasLoadedChanges) emit(const WatchlistYtdState.loading());

    final result = await _getWatchlistYtd(event.tickers);

    result.fold(
      (failure) => _emitLoadFailure(failure, emit),
      (changes) => emit(WatchlistYtdState.loaded(_toChangeMap(changes))),
    );
  }

  void _emitLoadFailure(Failure failure, Emitter<WatchlistYtdState> emit) {
    _logger.warning('Failed to load YTD price change: ${failure.errorMessage}');
    if (!_hasLoadedChanges) emit(WatchlistYtdState.failure(failure));
  }

  Map<String, YtdPriceChange> _toChangeMap(List<YtdPriceChange> changes) {
    return {for (final change in changes) change.ticker: change};
  }
}
