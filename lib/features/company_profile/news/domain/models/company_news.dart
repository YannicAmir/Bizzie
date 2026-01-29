import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_news.freezed.dart';

@freezed
abstract class CompanyNews with _$CompanyNews {
  const factory CompanyNews({
    required String symbol,
    required List<NewsArticle> articles,
  }) = _CompanyNews;
}
