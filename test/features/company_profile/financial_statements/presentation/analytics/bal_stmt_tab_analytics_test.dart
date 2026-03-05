import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late MockAnalyticsService mockAnalyticsService;
  late BalStmtTabAnalytics analytics;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = BalStmtTabAnalytics(mockAnalyticsService);

    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
  });

  group('BalStmtTabAnalytics', () {
    const ticker = 'AAPL';
    const timestamp = '2024-01-01T00:00:00Z';

    test('logViewSummary_allParams_mapsParametersCorrectly', () async {
      // arrange
      final state = BalStmtTabViewState(
        ticker: ticker,
        timestamp: timestamp,
        loadTimeMs: 1500,
        isSuccess: true,
        dataSource: CompanyProfileDataOrigin.api,
        viewDurationSec: 30,
        viewedBalanceTab: true,
        viewedNetWorthChart: true,
        viewedCurrChart: false,
        viewedDebteqChart: false,
        tappedAllBalSheet: true,
        switchedBalancePeriod: true,
      );

      // act
      await analytics.logViewSummary(state, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'bal_sheet_view_summary',
          parameters: {
            'screen_name': 'bal_stmt_tab',
            'ticker': ticker,
            'timestamp': timestamp,
            'load_time_ms': 1500,
            'is_success': true,
            'data_source': 'api',
            'balance_view_duration': 30,
            'viewed_balance_tab': true,
            'tapped_all_bal_sheet': true,
            'switched_balance_period': true,
            'viewed_net_worth_chart': true,
            'viewed_curr_chart': false,
            'viewed_debteq_chart': false,
            'is_final': true,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_longTicker_truncatesTicker', () async {
      // arrange
      final longTicker = 'A' * 100;
      final state = BalStmtTabViewState(
        ticker: longTicker,
        timestamp: timestamp,
      );

      // act
      await analytics.logViewSummary(state, isFinal: false);

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
      final state = BalStmtTabViewState(ticker: ticker, timestamp: timestamp);

      // act
      await analytics.logViewSummary(state, isFinal: true);

      // assert
      final captured =
          verify(
                () => mockAnalyticsService.logEvent(
                  name: 'bal_sheet_view_summary',
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

      final state = BalStmtTabViewState(ticker: ticker, timestamp: timestamp);

      // act & assert
      await expectLater(
        () => analytics.logViewSummary(state, isFinal: true),
        returnsNormally,
      );
    });

    group('BalStmtTabViewState', () {
      test('screenName_initialState_isCorrect', () {
        // arrange
        final state = BalStmtTabViewState(ticker: 'AAPL', timestamp: 'ts');

        // assert
        expect(state.screenName, 'bal_stmt_tab');
      });

      test('copyWithDuration_validInput_updatesDuration', () {
        // arrange
        final state = BalStmtTabViewState(ticker: 'AAPL', timestamp: 'ts');

        // act
        final updated = state.copyWithDuration(45) as BalStmtTabViewState;

        // assert
        expect(updated.viewDurationSec, 45);
      });
    });
  });
}
