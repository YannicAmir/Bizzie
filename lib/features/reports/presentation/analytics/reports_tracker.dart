import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ReportsTracker');

@lazySingleton
class ReportsTracker {
  final IAnalyticsService _analytics;

  ReportsTracker(this._analytics);

  // Screen Names
  static const _kScreenName = 'reports_feed';

  // Events
  static const _kEventFeedViewed = 'reports_feed_viewed';
  static const _kEventLinkOpened = 'filing_link_opened';
  static const _kEventSummaryViewed = 'filing_summary_viewed';
  static const _kEventSummarizeLockedClicked = 'filing_sum_lock_clicked';
  static const _kEventAnalysisPendingViewed = 'filing_pending_viewed';
  static const _kEventUpcomingExpanded = 'upcoming_earn_expanded';
  static const _kEventUpcomingCompanyClicked = 'upcoming_earn_co_clicked';
  static const _kEventYtdCompanyClicked = 'ytd_co_clicked';
  static const _kEventEmptyCtaClicked = 'reports_empty_cta_tap';
  static const _kEventMarketNewsOpened = 'market_news_opened';
  static const _kEventMarketNewsFetchFailed = 'market_news_fetch_failed';
  static const _kEventFetchFailed = 'reports_fetch_failed';
  static const _kEventFilingCardCompanyClicked = 'filing_card_co_clicked';

  // Parameters
  static const _kParamUnreadCount = 'unread_count';
  static const _kParamEntrySource = 'entry_source';
  static const _kParamNotificationType = 'notification_type';
  static const _kParamTicker = 'ticker';
  static const _kParamFilingType = 'filing_type';
  static const _kParamWasPreviouslyPending = 'was_previously_pending';
  static const _kParamPublisher = 'publisher';
  static const _kParamSite = 'site';
  static const _kParamError = 'error';

  // Metadata
  static const _kParamScreenName = 'screen_name';

  // User Properties
  static const _kUserPropLastFilingTicker = 'last_filing_ticker';
  static const _kUserPropReportsTotalViews = 'report_feed_total_views';

  Future<void> _logEvent(String name, [Map<String, Object>? parameters]) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: {
          ...?parameters,
          _kParamScreenName: _kScreenName,
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log event: $name', e, stack);
    }
  }

  Future<void> logFeedViewed({
    required int unreadCount,
    required ReportsEntrySource entrySource,
    ReportsNotificationType? notificationType,
  }) async {
    await _logEvent(_kEventFeedViewed, {
      _kParamUnreadCount: unreadCount,
      _kParamEntrySource: entrySource.name,
      if (notificationType != null)
        _kParamNotificationType: notificationType.name,
    });
  }

  Future<void> logLinkOpened({
    required String ticker,
    required String filingType,
  }) async {
    await _logEvent(_kEventLinkOpened, {
      _kParamTicker: ticker,
      _kParamFilingType: filingType,
    });
  }

  Future<void> logSummaryViewed({
    required String ticker,
    required String filingType,
    required bool wasPreviouslyPending,
  }) async {
    await _logEvent(_kEventSummaryViewed, {
      _kParamTicker: ticker,
      _kParamFilingType: filingType,
      _kParamWasPreviouslyPending: wasPreviouslyPending,
    });
  }

  Future<void> logSummarizeLockedClicked({
    required String ticker,
    required String filingType,
  }) async {
    await _logEvent(_kEventSummarizeLockedClicked, {
      _kParamTicker: ticker,
      _kParamFilingType: filingType,
    });
  }

  Future<void> logAnalysisPendingViewed({
    required String ticker,
    required String filingType,
  }) async {
    await _logEvent(_kEventAnalysisPendingViewed, {
      _kParamTicker: ticker,
      _kParamFilingType: filingType,
    });
  }

  Future<void> logUpcomingExpanded() async {
    await _logEvent(_kEventUpcomingExpanded);
  }

  Future<void> logUpcomingCompanyClicked({required String ticker}) async {
    await _logEvent(_kEventUpcomingCompanyClicked, {_kParamTicker: ticker});
  }

  Future<void> logYtdCompanyClicked({required String ticker}) async {
    await _logEvent(_kEventYtdCompanyClicked, {_kParamTicker: ticker});
  }

  Future<void> logEmptyCtaClicked() async {
    await _logEvent(_kEventEmptyCtaClicked);
  }

  Future<void> logMarketNewsOpened({
    required String publisher,
    required String site,
  }) async {
    await _logEvent(_kEventMarketNewsOpened, {
      _kParamPublisher: publisher,
      _kParamSite: site,
    });
  }

  Future<void> logMarketNewsFetchFailed({required String error}) async {
    await _logEvent(_kEventMarketNewsFetchFailed, {_kParamError: error});
  }

  Future<void> logFetchFailed({required String error}) async {
    await _logEvent(_kEventFetchFailed, {_kParamError: error});
  }

  Future<void> logFilingCardCompanyClicked({required String ticker}) async {
    await _logEvent(_kEventFilingCardCompanyClicked, {_kParamTicker: ticker});
  }

  Future<void> setLastFilingTicker(String ticker) async {
    try {
      await _analytics.setUserProperty(
        name: _kUserPropLastFilingTicker,
        value: ticker,
      );
    } catch (e, stack) {
      _logger.severe('Failed to set $_kUserPropLastFilingTicker', e, stack);
    }
  }

  Future<void> setReportsTotalViewed(int count) async {
    try {
      await _analytics.setUserProperty(
        name: _kUserPropReportsTotalViews,
        value: count.toString(),
      );
    } catch (e, stack) {
      _logger.severe('Failed to set $_kUserPropReportsTotalViews', e, stack);
    }
  }
}
