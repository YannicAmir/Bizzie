import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/analytics/free_cash_flow_tab_analytics.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/analytics/free_cash_flow_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late FreeCashFlowTabAnalytics analytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = FreeCashFlowTabAnalytics(mockAnalyticsService);
  });

  group('FreeCashFlowTabAnalytics', () {
    test(
      'logViewSummary_fullStateAndIsFinalTrue_logsCorrectEventAndParameters',
      () async {
        // arrange
        const state = FreeCashFlowTabViewState(
          ticker: 'AAPL',
          timestamp: '2023-10-27T10:00:00Z',
          loadTimeMs: 150,
          isSuccess: true,
          dataSource: CompanyProfileDataOrigin.api,
          viewDurationSec: 42,
          viewedYearlyFcfTab: true,
          viewedQtrlyFcfTab: false,
          tappedQtrchartViewAll: false,
          tappedYrchartViewAll: true,
          tappedQtrtableViewAll: false,
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
            name: 'fcf_tab_view_summary',
            parameters: {
              'screen_name': 'free_cash_flow_tab',
              'ticker': 'AAPL',
              'timestamp': '2023-10-27T10:00:00Z',
              'load_time_ms': 150,
              'is_success': true,
              'data_source': 'api',
              'view_duration_sec': 42,
              'viewed_yearly_fcf_tab': true,
              'viewed_qtrly_fcf_tab': false,
              'tapped_qtrchart_view_all': false,
              'tapped_yrchart_view_all': true,
              'tapped_qtrtable_view_all': false,
              'tapped_yrtable_view_all': false,
              'is_final': true,
            },
          ),
        ).called(1);
      },
    );

    test(
      'logViewSummary_partialStateAndIsFinalFalse_logsCorrectEventAndParameters',
      () async {
        // arrange
        const state = FreeCashFlowTabViewState(
          ticker: 'AAPL',
          timestamp: '2023-10-27T10:00:00Z',
          loadTimeMs: 150,
          isSuccess: true,
          dataSource: CompanyProfileDataOrigin.api,
          viewDurationSec: 42,
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
            name: 'fcf_tab_view_summary',
            parameters: {
              'screen_name': 'free_cash_flow_tab',
              'ticker': 'AAPL',
              'timestamp': '2023-10-27T10:00:00Z',
              'load_time_ms': 150,
              'is_success': true,
              'data_source': 'api',
              'view_duration_sec': 42,
              'viewed_yearly_fcf_tab': false,
              'viewed_qtrly_fcf_tab': false,
              'tapped_qtrchart_view_all': false,
              'tapped_yrchart_view_all': false,
              'tapped_qtrtable_view_all': false,
              'tapped_yrtable_view_all': false,
              'is_final': false,
            },
          ),
        ).called(1);
      },
    );

    test('logViewSummary_minimalState_handlesNullsSafely', () async {
      // arrange
      const state = FreeCashFlowTabViewState(
        ticker: 'AAPL',
        timestamp: '2023-10-27T10:00:00Z',
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
          name: 'fcf_tab_view_summary',
          parameters: {
            'screen_name': 'free_cash_flow_tab',
            'ticker': 'AAPL',
            'timestamp': '2023-10-27T10:00:00Z',
            'load_time_ms': 0,
            'is_success': false,
            'data_source': 'unknown',
            'view_duration_sec': 0,
            'viewed_yearly_fcf_tab': false,
            'viewed_qtrly_fcf_tab': false,
            'tapped_qtrchart_view_all': false,
            'tapped_yrchart_view_all': false,
            'tapped_qtrtable_view_all': false,
            'tapped_yrtable_view_all': false,
            'is_final': false,
          },
        ),
      ).called(1);
    });
  });
}
