import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late OnboardingAnalytics onboardingAnalytics;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    onboardingAnalytics = OnboardingAnalytics(mockAnalyticsService);

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
  });

  group('OnboardingAnalytics Normalization', () {
    test('logStep_normalizesAnalyzingBrands', () {
      onboardingAnalytics.logStep(
        stepName: OnboardingStep.analyzingSelectedBrands.name,
      );

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onboarding_step_logged',
          parameters: any(
            named: 'parameters',
            that: containsPair('step_name', 'analyzing_brands'),
          ),
        ),
      ).called(1);
    });

    test('logStep_normalizesHighlightsToFeatureHighlights', () {
      onboardingAnalytics.logStep(stepName: OnboardingStep.highlight1.name);
      onboardingAnalytics.logStep(stepName: OnboardingStep.highlight2.name);
      onboardingAnalytics.logStep(stepName: OnboardingStep.highlight3.name);

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onboarding_step_logged',
          parameters: any(
            named: 'parameters',
            that: containsPair('step_name', 'feature_highlights'),
          ),
        ),
      ).called(3);
    });

    test('logStep_normalizesCamelCaseStepsToSnakeCase', () {
      final testCases = {
        OnboardingStep.sectorSelection.name: 'sector_selection',
        OnboardingStep.brandsSelection.name: 'brands_selection',
        OnboardingStep.meetYourBizzie.name: 'meet_your_bizzie',
        OnboardingStep.gladYouJoined.name: 'glad_you_joined',
        OnboardingStep.profileReady.name: 'profile_ready',
        OnboardingStep.investingExperience.name: 'investing_experience',
      };

      for (final entry in testCases.entries) {
        onboardingAnalytics.logStep(stepName: entry.key);

        verify(
          () => mockAnalyticsService.logEvent(
            name: 'onboarding_step_logged',
            parameters: any(
              named: 'parameters',
              that: containsPair('step_name', entry.value),
            ),
          ),
        ).called(1);
      }
    });

    test('logStep_includesMandatoryParameters', () {
      onboardingAnalytics.logStep(stepName: 'test_step');

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onboarding_step_logged',
          parameters: any(
            named: 'parameters',
            that: allOf([
              contains('day_of_week'),
              contains('timestamp'),
              containsPair('step_name', 'test_step'),
            ]),
          ),
        ),
      ).called(1);
    });
  });
}
