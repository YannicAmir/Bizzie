import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/segments/presentation/analytics/segments_tab_analytics.dart';
import 'package:bizzie/features/company_profile/segments/presentation/analytics/segments_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

const tTicker = 'AAPL';
const tTimestamp = '2026-01-01T00:00:00Z';

void main() {
  late SegmentsTabAnalytics analytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = SegmentsTabAnalytics(mockAnalyticsService);
  });

  group('SegmentsTabAnalytics - logViewSummary', () {
    test('logViewSummary_validState_logsCorrectParameters', () async {
      // arrange
      const state = SegmentsTabViewState(
        ticker: tTicker,
        timestamp: tTimestamp,
        loadTimeMs: 450,
        isSuccess: true,
        dataSource: CompanyProfileDataOrigin.api,
        viewDurationSec: 30,
        viewedYearlySegTab: true,
        viewedQtrlySegTab: false,
        changedYrDate: true,
        changedQtrDate: false,
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
          name: 'segments_tab_view_summary',
          parameters: {
            'screen_name': 'segments_tab',
            'ticker': tTicker,
            'timestamp': tTimestamp,
            'load_time_ms': 450,
            'is_success': true,
            'data_source': 'api',
            'view_duration_sec': 30,
            'viewed_yearly_seg_tab': true,
            'viewed_qtrly_seg_tab': false,
            'changed_yr_date': true,
            'changed_qtr_date': false,
            'is_final': true,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_partialState_logsWithDefaults', () async {
      // arrange
      const state = SegmentsTabViewState(ticker: tTicker, timestamp: tTimestamp);

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
          name: 'segments_tab_view_summary',
          parameters: {
            'screen_name': 'segments_tab',
            'ticker': tTicker,
            'timestamp': tTimestamp,
            'load_time_ms': 0,
            'is_success': false,
            'data_source': 'unknown',
            'view_duration_sec': 0,
            'viewed_yearly_seg_tab': false,
            'viewed_qtrly_seg_tab': false,
            'changed_yr_date': false,
            'changed_qtr_date': false,
            'is_final': false,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_serviceThrows_handlesGracefully', () async {
      // arrange
      const state = SegmentsTabViewState(ticker: tTicker, timestamp: tTimestamp);

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
