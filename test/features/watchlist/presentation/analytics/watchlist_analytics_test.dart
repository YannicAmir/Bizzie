import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/watchlist/presentation/analytics/watchlist_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late WatchlistAnalytics watchlistAnalytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    watchlistAnalytics = WatchlistAnalytics(mockAnalyticsService);
  });

  group('WatchlistAnalytics', () {
    const tTicker = 'AAPL';
    const tCompanyName = 'Apple Inc.';
    const tTabName = 'summary';
    const tDuration = 15;
    const tSource = 'company_profile';

    group('setWatchlistItemCount', () {
      test('setWatchlistItemCount_success_callsSetUserProperty', () async {
        // arrange
        const count = 5;
        when(
          () => mockAnalyticsService.setUserProperty(
            name: any(named: 'name'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => {});

        // act
        await watchlistAnalytics.setWatchlistItemCount(count);

        // assert
        verify(
          () => mockAnalyticsService.setUserProperty(
            name: 'watchlist_item_count',
            value: '5',
          ),
        ).called(1);
      });

      test(
        'setWatchlistItemCount_serviceThrows_handlesErrorGracefully',
        () async {
          // arrange
          const count = 5;
          when(
            () => mockAnalyticsService.setUserProperty(
              name: any(named: 'name'),
              value: any(named: 'value'),
            ),
          ).thenThrow(Exception('Analytics failure'));

          // act & assert
          await expectLater(
            watchlistAnalytics.setWatchlistItemCount(count),
            completes,
          );
        },
      );
    });

    group('logItemAdded', () {
      test('logItemAdded_success_callsLogEventWithMetadata', () async {
        // arrange
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async => {});

        // act
        await watchlistAnalytics.logItemAdded(
          ticker: tTicker,
          companyName: tCompanyName,
          tabName: tTabName,
          durationOnPageSeconds: tDuration,
          source: tSource,
        );

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'watchlist_item_added',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((m) => m['ticker'], 'ticker', tTicker)
                  .having(
                    (m) => m['company_name'],
                    'company_name',
                    tCompanyName,
                  )
                  .having((m) => m['tab_name'], 'tab_name', tTabName)
                  .having(
                    (m) => m['duration_on_page_seconds'],
                    'duration',
                    tDuration,
                  )
                  .having((m) => m['source'], 'source', tSource)
                  .having(
                    (m) => m['screen_name'],
                    'screen_name',
                    'company_profile',
                  )
                  .having((m) => m['timestamp'], 'timestamp', isNotNull),
            ),
          ),
        ).called(1);
      });

      test('logItemAdded_serviceThrows_handlesErrorGracefully', () async {
        // arrange
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenThrow(Exception('Analytics failure'));

        // act & assert
        await expectLater(
          watchlistAnalytics.logItemAdded(
            ticker: tTicker,
            companyName: tCompanyName,
            tabName: tTabName,
            durationOnPageSeconds: tDuration,
          ),
          completes,
        );
      });
    });

    group('logItemRemoved', () {
      test('logItemRemoved_success_callsLogEventWithMetadata', () async {
        // arrange
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async => {});

        // act
        await watchlistAnalytics.logItemRemoved(
          ticker: tTicker,
          tabName: tTabName,
          durationOnPageSeconds: tDuration,
        );

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'watchlist_item_removed',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((m) => m['ticker'], 'ticker', tTicker)
                  .having((m) => m['tab_name'], 'tab_name', tTabName)
                  .having(
                    (m) => m['duration_on_page_seconds'],
                    'duration',
                    tDuration,
                  )
                  .having(
                    (m) => m['screen_name'],
                    'screen_name',
                    'company_profile',
                  )
                  .having((m) => m['timestamp'], 'timestamp', isNotNull),
            ),
          ),
        ).called(1);
      });
    });

    group('logOperationFailed', () {
      test('logOperationFailed_success_callsLogEventWithMetadata', () async {
        // arrange
        const operation = 'add';
        const errorMessage = 'Network error';
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async => {});

        // act
        await watchlistAnalytics.logOperationFailed(
          operation: operation,
          errorMessage: errorMessage,
        );

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'watchlist_operation_failed',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((m) => m['operation'], 'operation', operation)
                  .having(
                    (m) => m['error_message'],
                    'error_message',
                    errorMessage,
                  )
                  .having(
                    (m) => m['screen_name'],
                    'screen_name',
                    'company_profile',
                  )
                  .having((m) => m['timestamp'], 'timestamp', isNotNull),
            ),
          ),
        ).called(1);
      });
    });
  });
}
