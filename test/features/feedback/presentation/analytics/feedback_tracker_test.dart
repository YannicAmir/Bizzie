import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/feedback/presentation/analytics/feedback_tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late MockAnalyticsService mockAnalyticsService;
  late FeedbackTracker sut;

  const kScreenName = 'feedback_modal';

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    sut = FeedbackTracker(mockAnalyticsService);

    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async => {});

    when(
      () => mockAnalyticsService.setUserProperty(
        name: any(named: 'name'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async => {});
  });

  group('FeedbackTracker', () {
    test('logFeedbackViewed_whenInvoked_logsCorrectEvent', () async {
      // arrange
      const intentSource = 'settings';

      // act
      await sut.logFeedbackViewed(intentSource: intentSource);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'feedback_viewed',
          parameters: {
            'screen_name': kScreenName,
            'intent_source': intentSource,
          },
        ),
      ).called(1);
    });

    test(
      'logFeedbackAbandoned_whenInvoked_logsCorrectEventAndParams',
      () async {
        // arrange
        const hasTyped = true;
        const messageLength = 42;

        // act
        await sut.logFeedbackAbandoned(
          hasTyped: hasTyped,
          messageLength: messageLength,
        );

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'feedback_abandoned',
            parameters: {
              'has_typed': hasTyped,
              'message_length': messageLength,
              'screen_name': kScreenName,
            },
          ),
        ).called(1);
      },
    );

    test('setTotalFeedbackCount_whenInvoked_setsUserProperty', () async {
      // arrange
      const count = 5;

      // act
      await sut.setTotalFeedbackCount(count);

      // assert
      verify(
        () => mockAnalyticsService.setUserProperty(
          name: 'total_feedback_count',
          value: count.toString(),
        ),
      ).called(1);
    });

    test(
      'logFeedbackSubmitted_whenInvoked_logsCorrectEventAndParams',
      () async {
        // arrange
        const messageLength = 120;

        // act
        await sut.logFeedbackSubmitted(messageLength: messageLength);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'feedback_submitted',
            parameters: {
              'message_length': messageLength,
              'screen_name': kScreenName,
            },
          ),
        ).called(1);
      },
    );

    test('logFeedbackFailed_whenInvoked_logsCorrectEventAndParams', () async {
      // arrange
      const error = 'Network timeout';

      // act
      await sut.logFeedbackFailed(error: error);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'feedback_failed',
          parameters: {'error_description': error, 'screen_name': kScreenName},
        ),
      ).called(1);
    });

    test('logFeedbackCooldownHit_whenInvoked_logsCorrectEvent', () async {
      // arrange

      // act
      await sut.logFeedbackCooldownHit();

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'feedback_cooldown_hit',
          parameters: {'screen_name': kScreenName},
        ),
      ).called(1);
    });
  });
}
