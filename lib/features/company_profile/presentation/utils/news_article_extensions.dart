import 'package:bizzie/features/company_profile/domain/models/news_article.dart';
import 'package:timeago/timeago.dart' as timeago;

extension NewsArticlePresentationX on NewsArticle {
  String get timeAgo {
    var published = DateTime.tryParse(publishedDate);
    if (published != null && published.isAfter(DateTime.now())) {
      published = DateTime.now();
    }
    return published != null ? timeago.format(published) : '';
  }
}
