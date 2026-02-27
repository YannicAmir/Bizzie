import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/news/presentation/analytics/news_tab_analytics.dart';
import 'package:bizzie/features/company_profile/news/presentation/analytics/news_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late NewsTabAnalytics analytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = NewsTabAnalytics(mockAnalyticsService);

    registerFallbackValue(const NewsTabViewState(ticker: '', timestamp: ''));

    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
  });

  group('NewsTabAnalytics', () {
    test('logViewSummary_success_logsCorrectEventAndParameters', () async {
      // arrange
      final state = NewsTabViewState(
        ticker: 'AAPL',
        timestamp: '2023-01-01T00:00:00Z',
        loadTimeMs: 120,
        isSuccess: true,
        dataSource: CompanyProfileDataOrigin.api,
        viewDurationSec: 60,
        featuredArticleTapped: true,
        normalArticleTapped: false,
        refreshTriggeredCount: 1,
      );

      // act
      await analytics.logViewSummary(state, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'news_tab_view_summary',
          parameters: {
            'screen_name': 'news_tab',
            'ticker': 'AAPL',
            'timestamp': '2023-01-01T00:00:00Z',
            'load_time_ms': 120,
            'is_success': true,
            'data_source': 'api',
            'view_duration_sec': 60,
            'featured_article_tapped': true,
            'normal_article_tapped': false,
            'refresh_triggered_count': 1,
            'is_final': true,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_longTickerAndDataSource_truncatesValues', () async {
      // arrange
      const longTicker = 'VERY_LONG_TICKER_NAME_THAT_EXCEEDS_24';
      final state = NewsTabViewState(
        ticker: longTicker,
        timestamp: '2023-01-01T00:00:00Z',
        dataSource: CompanyProfileDataOrigin.api,
      );

      // act
      await analytics.logViewSummary(state, isFinal: false);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(
            that: containsPair('ticker', longTicker.substring(0, 24)),
            named: 'parameters',
          ),
        ),
      ).called(1);
    });

    test('logViewSummary_serviceThrowsException_catchesGracefully', () async {
      // arrange
      const state = NewsTabViewState(
        ticker: 'AAPL',
        timestamp: '2023-01-01T00:00:00Z',
      );

      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenThrow(Exception('Analytics failure'));

      // act & assert
      await expectLater(
        analytics.logViewSummary(state, isFinal: true),
        completes,
      );
    });

    test('logViewSummary_nullLoadTime_logsZero', () async {
      // arrange
      const state = NewsTabViewState(
        ticker: 'AAPL',
        timestamp: '2023-01-01T00:00:00Z',
        loadTimeMs: null,
      );

      // act
      await analytics.logViewSummary(state, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(
            that: containsPair('load_time_ms', 0),
            named: 'parameters',
          ),
        ),
      ).called(1);
    });
  });
}
