import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/analytics/dividend_tab_analytics.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/analytics/dividend_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late DividendTabAnalytics analytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = DividendTabAnalytics(mockAnalyticsService);
  });

  const tTicker = 'AAPL';
  const tTimestamp = '2024-01-01T00:00:00Z';

  group('DividendTabAnalytics - logViewSummary', () {
    test(
      'logViewSummary_validState_callsAnalyticsServiceWithCorrectParams',
      () async {
        // arrange
        const state = DividendTabViewState(
          ticker: tTicker,
          timestamp: tTimestamp,
          loadTimeMs: 150,
          isSuccess: true,
          dataSource: CompanyProfileDataOrigin.api,
          viewDurationSec: 10,
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
            name: 'dividend_tab_view_summary',
            parameters: {
              'screen_name': 'dividends_tab',
              'ticker': tTicker,
              'timestamp': tTimestamp,
              'load_time_ms': 150,
              'is_success': true,
              'data_source': 'api',
              'view_duration_sec': 10,
              'tapped_chart_view_all': true,
              'tapped_table_view_all': false,
              'is_final': true,
            },
          ),
        ).called(1);
      },
    );

    test('logViewSummary_nullMetrics_usesDefaultValues', () async {
      // arrange
      const state = DividendTabViewState(
        ticker: tTicker,
        timestamp: tTimestamp,
        loadTimeMs: null,
        dataSource: null,
        isSuccess: false,
      );

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
          name: 'dividend_tab_view_summary',
          parameters: any(
            named: 'parameters',
            that: allOf([
              containsPair('load_time_ms', 0),
              containsPair('data_source', 'unknown'),
            ]),
          ),
        ),
      ).called(1);
    });

    test('logViewSummary_longStrings_appliesTruncation', () async {
      // arrange
      final longTicker = 'A' * 100;
      final state = DividendTabViewState(
        ticker: longTicker,
        timestamp: tTimestamp,
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
      final captured =
          verify(
                () => mockAnalyticsService.logEvent(
                  name: any(named: 'name'),
                  parameters: captureAny(named: 'parameters'),
                ),
              ).captured.first
              as Map<String, dynamic>;

      final processedTicker = captured['ticker'] as String;
      expect(processedTicker.length, lessThanOrEqualTo(40));
      expect(longTicker.startsWith(processedTicker), true);
    });

    test('logViewSummary_serviceThrows_catchesAndLogsError', () async {
      // arrange
      const state = DividendTabViewState(
        ticker: tTicker,
        timestamp: tTimestamp,
      );

      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenThrow(Exception('Analytics failure'));

      // act & assert
      // Should not throw
      await expectLater(
        () => analytics.logViewSummary(state, isFinal: true),
        returnsNormally,
      );

      verify(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).called(1);
    });
  });
}
