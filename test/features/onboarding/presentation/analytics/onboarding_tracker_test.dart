import 'package:bizzie/core/analytics/analytics_context.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

class MockAnalyticsContext extends Mock implements AnalyticsContext {}

void main() {
  late MockAnalyticsService mockAnalyticsService;
  late MockAnalyticsContext mockAnalyticsContext;
  late OnboardingTracker tracker;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    mockAnalyticsContext = MockAnalyticsContext();
    tracker = OnboardingTracker(mockAnalyticsService, mockAnalyticsContext);
  });

  group('OnboardingTracker', () {
    const tScreenName = 'onboarding';

    group('logStepViewed', () {
      test('logStepViewed_standardStep_logsEventWithStepName', () async {
        // arrange
        const tStep = OnboardingStep.askName;
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async {});

        // act
        await tracker.logStepViewed(step: tStep);

        // assert
        final captured =
            verify(
                  () => mockAnalyticsService.logEvent(
                    name: 'onboarding_step_viewed',
                    parameters: captureAny(named: 'parameters'),
                  ),
                ).captured.first
                as Map<String, Object>;

        expect(captured['step_name'], tStep.name);
        expect(captured['screen_name'], tScreenName);
        expect(captured.containsKey('timestamp'), true);
      });

      test(
        'logStepViewed_landingStepNoPostDeletion_logsEventWithoutSource',
        () async {
          // arrange
          const tStep = OnboardingStep.landing;
          when(() => mockAnalyticsContext.isPostDeletion).thenReturn(false);
          when(
            () => mockAnalyticsService.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) async {});

          // act
          await tracker.logStepViewed(step: tStep);

          // assert
          final captured =
              verify(
                    () => mockAnalyticsService.logEvent(
                      name: 'onboarding_step_viewed',
                      parameters: captureAny(named: 'parameters'),
                    ),
                  ).captured.first
                  as Map<String, Object>;

          expect(captured['step_name'], tStep.name);
          expect(captured.containsKey('source'), false);
          verifyNever(() => mockAnalyticsContext.reset());
        },
      );

      test(
        'logStepViewed_landingStepWithPostDeletion_logsEventWithSourceAndResets',
        () async {
          // arrange
          const tStep = OnboardingStep.landing;
          when(() => mockAnalyticsContext.isPostDeletion).thenReturn(true);
          when(() => mockAnalyticsContext.reset()).thenReturn(null);
          when(
            () => mockAnalyticsService.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) async {});

          // act
          await tracker.logStepViewed(step: tStep);

          // assert
          final captured =
              verify(
                    () => mockAnalyticsService.logEvent(
                      name: 'onboarding_step_viewed',
                      parameters: captureAny(named: 'parameters'),
                    ),
                  ).captured.first
                  as Map<String, Object>;

          expect(captured['step_name'], tStep.name);
          expect(captured['source'], 'account_deletion');
          verify(() => mockAnalyticsContext.reset()).called(1);
        },
      );
    });

    group('logStepDuration', () {
      test('logStepDuration_validInput_logsEventWithStepAndDuration', () async {
        // arrange
        const tStep = OnboardingStep.askName;
        const tSeconds = 15;
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async {});

        // act
        await tracker.logStepDuration(step: tStep, seconds: tSeconds);

        // assert
        final captured =
            verify(
                  () => mockAnalyticsService.logEvent(
                    name: 'onboarding_step_duration',
                    parameters: captureAny(named: 'parameters'),
                  ),
                ).captured.first
                as Map<String, Object>;

        expect(captured['step_name'], tStep.name);
        expect(captured['duration_seconds'], tSeconds);
      });
    });

    group('logExitToLogin', () {
      test('logExitToLogin_called_logsEventWithLandingStep', () async {
        // arrange
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async {});

        // act
        await tracker.logExitToLogin();

        // assert
        final captured =
            verify(
                  () => mockAnalyticsService.logEvent(
                    name: 'onboarding_exit_to_login',
                    parameters: captureAny(named: 'parameters'),
                  ),
                ).captured.first
                as Map<String, Object>;

        expect(captured['step_name'], OnboardingStep.landing.name);
      });
    });

    group('logConversion', () {
      test('logConversion_called_logsEventAndSetsUserProperty', () async {
        // arrange
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => mockAnalyticsService.setUserProperty(
            name: any(named: 'name'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});

        // act
        await tracker.logConversion();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'onboarding_conversion',
            parameters: any(named: 'parameters'),
          ),
        ).called(1);

        verify(
          () => mockAnalyticsService.setUserProperty(
            name: 'converted_during_onboarding',
            value: 'true',
          ),
        ).called(1);
      });
    });
  });
}
