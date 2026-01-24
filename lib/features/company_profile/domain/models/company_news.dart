import 'package:bizzie/features/company_profile/domain/models/news_article.dart';
import 'package:equatable/equatable.dart';

class CompanyNews extends Equatable {
  final String symbol;
  final List<NewsArticle> articles;

  const CompanyNews({required this.symbol, required this.articles});

  @override
  List<Object?> get props => [symbol, articles];
}
