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

  WatchlistNewsBloc(this._watchWatchlistNews, GetAuthStream getAuthStream)
    : super(const WatchlistNewsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: _distinctRestartable());
    on<Reset>((_, emit) => emit(const WatchlistNewsState.initial()));
    resetOnSessionEnd(getAuthStream, const WatchlistNewsEvent.reset());
  }

  /// Drops consecutive [LoadRequested] events carrying the same ticker set so
  /// an unchanged watchlist does not cancel and resubscribe the live stream.
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
