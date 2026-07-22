import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:dartz/dartz.dart';

abstract class IMarketNewsRepository {
  Stream<Either<Failure, List<MarketNewsArticle>>> watchMarketNews();
}
