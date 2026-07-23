import 'package:bizzie/features/watchlist_ytd/data/dtos/ytd_price_change_dto.dart';

abstract class IWatchlistYtdRemoteDataSource {
  Future<List<YtdPriceChangeDto>> getWatchlistYtd(List<String> tickers);
}
