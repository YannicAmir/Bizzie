import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/home/presentation/analytics/home_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late HomeAnalytics homeAnalytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    homeAnalytics = HomeAnalytics(mockAnalyticsService);
  });

  group('HomeAnalytics', () {
    const screenName = 'home';

    test('logHomeViewed_successful_callsLogEventWithCorrectParams', () async {
      // arrange
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});

      // act
      await homeAnalytics.logHomeViewed();

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'home_viewed',
          parameters: {'screen_name': screenName},
        ),
      ).called(1);
    });

    test(
      'logHomeSearchTapped_successful_callsLogEventWithCorrectParams',
      () async {
        // arrange
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async {});

        // act
        await homeAnalytics.logHomeSearchTapped();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'home_search_tapped',
            parameters: {'screen_name': screenName},
          ),
        ).called(1);
      },
    );

    test(
      'logHomeWatchlistTapped_successful_callsLogEventWithCorrectParams',
      () async {
        // arrange
        const ticker = 'AAPL';
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async {});

        // act
        await homeAnalytics.logHomeWatchlistTapped(ticker: ticker);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'home_watchlist_tapped',
            parameters: {'screen_name': screenName, 'ticker': ticker},
          ),
        ).called(1);
      },
    );

    test(
      'logHomeEmptyStateViewed_successful_callsLogEventWithCorrectParams',
      () async {
        // arrange
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async {});

        // act
        await homeAnalytics.logHomeEmptyStateViewed();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'home_empty_state_viewed',
            parameters: {'screen_name': screenName},
          ),
        ).called(1);
      },
    );
  });
}
