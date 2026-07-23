import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';

extension WatchlistNewsArticlePresentationX on WatchlistNewsArticle {
  String get timeAgo => BizzieDateFormatter.formatTimeAgo(publishedAt);
}

extension WatchlistNewsArticleListPresentationX on List<WatchlistNewsArticle> {
  List<String> get uniqueTickers =>
      map((article) => article.symbol).toSet().toList();

  List<WatchlistNewsArticle> get sortedBySymbolThenRecency => [...this]..sort((
    a,
    b,
  ) {
    final symbolComparison = a.symbol.compareTo(b.symbol);
    if (symbolComparison != 0) return symbolComparison;
    final dateComparison = b.publishedAt.compareTo(a.publishedAt);
    if (dateComparison != 0) return dateComparison;
    return a.id.compareTo(b.id);
  });
}
