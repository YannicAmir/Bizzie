import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';

extension WatchlistNewsArticlePresentationX on WatchlistNewsArticle {
  String get timeAgo => BizzieDateFormatter.formatTimeAgo(publishedAt);
}
