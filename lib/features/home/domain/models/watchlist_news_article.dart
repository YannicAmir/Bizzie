import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_news_article.freezed.dart';

@freezed
abstract class WatchlistNewsArticle with _$WatchlistNewsArticle {
  const factory WatchlistNewsArticle({
    required String id,
    required String symbol,
    required String title,
    required String site,
    required String url,
    required DateTime publishedAt,
    String? image,
  }) = _WatchlistNewsArticle;
}
