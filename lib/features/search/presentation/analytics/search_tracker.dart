import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SearchTracker {
  final IAnalyticsService _analytics;
  SearchTracker(this._analytics);

  /// Logs when the search page is viewed, identifying the source.
  Future<void> logPageView({required SearchSource source}) async {
    await _logEvent('search_page_viewed', {'source': source.analyticsValue});
  }

  /// Logs when a user clicks on a search result, identifying the query and if it was an AI match.
  Future<void> logResultClicked({
    required String query,
    required String ticker,
    required bool isAiResult,
    String? companyName,
  }) async {
    await _logEvent('search_result_clicked', {
      'query': query,
      'ticker': ticker,
      'is_ai_result': isAiResult,
      if (companyName != null) 'company_name': companyName,
    });
  }

  Future<void> logAiSearchOutcome({
    required String query,
    required SearchOutcome outcome,
    String? matchTicker,
  }) async {
    await _logEvent('ai_search_outcome', {
      'query': query,
      'outcome': outcome.analyticsValue,
      if (matchTicker != null) 'match_ticker': matchTicker,
    });
  }

  /// Logs when a recommended brand tile is clicked on the initial search view.
  Future<void> logRecommendedClicked({
    required String query,
    required String ticker,
  }) async {
    await _logEvent('recom_brand_clicked', {'query': query, 'ticker': ticker});
  }

  /// Logs when the user clears the search query or results.
  Future<void> logSearchCleared() async {
    await _logEvent('search_cleared', {});
  }

  /// Logs when the search page is cancelled/closed.
  Future<void> logSearchCancelled() async {
    await _logEvent('search_cancelled', {});
  }

  /// Updates the 'last_search_query' user property for behavioral analysis.
  Future<void> setLastSearchQuery(String query) async {
    await _analytics.setUserProperty(name: 'last_search_query', value: query);
  }

  /// Updates the 'search_total_count' user property to track lifetime search engagement.
  Future<void> setTotalSearchCount(int count) async {
    await _analytics.setUserProperty(
      name: 'search_total_count',
      value: count.toString(),
    );
  }

  /// Internal helper to ensure all events have a timestamp and screen_name
  Future<void> _logEvent(String name, Map<String, dynamic> parameters) async {
    await _analytics.logEvent(
      name: name,
      parameters: {
        'timestamp': DateTime.now().toIso8601String(),
        'screen_name': 'search_page',
        ...parameters,
      },
    );
  }
}
