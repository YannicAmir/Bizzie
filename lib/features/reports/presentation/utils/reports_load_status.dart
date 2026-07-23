import 'package:bizzie/features/market_news/presentation/bloc/market_news/market_news_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_state.dart';

enum ReportsLoadStatus { loading, failure, ready }

ReportsLoadStatus resolveReportsLoadStatus(
  ReportsState reports,
  MarketNewsState marketNews,
  WatchlistYtdState ytd,
) {
  final reportsStatus = reports.map(
    initial: (_) => ReportsLoadStatus.loading,
    loading: (_) => ReportsLoadStatus.loading,
    loaded: (_) => ReportsLoadStatus.ready,
    failure: (_) => ReportsLoadStatus.failure,
  );

  if (reportsStatus != ReportsLoadStatus.ready) return reportsStatus;

  return _secondaryFeedsSettled(marketNews, ytd)
      ? ReportsLoadStatus.ready
      : ReportsLoadStatus.loading;
}

bool _secondaryFeedsSettled(
  MarketNewsState marketNews,
  WatchlistYtdState ytd,
) {
  final marketNewsSettled = marketNews.maybeMap(
    loaded: (_) => true,
    failure: (_) => true,
    orElse: () => false,
  );
  final ytdSettled = ytd.maybeMap(
    loaded: (_) => true,
    failure: (_) => true,
    orElse: () => false,
  );
  return marketNewsSettled && ytdSettled;
}
