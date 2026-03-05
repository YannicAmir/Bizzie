import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late MockAnalyticsService mockAnalyticsService;
  late IncStmtTabAnalytics analytics;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = IncStmtTabAnalytics(mockAnalyticsService);

    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
  });

  group('IncStmtTabAnalytics', () {
    const ticker = 'AAPL';
    const timestamp = '2024-01-01T00:00:00Z';

    test('logViewSummary_allParams_mapsParametersCorrectly', () async {
      // arrange
      final state = IncStmtTabViewState(
        ticker: ticker,
        timestamp: timestamp,
        loadTimeMs: 1500,
        isSuccess: true,
        dataSource: CompanyProfileDataOrigin.api,
        viewDurationSec: 30,
        viewedIncomeTab: true,
        tappedAllIncomeYrly: true,
        tappedAllIncomeQtrly: false,
        switchedIncomeYear: false,
        switchedIncomeQtr: true,
      );

      // act
      await analytics.logViewSummary(state, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'inc_stmt_view_summary',
          parameters: {
            'screen_name': 'inc_stmt_tab',
            'ticker': ticker,
            'timestamp': timestamp,
            'load_time_ms': 1500,
            'is_success': true,
            'data_source': 'api',
            'income_view_duration': 30,
            'viewed_income_tab': true,
            'tapped_all_income_yrly': true,
            'tapped_all_income_qtrly': false,
            'switched_income_year': false,
            'switched_income_qtr': true,
            'is_final': true,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_longTicker_truncatesTicker', () async {
      // arrange
      final longTicker = 'A' * 100;
      final state = IncStmtTabViewState(
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
      final state = IncStmtTabViewState(ticker: ticker, timestamp: timestamp);

      // act
      await analytics.logViewSummary(state, isFinal: true);

      // assert
      final captured =
          verify(
                () => mockAnalyticsService.logEvent(
                  name: 'inc_stmt_view_summary',
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

      final state = IncStmtTabViewState(ticker: ticker, timestamp: timestamp);

      // act & assert
      await expectLater(
        () => analytics.logViewSummary(state, isFinal: true),
        returnsNormally,
      );
    });

    group('IncStmtTabViewState', () {
      test('screenName_initialState_isCorrect', () {
        // arrange
        final state = IncStmtTabViewState(ticker: 'AAPL', timestamp: 'ts');

        // assert
        expect(state.screenName, 'inc_stmt_tab');
      });

      test('copyWithDuration_validInput_updatesDuration', () {
        // arrange
        final state = IncStmtTabViewState(ticker: 'AAPL', timestamp: 'ts');

        // act
        final updated = state.copyWithDuration(45) as IncStmtTabViewState;

        // assert
        expect(updated.viewDurationSec, 45);
      });
    });
  });
}
