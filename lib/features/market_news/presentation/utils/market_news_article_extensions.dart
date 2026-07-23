import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';

extension MarketNewsArticlePresentationX on MarketNewsArticle {
  String get timeAgo => BizzieDateFormatter.formatTimeAgo(publishedAt);
}

extension MarketNewsArticleListPresentationX on List<MarketNewsArticle> {
  List<MarketNewsArticle> get sortedByRecency => [...this]..sort((a, b) {
    final dateComparison = b.publishedAt.compareTo(a.publishedAt);
    if (dateComparison != 0) return dateComparison;
    return a.id.compareTo(b.id);
  });
}
