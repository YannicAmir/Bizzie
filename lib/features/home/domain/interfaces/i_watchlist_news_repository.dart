import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:dartz/dartz.dart';

abstract class IWatchlistNewsRepository {
  Stream<Either<Failure, List<WatchlistNewsArticle>>> watchWatchlistNews(
    List<String> tickers,
  );
}
