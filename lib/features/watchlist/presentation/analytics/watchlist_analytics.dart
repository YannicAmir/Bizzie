import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchlistAnalytics {
  final IAnalyticsService _analytics;
  final _logger = BizzieLogger('WatchlistAnalytics');

  // Screen Names
  static const _kScreenName = 'company_profile';

  // Events
  static const _kEventItemAdded = 'watchlist_item_added';
  static const _kEventItemRemoved = 'watchlist_item_removed';
  static const _kEventOperationFailed = 'watchlist_operation_failed';

  // Parameters
  static const _kParamTicker = 'ticker';
  static const _kParamCompanyName = 'company_name';
  static const _kParamSource = 'source';
  static const _kParamTabName = 'tab_name';
  static const _kParamDuration = 'duration_on_page_seconds';
  static const _kParamOperation = 'operation';
  static const _kParamErrorMessage = 'error_message';
  static const _kParamItemCount = 'watchlist_item_count';

  // Metadata
  static const _kParamScreenName = 'screen_name';
  static const _kParamTimestamp = 'timestamp';

  WatchlistAnalytics(this._analytics);

  Future<void> _logEvent(String name, [Map<String, dynamic>? params]) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: {
          ...?params,
          _kParamScreenName: _kScreenName,
          _kParamTimestamp: DateTime.now().toIso8601String(),
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log event: $name', e, stack);
    }
  }

  Future<void> setWatchlistItemCount(int count) async {
    try {
      await _analytics.setUserProperty(
        name: _kParamItemCount,
        value: count.toString(),
      );
    } catch (e, stack) {
      _logger.severe('Failed to set watchlist_item_count', e, stack);
    }
  }

  Future<void> logItemAdded({
    required String ticker,
    required String companyName,
    required String tabName,
    required int durationOnPageSeconds,
    String source = 'company_profile',
  }) async {
    await _logEvent(_kEventItemAdded, {
      _kParamTicker: ticker,
      _kParamCompanyName: companyName,
      _kParamTabName: tabName,
      _kParamDuration: durationOnPageSeconds,
      _kParamSource: source,
    });
  }

  Future<void> logItemRemoved({
    required String ticker,
    required String tabName,
    required int durationOnPageSeconds,
  }) async {
    await _logEvent(_kEventItemRemoved, {
      _kParamTicker: ticker,
      _kParamTabName: tabName,
      _kParamDuration: durationOnPageSeconds,
    });
  }

  Future<void> logOperationFailed({
    required String operation,
    required String errorMessage,
  }) async {
    await _logEvent(_kEventOperationFailed, {
      _kParamOperation: operation,
      _kParamErrorMessage: errorMessage,
    });
  }
}
