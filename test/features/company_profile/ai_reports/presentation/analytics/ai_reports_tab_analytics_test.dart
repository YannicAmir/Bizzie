import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/analytics/ai_reports_tab_analytics.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/analytics/ai_reports_tab_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

const tTicker = 'AAPL';
const tTimestamp = '2026-01-01T00:00:00Z';
const tState = AiReportsTabViewState(
  ticker: tTicker,
  timestamp: tTimestamp,
  loadTimeMs: 450,
  isSuccess: true,
  dataSource: CompanyProfileDataOrigin.db,
  viewDurationSec: 30,
  viewedTenKTab: true,
  viewedEightKTab: true,
  openedReport: true,
);

void main() {
  late AiReportsTabAnalytics sut;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    sut = AiReportsTabAnalytics(mockAnalyticsService);
  });

  group('AiReportsTabAnalytics', () {
    test('logViewSummary_validState_logsCorrectParameters', () async {
      // arrange
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});

      // act
      await sut.logViewSummary(tState, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'ai_reports_tab_view_summary',
          parameters: {
            'screen_name': 'ai_reports_tab',
            'ticker': tTicker,
            'timestamp': tTimestamp,
            'load_time_ms': 450,
            'is_success': true,
            'data_source': 'db',
            'view_duration_sec': 30,
            'viewed_10k_tab': true,
            'viewed_10q_tab': false,
            'viewed_8k_tab': true,
            'opened_report': true,
            'opened_filing_link': false,
            'is_final': true,
          },
        ),
      ).called(1);
    });

    test('logViewSummary_analyticsThrows_doesNotPropagate', () async {
      // arrange
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenThrow(Exception('boom'));

      // act
      final call = sut.logViewSummary(tState, isFinal: false);

      // assert
      await expectLater(call, completes);
    });
  });
}
