import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:bizzie/features/home/domain/usecases/watch_watchlist_news_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'watchlist_news_event.dart';
part 'watchlist_news_state.dart';
part 'watchlist_news_bloc.freezed.dart';

final _logger = BizzieLogger('WatchlistNewsBloc');

@injectable
class WatchlistNewsBloc extends Bloc<WatchlistNewsEvent, WatchlistNewsState>
    with AuthSessionResetMixin<WatchlistNewsEvent, WatchlistNewsState> {
  final WatchWatchlistNewsUseCase _watchWatchlistNews;

  Set<String>? _lastRequestedTickers;

  WatchlistNewsBloc(this._watchWatchlistNews, GetAuthStream getAuthStream)
    : super(const WatchlistNewsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: _distinctRestartable());
    on<Reset>(_onReset);
    resetOnSessionEnd(getAuthStream, const WatchlistNewsEvent.reset());
  }

  EventTransformer<LoadRequested> _distinctRestartable() {
    return (events, mapper) =>
        restartable<LoadRequested>()(events.where(_isNewTickerSet), mapper);
  }

  bool _isNewTickerSet(LoadRequested event) {
    final tickers = event.tickers.toSet();
    if (_lastRequestedTickers != null &&
        const SetEquality<String>().equals(_lastRequestedTickers!, tickers)) {
      return false;
    }
    _lastRequestedTickers = tickers;
    return true;
  }

  void _onReset(Reset event, Emitter<WatchlistNewsState> emit) {
    _lastRequestedTickers = null;
    emit(const WatchlistNewsState.initial());
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<WatchlistNewsState> emit,
  ) async {
    _logger.info('Loading watchlist news for ${event.tickers.length} tickers');
    emit(const WatchlistNewsState.loading());

    await emit.forEach<Either<Failure, List<WatchlistNewsArticle>>>(
      _watchWatchlistNews(event.tickers),
      onData: (result) => result.fold(
        (failure) => WatchlistNewsState.failure(failure),
        (articles) => WatchlistNewsState.loaded(articles),
      ),
      onError: (error, stack) {
        _logger.severe('Watchlist news stream error', error, stack);
        return WatchlistNewsState.failure(Failure.server('Stream Error'));
      },
    );
  }
}
