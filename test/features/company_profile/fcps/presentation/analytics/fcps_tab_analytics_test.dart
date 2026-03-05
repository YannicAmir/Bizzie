import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/analytics/fcps_tab_analytics.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/analytics/fcps_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late FcpsTabAnalytics analytics;
  late MockAnalyticsService mockService;

  setUp(() {
    mockService = MockAnalyticsService();
    analytics = FcpsTabAnalytics(mockService);
  });

  const tState = FcpsTabViewState(
    ticker: 'AAPL',
    timestamp: '2023-10-27T10:00:00Z',
    loadTimeMs: 150,
    isSuccess: true,
    dataSource: CompanyProfileDataOrigin.api,
    viewDurationSec: 45,
    viewedYearlyFcpsTab: true,
    viewedQtrlyFcpsTab: true,
    tappedQtrchartViewAll: true,
    tappedYrchartViewAll: false,
    tappedQtrtableViewAll: false,
    tappedYrtableViewAll: true,
  );

  group('FcpsTabAnalytics.logViewSummary', () {
    test(
      'logViewSummary_fullStateAndIsFinalTrue_logsCorrectEventAndParameters',
      () async {
        // Arrange
        when(
          () => mockService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await analytics.logViewSummary(tState, isFinal: true);

        // Assert
        verify(
          () => mockService.logEvent(
            name: 'fcps_tab_view_summary',
            parameters: {
              'screen_name': 'fcps_tab',
              'ticker': 'AAPL',
              'timestamp': '2023-10-27T10:00:00Z',
              'load_time_ms': 150,
              'is_success': true,
              'data_source': 'api',
              'view_duration_sec': 45,
              'viewed_yearly_fcps_tab': true,
              'viewed_qtrly_fcps_tab': true,
              'tapped_qtrchart_view_all': true,
              'tapped_yrchart_view_all': false,
              'tapped_qtrtable_view_all': false,
              'tapped_yrtable_view_all': true,
              'is_final': true,
            },
          ),
        ).called(1);
      },
    );

    test(
      'logViewSummary_partialStateAndIsFinalFalse_logsCorrectEventAndParameters',
      () async {
        // Arrange
        const partialState = FcpsTabViewState(
          ticker: 'MSFT',
          timestamp: '2023-10-27T12:00:00Z',
        );
        when(
          () => mockService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async {});

        // Act
        await analytics.logViewSummary(partialState, isFinal: false);

        // Assert
        verify(
          () => mockService.logEvent(
            name: 'fcps_tab_view_summary',
            parameters: {
              'screen_name': 'fcps_tab',
              'ticker': 'MSFT',
              'timestamp': '2023-10-27T12:00:00Z',
              'load_time_ms': 0,
              'is_success': false,
              'data_source': 'unknown',
              'view_duration_sec': 0,
              'viewed_yearly_fcps_tab': false,
              'viewed_qtrly_fcps_tab': false,
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
  });
}
