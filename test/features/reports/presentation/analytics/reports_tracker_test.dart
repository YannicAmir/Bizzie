import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';
import 'package:bizzie/features/reports/presentation/analytics/reports_tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late ReportsTracker tracker;
  late MockIAnalyticsService mockAnalytics;

  setUpAll(() {
    registerFallbackValue(ReportsEntrySource.nav);
    registerFallbackValue(ReportsNotificationType.earningsNotification);
  });

  setUp(() {
    mockAnalytics = MockIAnalyticsService();
    tracker = ReportsTracker(mockAnalytics);

    when(
      () => mockAnalytics.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
  });

  group('ReportsTracker', () {
    const screenName = 'reports_feed';

    test('logFeedViewed_success_logsEventWithCorrectParams', () async {
      // arrange
      const unreadCount = 5;
      const entrySource = ReportsEntrySource.notification;
      const notificationType = ReportsNotificationType.earningsNotification;

      // act
      await tracker.logFeedViewed(
        unreadCount: unreadCount,
        entrySource: entrySource,
        notificationType: notificationType,
      );

      // assert
      verify(
        () => mockAnalytics.logEvent(
          name: 'reports_feed_viewed',
          parameters: {
            'unread_count': unreadCount,
            'entry_source': entrySource.name,
            'notification_type': notificationType.name,
            'screen_name': screenName,
          },
        ),
      ).called(1);
    });

    test('logLinkOpened_success_logsEventWithCorrectParams', () async {
      // arrange
      const ticker = 'AAPL';
      const filingType = '10-K';

      // act
      await tracker.logLinkOpened(ticker: ticker, filingType: filingType);

      // assert
      verify(
        () => mockAnalytics.logEvent(
          name: 'filing_link_opened',
          parameters: {
            'ticker': ticker,
            'filing_type': filingType,
            'screen_name': screenName,
          },
        ),
      ).called(1);
    });

    test('logSummaryViewed_success_logsEventWithCorrectParams', () async {
      // arrange
      const ticker = 'MSFT';
      const filingType = '10-Q';
      const wasPreviouslyPending = true;

      // act
      await tracker.logSummaryViewed(
        ticker: ticker,
        filingType: filingType,
        wasPreviouslyPending: wasPreviouslyPending,
      );

      // assert
      verify(
        () => mockAnalytics.logEvent(
          name: 'filing_summary_viewed',
          parameters: {
            'ticker': ticker,
            'filing_type': filingType,
            'was_previously_pending': wasPreviouslyPending,
            'screen_name': screenName,
          },
        ),
      ).called(1);
    });

    test(
      'logSummarizeLockedClicked_success_logsEventWithCorrectParams',
      () async {
        // arrange
        const ticker = 'TSLA';
        const filingType = '8-K';

        // act
        await tracker.logSummarizeLockedClicked(
          ticker: ticker,
          filingType: filingType,
        );

        // assert
        verify(
          () => mockAnalytics.logEvent(
            name: 'filing_sum_lock_clicked',
            parameters: {
              'ticker': ticker,
              'filing_type': filingType,
              'screen_name': screenName,
            },
          ),
        ).called(1);
      },
    );

    test(
      'logAnalysisPendingViewed_success_logsEventWithCorrectParams',
      () async {
        // arrange
        const ticker = 'GOOGL';
        const filingType = '10-Q';

        // act
        await tracker.logAnalysisPendingViewed(
          ticker: ticker,
          filingType: filingType,
        );

        // assert
        verify(
          () => mockAnalytics.logEvent(
            name: 'filing_pending_viewed',
            parameters: {
              'ticker': ticker,
              'filing_type': filingType,
              'screen_name': screenName,
            },
          ),
        ).called(1);
      },
    );

    test('logUpcomingExpanded_success_logsEvent', () async {
      // arrange

      // act
      await tracker.logUpcomingExpanded();

      // assert
      verify(
        () => mockAnalytics.logEvent(
          name: 'upcoming_earn_expanded',
          parameters: {'screen_name': screenName},
        ),
      ).called(1);
    });

    test(
      'logUpcomingCompanyClicked_success_logsEventWithCorrectParams',
      () async {
        // arrange
        const ticker = 'NFLX';

        // act
        await tracker.logUpcomingCompanyClicked(ticker: ticker);

        // assert
        verify(
          () => mockAnalytics.logEvent(
            name: 'upcoming_earn_co_clicked',
            parameters: {'ticker': ticker, 'screen_name': screenName},
          ),
        ).called(1);
      },
    );

    test('logEmptyCtaClicked_success_logsEvent', () async {
      // arrange

      // act
      await tracker.logEmptyCtaClicked();

      // assert
      verify(
        () => mockAnalytics.logEvent(
          name: 'reports_empty_cta_tap',
          parameters: {'screen_name': screenName},
        ),
      ).called(1);
    });

    test('logFetchFailed_success_logsEventWithCorrectParams', () async {
      // arrange
      const error = 'Network Error';

      // act
      await tracker.logFetchFailed(error: error);

      // assert
      verify(
        () => mockAnalytics.logEvent(
          name: 'reports_fetch_failed',
          parameters: {'error': error, 'screen_name': screenName},
        ),
      ).called(1);
    });

    test(
      'logFilingCardCompanyClicked_success_logsEventWithCorrectParams',
      () async {
        // arrange
        const ticker = 'NVDA';

        // act
        await tracker.logFilingCardCompanyClicked(ticker: ticker);

        // assert
        verify(
          () => mockAnalytics.logEvent(
            name: 'filing_card_co_clicked',
            parameters: {'ticker': ticker, 'screen_name': screenName},
          ),
        ).called(1);
      },
    );
  });
}
