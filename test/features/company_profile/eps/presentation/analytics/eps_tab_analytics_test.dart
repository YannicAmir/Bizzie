import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/eps/presentation/analytics/eps_tab_analytics.dart';
import 'package:bizzie/features/company_profile/eps/presentation/analytics/eps_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late EpsTabAnalytics analytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = EpsTabAnalytics(mockAnalyticsService);
  });

  const tTicker = 'AAPL';
  const tTimestamp = '2024-01-01T00:00:00Z';

  group('EpsTabAnalytics - logViewSummary', () {
    test('logViewSummary_validState_logsCorrectParameters', () async {
      // arrange
      final state = EpsTabViewState(
        ticker: tTicker,
        timestamp: tTimestamp,
        loadTimeMs: 450,
        isSuccess: true,
        dataSource: CompanyProfileDataOrigin.api,
        viewDurationSec: 30,
        viewedYearlyEpsTab: true,
        viewedQtrlyEpsTab: false,
        tappedQtrchartViewAll: true,
        tappedYrchartViewAll: false,
        tappedQtrtableViewAll: true,
        tappedYrtableViewAll: false,
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
          name: 'eps_tab_view_summary',
          parameters: {
            'screen_name': 'eps_tab',
            'ticker': tTicker,
            'timestamp': tTimestamp,
            'load_time_ms': 450,
            'is_success': true,
            'data_source': 'api',
            'view_duration_sec': 30,
            'viewed_yearly_eps_tab': true,
            'viewed_qtrly_eps_tab': false,
            'tapped_qtrchart_view_all': true,
            'tapped_yrchart_view_all': false,
            'tapped_qtrtable_view_all': true,
            'tapped_yrtable_view_all': false,
            'is_final': true,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_partialState_logsWithDefaults', () async {
      // arrange
      const state = EpsTabViewState(ticker: tTicker, timestamp: tTimestamp);

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
          name: 'eps_tab_view_summary',
          parameters: {
            'screen_name': 'eps_tab',
            'ticker': tTicker,
            'timestamp': tTimestamp,
            'load_time_ms': 0,
            'is_success': false,
            'data_source': 'unknown',
            'view_duration_sec': 0,
            'viewed_yearly_eps_tab': false,
            'viewed_qtrly_eps_tab': false,
            'tapped_qtrchart_view_all': false,
            'tapped_yrchart_view_all': false,
            'tapped_qtrtable_view_all': false,
            'tapped_yrtable_view_all': false,
            'is_final': false,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_serviceThrows_handlesGracefully', () async {
      // arrange
      const state = EpsTabViewState(ticker: tTicker, timestamp: tTimestamp);

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
