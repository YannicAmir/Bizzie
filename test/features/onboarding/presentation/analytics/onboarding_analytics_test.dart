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

  group('OnboardingAnalytics step events', () {
    test('logStepViewed_logsDistinctEventNamePerStep', () async {
      final expectedEventNames = {
        OnboardingStep.landing: 'onb_step_01_landing',
        OnboardingStep.askName: 'onb_step_02_ask_name',
        OnboardingStep.sectorSelection: 'onb_step_04_sector_selection',
        OnboardingStep.analyzingSelectedBrands: 'onb_step_07_analyzing_brands',
        OnboardingStep.profileReady: 'onb_step_15_profile_ready',
        OnboardingStep.discountPaywall: 'onb_step_18_discount_paywall',
      };

      for (final entry in expectedEventNames.entries) {
        await onboardingAnalytics.logStepViewed(step: entry.key);

        verify(
          () => mockAnalyticsService.logEvent(
            name: entry.value,
            parameters: any(named: 'parameters'),
          ),
        ).called(1);
      }
    });

    test('logStepViewed_mapsHighlightStepsToFeatureHighlightsEvent', () async {
      await onboardingAnalytics.logStepViewed(step: OnboardingStep.highlight1);
      await onboardingAnalytics.logStepViewed(step: OnboardingStep.highlight2);
      await onboardingAnalytics.logStepViewed(step: OnboardingStep.highlight3);
      await onboardingAnalytics.logStepViewed(
        step: OnboardingStep.featureHighlights,
      );

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onb_step_12_feature_highlights',
          parameters: any(
            named: 'parameters',
            that: containsPair('step_index', 12),
          ),
        ),
      ).called(4);
    });

    test('logStepViewed_includesMandatoryParameters', () async {
      await onboardingAnalytics.logStepViewed(step: OnboardingStep.landing);

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onb_step_01_landing',
          parameters: any(
            named: 'parameters',
            that: allOf([
              containsPair('step_index', 1),
              containsPair('screen_name', 'onboarding'),
              contains('day_of_week'),
            ]),
          ),
        ),
      ).called(1);
    });

    test('logStepViewed_includesOnlyProvidedCompletionParameters', () async {
      await onboardingAnalytics.logStepViewed(
        step: OnboardingStep.meetYourBizzie,
        prevDurationSec: 12,
        selectedSector: 'energy',
      );

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onb_step_05_meet_your_bizzie',
          parameters: any(
            named: 'parameters',
            that: allOf([
              containsPair('prev_duration_sec', 12),
              containsPair('selected_sector', 'energy'),
              isNot(contains('brands_selected_count')),
              isNot(contains('highlights_skipped')),
            ]),
          ),
        ),
      ).called(1);
    });

    test('logStepViewed_eventAndParameterNamesWithinFirebaseLimits', () async {
      for (final step in OnboardingStep.values) {
        await onboardingAnalytics.logStepViewed(step: step);
      }

      final invocations = verify(
        () => mockAnalyticsService.logEvent(
          name: captureAny(named: 'name'),
          parameters: captureAny(named: 'parameters'),
        ),
      ).captured;

      for (final captured in invocations) {
        if (captured is String) {
          expect(captured.length, lessThanOrEqualTo(40));
        } else if (captured is Map<String, Object?>) {
          for (final key in captured.keys) {
            expect(key.length, lessThanOrEqualTo(40));
          }
        }
      }
    });
  });

  group('OnboardingAnalytics completion events', () {
    test('logCompletionFailed_logsErrorMessage', () async {
      await onboardingAnalytics.logCompletionFailed(
        errorMessage: 'Something went wrong',
      );

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onb_completion_failed',
          parameters: any(
            named: 'parameters',
            that: containsPair('error_message', 'Something went wrong'),
          ),
        ),
      ).called(1);
    });

    test('logSignUp_logsMethod', () async {
      await onboardingAnalytics.logSignUp(method: 'google');

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onboarding_sign_up',
          parameters: any(
            named: 'parameters',
            that: containsPair('method', 'google'),
          ),
        ),
      ).called(1);
    });
  });
}
