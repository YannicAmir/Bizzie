import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeAnalytics {
  final IAnalyticsService _analytics;
  final _logger = BizzieLogger('HomeAnalytics');

  // Event Names
  static const _kEventViewed = 'home_viewed';
  static const _kEventWatchlistTapped = 'home_watchlist_tapped';
  static const _kEventEmptyStateViewed = 'home_empty_state_viewed';
  static const _kEventWatchlistError = 'home_watchlist_load_error';
  static const _kEventNewsArticleTapped = 'home_news_article_tapped';
  static const _kEventNewsError = 'home_news_load_error';

  // Parameter Keys
  static const _kParamScreenName = 'screen_name';
  static const _kParamTicker = 'ticker';
  static const _kParamEventText = 'event_text';
  static const _kParamIsUpcoming = 'is_upcoming';
  static const _kParamErrorMessage = 'error_message';
  static const _kParamSite = 'site';

  // Fixed Values
  static const String _screenName = 'home';

  HomeAnalytics(this._analytics);

  Future<void> logHomeViewed() async {
    try {
      await _analytics.logEvent(
        name: _kEventViewed,
        parameters: {_kParamScreenName: _screenName},
      );
    } catch (e, stack) {
      _logger.severe('Failed to log home_viewed', e, stack);
    }
  }

  Future<void> logHomeWatchlistTapped({
    required String ticker,
    String? eventText,
    bool? isUpcoming,
  }) async {
    try {
      await _analytics.logEvent(
        name: _kEventWatchlistTapped,
        parameters: {
          _kParamScreenName: _screenName,
          _kParamTicker: ticker,
          if (eventText != null) _kParamEventText: eventText,
          if (isUpcoming != null) _kParamIsUpcoming: isUpcoming,
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log home_watchlist_tapped', e, stack);
    }
  }

  Future<void> logHomeEmptyStateViewed() async {
    try {
      await _analytics.logEvent(
        name: _kEventEmptyStateViewed,
        parameters: {_kParamScreenName: _screenName},
      );
    } catch (e, stack) {
      _logger.severe('Failed to log home_empty_state_viewed', e, stack);
    }
  }

  Future<void> logHomeNewsArticleTapped({
    required String ticker,
    required String site,
  }) async {
    try {
      await _analytics.logEvent(
        name: _kEventNewsArticleTapped,
        parameters: {
          _kParamScreenName: _screenName,
          _kParamTicker: ticker,
          _kParamSite: site,
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log home_news_article_tapped', e, stack);
    }
  }

  Future<void> logHomeNewsLoadError({required String message}) async {
    try {
      await _analytics.logEvent(
        name: _kEventNewsError,
        parameters: {
          _kParamScreenName: _screenName,
          _kParamErrorMessage: message,
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log home_news_load_error', e, stack);
    }
  }

  Future<void> logHomeWatchlistError({required String message}) async {
    try {
      await _analytics.logEvent(
        name: _kEventWatchlistError,
        parameters: {
          _kParamScreenName: _screenName,
          _kParamErrorMessage: message,
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log home_watchlist_load_error', e, stack);
    }
  }
}
