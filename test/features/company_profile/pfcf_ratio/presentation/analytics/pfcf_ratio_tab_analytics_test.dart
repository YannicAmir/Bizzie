import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/analytics/pfcf_ratio_tab_analytics.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/analytics/pfcf_ratio_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late PfcfRatioTabAnalytics analytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = PfcfRatioTabAnalytics(mockAnalyticsService);
  });

  const tTicker = 'AAPL';
  const tTimestamp = '2023-10-27T10:00:00Z';

  final tState = PfcfRatioTabViewState(
    ticker: tTicker,
    timestamp: tTimestamp,
    loadTimeMs: 150,
    isSuccess: true,
    dataSource: CompanyProfileDataOrigin.api,
    viewDurationSec: 10,
    tappedChartViewAll: true,
    tappedTableViewAll: false,
  );

  group('PfcfRatioTabAnalytics', () {
    test('logViewSummary - logs correct event and parameters', () async {
      // arrange
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});

      // act
      await analytics.logViewSummary(tState, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'pfcf_ratio_tab_view_summary',
          parameters: {
            'screen_name': 'pfcf_ratio_tab',
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
    });

    test(
      'logViewSummary - handles null optional parameters with defaults',
      () async {
        // arrange
        final stateWithNulls = PfcfRatioTabViewState(
          ticker: tTicker,
          timestamp: tTimestamp,
        );
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async {});

        // act
        await analytics.logViewSummary(stateWithNulls, isFinal: false);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'pfcf_ratio_tab_view_summary',
            parameters: {
              'screen_name': 'pfcf_ratio_tab',
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
      },
    );

    test('logViewSummary - truncates long parameters', () async {
      // arrange
      final longTicker = 'VERYLONGTICKERNAME' * 10;
      final stateWithLongTicker = tState.copyWith(ticker: longTicker);
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});

      // act
      await analytics.logViewSummary(stateWithLongTicker, isFinal: true);

      // assert
      final captured =
          verify(
                () => mockAnalyticsService.logEvent(
                  name: any(named: 'name'),
                  parameters: captureAny(named: 'parameters'),
                ),
              ).captured.single
              as Map<String, Object>;

      expect((captured['ticker'] as String).length, lessThanOrEqualTo(40));
    });

    test('logViewSummary - catches and logs exceptions gracefully', () async {
      // arrange
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenThrow(Exception('Analytics error'));

      // act & assert
      await analytics.logViewSummary(tState, isFinal: true);
      verify(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).called(1);
    });
    group('PfcfRatioTabAnalytics - Constructor', () {
      test('is successfully created', () {
        expect(analytics, isNotNull);
      });
    });
  });
}
