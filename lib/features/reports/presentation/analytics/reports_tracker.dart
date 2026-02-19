import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ReportsTracker {
  final IAnalyticsService _analytics;

  ReportsTracker(this._analytics);

  static const String _screenName = 'reports_feed';

  Future<void> _logEvent(String name, Map<String, Object> parameters) async {
    await _analytics.logEvent(
      name: name,
      parameters: {...parameters, 'screen_name': _screenName},
    );
  }

  /// Logs when the reports feed is main page is viewed, including attribution data.
  Future<void> logFeedViewed({
    required int unreadCount,
    required ReportsEntrySource entrySource,
    ReportsNotificationType? notificationType,
  }) async {
    await _logEvent('reports_feed_viewed', {
      'unread_count': unreadCount,
      'entry_source': entrySource.name,
      if (notificationType != null) 'notification_type': notificationType.name,
    });
  }

  /// Logs when the user taps the global search bar from the reports tab.
  Future<void> logSearchClicked() async {
    await _logEvent('reports_search_clicked', {});
  }

  /// Logs when the user clicks 'View Full Report' to open an external SEC link.
  Future<void> logLinkOpened({
    required String ticker,
    required String filingType,
  }) async {
    await _logEvent('filing_link_opened', {
      'ticker': ticker,
      'filing_type': filingType,
    });
  }

  /// Logs when an AI summary is successfully displayed to the user.
  Future<void> logSummaryViewed({
    required String ticker,
    required String filingType,
    required bool wasPreviouslyPending,
  }) async {
    await _logEvent('filing_summary_viewed', {
      'ticker': ticker,
      'filing_type': filingType,
      'was_previously_pending': wasPreviouslyPending,
    });
  }

  /// Logs when a non-Pro user clicks 'Summarize' on a locked report.
  Future<void> logSummarizeLockedClicked({
    required String ticker,
    required String filingType,
  }) async {
    await _logEvent('filing_sum_lock_clicked', {
      'ticker': ticker,
      'filing_type': filingType,
    });
  }

  /// Logs when a user views a report that is currently being processed by AI.
  Future<void> logAnalysisPendingViewed({
    required String ticker,
    required String filingType,
  }) async {
    await _logEvent('filing_pending_viewed', {
      'ticker': ticker,
      'filing_type': filingType,
    });
  }

  /// Logs when the 'Upcoming Earnings' section is expanded to show more companies.
  Future<void> logUpcomingExpanded() async {
    await _logEvent('upcoming_earn_expanded', {});
  }

  /// Logs when a company tile in the upcoming earnings section is clicked.
  Future<void> logUpcomingCompanyClicked({required String ticker}) async {
    await _logEvent('upcoming_earn_co_clicked', {'ticker': ticker});
  }

  /// Logs when the 'Search for stocks' button is clicked from an empty feed.
  Future<void> logEmptyCtaClicked() async {
    await _logEvent('reports_empty_cta_tap', {});
  }

  /// Logs operational failures when fetching report data from the backend.
  Future<void> logFetchFailed({required String error}) async {
    await _logEvent('reports_fetch_failed', {'error': error});
  }

  /// Logs when a company name/ticker on a recent filing card is clicked.
  Future<void> logFilingCardCompanyClicked({required String ticker}) async {
    await _logEvent('filing_card_co_clicked', {'ticker': ticker});
  }

  /// Sets the user property for the ticker of the last SEC filing interacted with.
  Future<void> setLastFilingTicker(String ticker) async {
    await _analytics.setUserProperty(name: 'last_filing_ticker', value: ticker);
  }

  /// Sets the user property for the cumulative total of reports feed views.
  Future<void> setReportsTotalViewed(int count) async {
    await _analytics.setUserProperty(
      name: 'report_feed_total_views',
      value: count.toString(),
    );
  }
}
