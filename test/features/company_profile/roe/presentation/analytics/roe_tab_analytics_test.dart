import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/roe/presentation/analytics/roe_tab_analytics.dart';
import 'package:bizzie/features/company_profile/roe/presentation/analytics/roe_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late RoeTabAnalytics analytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = RoeTabAnalytics(mockAnalyticsService);
  });

  const tTicker = 'AAPL';
  const tTimestamp = '2024-01-01T00:00:00Z';

  group('RoeTabAnalytics - logViewSummary', () {
    test('logViewSummary_validState_logsCorrectParameters', () async {
      // arrange
      final state = RoeTabViewState(
        ticker: tTicker,
        timestamp: tTimestamp,
        loadTimeMs: 450,
        isSuccess: true,
        dataSource: CompanyProfileDataOrigin.api,
        viewDurationSec: 30,
        tappedChartViewAll: true,
        tappedTableViewAll: false,
      );

      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});

      // act
      await analytics.logViewSummary(state, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'roe_tab_view_summary',
          parameters: {
            'screen_name': 'roe_tab',
            'ticker': tTicker,
            'timestamp': tTimestamp,
            'load_time_ms': 450,
            'is_success': true,
            'data_source': 'api',
            'view_duration_sec': 30,
            'tapped_chart_view_all': true,
            'tapped_table_view_all': false,
            'is_final': true,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_partialState_logsWithDefaults', () async {
      // arrange
      const state = RoeTabViewState(ticker: tTicker, timestamp: tTimestamp);

      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});

      // act
      await analytics.logViewSummary(state, isFinal: false);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'roe_tab_view_summary',
          parameters: {
            'screen_name': 'roe_tab',
            'ticker': tTicker,
            'timestamp': tTimestamp,
            'load_time_ms': 0,
            'is_success': false,
            'data_source': 'unknown',
            'view_duration_sec': 0,
            'tapped_chart_view_all': false,
            'tapped_table_view_all': false,
            'is_final': false,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_longStrings_truncatesParameters', () async {
      // arrange
      const longTicker = 'VERY_LONG_TICKER_THAT_EXCEEDS_LIMIT';
      const state = RoeTabViewState(
        ticker: longTicker,
        timestamp: tTimestamp,
        dataSource: CompanyProfileDataOrigin.api,
      );

      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});

      // act
      await analytics.logViewSummary(state, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(
            named: 'parameters',
            that: containsPair('ticker', matches(r'.{1,32}')),
          ),
        ),
      ).called(1);
    });

    test('logViewSummary_serviceThrows_handlesGracefully', () async {
      // arrange
      const state = RoeTabViewState(ticker: tTicker, timestamp: tTimestamp);

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
  });
}
