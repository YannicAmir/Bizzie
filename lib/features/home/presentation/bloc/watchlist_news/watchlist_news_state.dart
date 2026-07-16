part of 'watchlist_news_bloc.dart';

@freezed
abstract class WatchlistNewsState with _$WatchlistNewsState {
  const factory WatchlistNewsState.initial() = _Initial;
  const factory WatchlistNewsState.loading() = _Loading;
  const factory WatchlistNewsState.loaded(
    List<WatchlistNewsArticle> articles,
  ) = WatchlistNewsLoaded;
  const factory WatchlistNewsState.failure(Failure failure) = _Failure;
}
