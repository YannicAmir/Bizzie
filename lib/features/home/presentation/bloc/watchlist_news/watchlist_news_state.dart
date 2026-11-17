import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_news_state.freezed.dart';

@freezed
abstract class WatchlistNewsState with _$WatchlistNewsState {
  const factory WatchlistNewsState.initial() = _Initial;
  const factory WatchlistNewsState.loading() = _Loading;
  const factory WatchlistNewsState.loaded(List<WatchlistNewsArticle> articles) =
      WatchlistNewsLoaded;
  const factory WatchlistNewsState.failure(Failure failure) = _Failure;
}
