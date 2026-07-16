import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';

extension NewsArticlePresentationX on NewsArticle {
  String get timeAgo {
    final published = DateTime.tryParse(publishedDate);
    return published != null
        ? BizzieDateFormatter.formatTimeAgo(published)
        : '';
  }
}
