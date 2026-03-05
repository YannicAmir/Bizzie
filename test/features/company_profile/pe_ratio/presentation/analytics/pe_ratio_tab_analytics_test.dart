import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/analytics/pe_ratio_tab_analytics.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/analytics/pe_ratio_tab_view_state.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late PeRatioTabAnalytics analytics;
  late MockAnalyticsService mockService;

  setUp(() {
    mockService = MockAnalyticsService();
    analytics = PeRatioTabAnalytics(mockService);

    when(
      () => mockService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
  });

  group('PeRatioTabAnalytics', () {
    const tTicker = 'AAPL';
    const tViewState = PeRatioTabViewState(
      ticker: tTicker,
      isSuccess: true,
      loadTimeMs: 150,
      dataSource: CompanyProfileDataOrigin.api,
      tappedChartViewAll: true,
      tappedTableViewAll: false,
      timestamp: '2024-01-01T00:00:00Z',
      viewDurationSec: 30,
    );

    test('logViewSummary_logsCorrectEventWithParameters', () async {
      // Act
      await analytics.logViewSummary(tViewState, isFinal: true);

      // Assert
      verify(
        () => mockService.logEvent(
          name: 'pe_ratio_tab_view_summary',
          parameters: {
            'screen_name': 'pe_ratio_tab',
            'ticker': tTicker,
            'timestamp': '2024-01-01T00:00:00Z',
            'load_time_ms': 150,
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

    test('logViewSummary_truncatesSuperLongTicker', () async {
      // Arrange
      final longTicker = 'A' * 100;
      final state = tViewState.copyWith(ticker: longTicker);

      // Act
      await analytics.logViewSummary(state, isFinal: true);

      // Assert
      verify(
        () => mockService.logEvent(
          name: 'pe_ratio_tab_view_summary',
          parameters: any(
            named: 'parameters',
            that: containsPair('ticker', longTicker.substring(0, 24)),
          ),
        ),
      ).called(1);
    });
  });
}
