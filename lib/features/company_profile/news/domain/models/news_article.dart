import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_article.freezed.dart';

@freezed
abstract class NewsArticle with _$NewsArticle {
  const factory NewsArticle({
    required String title,
    required String publishedDate,
    required String site,
    required String url,
    String? image,
    String? text,
  }) = _NewsArticle;
}
