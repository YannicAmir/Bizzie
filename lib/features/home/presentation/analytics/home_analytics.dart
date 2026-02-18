import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeAnalytics {
  final IAnalyticsService _analytics;

  HomeAnalytics(this._analytics);

  static const String _screenName = 'home';

  Future<void> logHomeViewed() async {
    await _analytics.logEvent(
      name: 'home_viewed',
      parameters: {'screen_name': _screenName},
    );
  }

  Future<void> logHomeSearchTapped() async {
    await _analytics.logEvent(
      name: 'home_search_tapped',
      parameters: {'screen_name': _screenName},
    );
  }

  Future<void> logHomeWatchlistTapped({required String ticker}) async {
    await _analytics.logEvent(
      name: 'home_watchlist_tapped',
      parameters: {'screen_name': _screenName, 'ticker': ticker},
    );
  }

  Future<void> logHomeEmptyStateViewed() async {
    await _analytics.logEvent(
      name: 'home_empty_state_viewed',
      parameters: {'screen_name': _screenName},
    );
  }

  Future<void> logHomeWatchlistError({required String message}) async {
    await _analytics.logEvent(
      name: 'home_watchlist_load_error',
      parameters: {'screen_name': _screenName, 'error_message': message},
    );
  }

  Future<void> logHomeWatchlistLoaded({
    required int itemCount,
    required int durationMs,
  }) async {
    await _analytics.logEvent(
      name: 'home_watchlist_load_success',
      parameters: {
        'screen_name': _screenName,
        'item_count': itemCount,
        'duration_ms': durationMs,
      },
    );
  }
}
