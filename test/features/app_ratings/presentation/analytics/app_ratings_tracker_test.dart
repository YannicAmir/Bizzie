import 'package:bizzie/core/analytics/models/app_rating_prompt_context.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/app_ratings/presentation/analytics/app_ratings_tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late MockAnalyticsService mockAnalyticsService;
  late AppRatingsTracker tracker;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    tracker = AppRatingsTracker(mockAnalyticsService);
  });

  group('AppRatingsTracker', () {
    const tScreenName = 'company_profile';

    test('logInteraction_validInput_logsEventWithCorrectParams', () async {
      // arrange
      const tTicker = 'AAPL';
      const tCount = 5;
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});

      // act
      await tracker.logInteraction(ticker: tTicker, count: tCount);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'app_rating_interaction',
          parameters: {
            'screen_name': tScreenName,
            'ticker': tTicker,
            'interaction_count': tCount,
          },
        ),
      ).called(1);
    });

    test('logPromptShown_validContext_logsEventWithContextParams', () async {
      // arrange
      const tContext = AppRatingPromptContext(
        ticker: 'AAPL',
        companyName: 'Apple Inc.',
        sector: 'Technology',
        industry: 'Consumer Electronics',
        experienceLevel: 'intermediate',
        favoriteSector: 'Technology',
        isPremium: true,
        watchlistCount: 10,
        notificationsEnabled: true,
        interactionCount: 5,
        promptAttempts: 1,
        currentTab: 'financials',
        thresholdCount: 3,
      );
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});

      // act
      await tracker.logPromptShown(context: tContext);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'app_rating_prompt_shown',
          parameters: tContext.toMap(tScreenName),
        ),
      ).called(1);
    });

    test('logMaxAttemptsReached_validInput_logsEventWithAttempts', () async {
      // arrange
      const tTicker = 'AAPL';
      const tAttempts = 3;
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async {});

      // act
      await tracker.logMaxAttemptsReached(ticker: tTicker, attempts: tAttempts);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'app_rating_max_attempts_reached',
          parameters: {
            'screen_name': tScreenName,
            'ticker': tTicker,
            'prompt_attempts': tAttempts,
          },
        ),
      ).called(1);
    });

    test('updateJourneyStatus_validStatus_setsUserProperty', () async {
      // arrange
      const tStatus = AppRatingJourneyStatus.completed;
      when(
        () => mockAnalyticsService.setUserProperty(
          name: any(named: 'name'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      // act
      await tracker.updateJourneyStatus(tStatus);

      // assert
      verify(
        () => mockAnalyticsService.setUserProperty(
          name: 'app_rating_status',
          value: 'completed',
        ),
      ).called(1);
    });
  });
}
