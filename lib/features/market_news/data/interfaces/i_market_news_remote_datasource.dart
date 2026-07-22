import 'package:bizzie/features/market_news/data/dtos/market_news_dto.dart';

abstract class IMarketNewsRemoteDataSource {
  Stream<List<MarketNewsDto>> getMarketNewsStream();
}
