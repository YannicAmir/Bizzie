abstract class IWatchlistLocalDataSource {
  Future<void> cacheSubscribedTickers(List<String> tickers);
  List<String> getSubscribedTickers();
}
