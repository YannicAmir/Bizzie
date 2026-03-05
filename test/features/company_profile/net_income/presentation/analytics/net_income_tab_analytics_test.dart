import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/analytics/net_income_tab_analytics.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/analytics/net_income_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late MockAnalyticsService mockAnalyticsService;
  late NetIncomeTabAnalytics netIncomeTabAnalytics;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    netIncomeTabAnalytics = NetIncomeTabAnalytics(mockAnalyticsService);

    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
  });

  group('NetIncomeTabAnalytics', () {
    const ticker = 'AAPL';
    const timestamp = '2024-01-01T00:00:00Z';

    test('logViewSummary_allParams_mapsParametersCorrectly', () async {
      // arrange
      final state = NetIncomeTabViewState(
        ticker: ticker,
        timestamp: timestamp,
        loadTimeMs: 1500,
        isSuccess: true,
        dataSource: CompanyProfileDataOrigin.api,
        viewDurationSec: 30,
        viewedYearlyNetTab: true,
        viewedQtrlyNetTab: false,
        tappedQtrchartViewAll: true,
        tappedYrchartViewAll: false,
        tappedQtrtableViewAll: false,
        tappedYrtableViewAll: true,
      );

      // act
      await netIncomeTabAnalytics.logViewSummary(state, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'net_income_tab_view_summary',
          parameters: {
            'screen_name': 'net_income_tab',
            'ticker': ticker,
            'timestamp': timestamp,
            'load_time_ms': 1500,
            'is_success': true,
            'data_source': 'api',
            'view_duration_sec': 30,
            'viewed_yearly_net_tab': true,
            'viewed_qtrly_net_tab': false,
            'tapped_qtrchart_view_all': true,
            'tapped_yrchart_view_all': false,
            'tapped_qtrtable_view_all': false,
            'tapped_yrtable_view_all': true,
            'is_final': true,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_longTicker_truncatesTicker', () async {
      // arrange
      final longTicker = 'A' * 100;
      final state = NetIncomeTabViewState(
        ticker: longTicker,
        timestamp: timestamp,
      );

      // act
      await netIncomeTabAnalytics.logViewSummary(state, isFinal: false);

      // assert
      final captured =
          verify(
                () => mockAnalyticsService.logEvent(
                  name: any(named: 'name'),
                  parameters: captureAny(named: 'parameters'),
                ),
              ).captured.single
              as Map<String, Object?>;

      final tickerParam = captured['ticker'] as String;
      expect(tickerParam.length, lessThanOrEqualTo(40));
    });

    test('logViewSummary_nullMetrics_usesDefaults', () async {
      // arrange
      final state = NetIncomeTabViewState(ticker: ticker, timestamp: timestamp);

      // act
      await netIncomeTabAnalytics.logViewSummary(state, isFinal: true);

      // assert
      final captured =
          verify(
                () => mockAnalyticsService.logEvent(
                  name: 'net_income_tab_view_summary',
                  parameters: captureAny(named: 'parameters'),
                ),
              ).captured.single
              as Map<String, Object?>;

      expect(captured['load_time_ms'], 0);
      expect(captured['is_success'], false);
      expect(captured['data_source'], 'unknown');
    });

    test('logViewSummary_serviceException_returnsNormally', () async {
      // arrange
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenThrow(Exception('Analytics error'));

      final state = NetIncomeTabViewState(ticker: ticker, timestamp: timestamp);

      // act & assert
      await expectLater(
        () => netIncomeTabAnalytics.logViewSummary(state, isFinal: true),
        returnsNormally,
      );
    });

    group('NetIncomeTabViewState', () {
      test('screenName_initialState_isNetIncomeTab', () {
        // arrange
        final state = NetIncomeTabViewState(ticker: 'AAPL', timestamp: 'ts');

        // assert
        expect(state.screenName, 'net_income_tab');
      });

      test('copyWithDuration_validInput_updatesDuration', () {
        // arrange
        final state = NetIncomeTabViewState(ticker: 'AAPL', timestamp: 'ts');

        // act
        final updated = state.copyWithDuration(45) as NetIncomeTabViewState;

        // assert
        expect(updated.viewDurationSec, 45);
      });
    });
  });
}
