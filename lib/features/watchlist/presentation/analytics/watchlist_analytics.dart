import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchlistAnalytics {
  final IAnalyticsService _analytics;

  WatchlistAnalytics(this._analytics);

  Future<void> setWatchlistItemCount(int count) async {
    await _analytics.setUserProperty(
      name: 'watchlist_item_count',
      value: count.toString(),
    );
  }
}
