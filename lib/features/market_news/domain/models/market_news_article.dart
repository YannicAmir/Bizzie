import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_news_article.freezed.dart';

@freezed
abstract class MarketNewsArticle with _$MarketNewsArticle {
  const factory MarketNewsArticle({
    required String id,
    required String title,
    required String site,
    required String publisher,
    required String url,
    required DateTime publishedAt,
    String? image,
  }) = _MarketNewsArticle;
}
