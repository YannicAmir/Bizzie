import 'package:bizzie/core/enums/day_of_week.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_skip_reason.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_field_sources.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_session_summary.dart';
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
        OnboardingStep.landing: 'onb_step_landing',
        OnboardingStep.sectorSelection: 'onb_step_sector_selection',
        OnboardingStep.brandsSelection: 'onb_step_brands_selection',
        OnboardingStep.companyProfile: 'onb_step_company_profile',
        OnboardingStep.notificationsPrompt: 'onb_step_notifications_prompt',
        OnboardingStep.investingExperience: 'onb_step_investing_experience',
        OnboardingStep.askName: 'onb_step_ask_name',
        OnboardingStep.featureHighlights: 'onb_step_feature_highlights',
        OnboardingStep.createAccount: 'onb_step_create_account',
        OnboardingStep.buildingProfile: 'onb_step_building_profile',
        OnboardingStep.profileReady: 'onb_step_profile_ready',
        OnboardingStep.paywall: 'onb_step_paywall',
        OnboardingStep.giftModal: 'onb_step_gift_modal',
        OnboardingStep.discountPaywall: 'onb_step_discount_paywall',
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

    test('logStepViewed_stepIndexFollowsOnboardingFlowOrder', () async {
      // arrange
      const expectedIndexes = {
        OnboardingStep.landing: 1,
        OnboardingStep.sectorSelection: 2,
        OnboardingStep.brandsSelection: 3,
        OnboardingStep.companyProfile: 4,
        OnboardingStep.notificationsPrompt: 5,
        OnboardingStep.investingExperience: 6,
        OnboardingStep.askName: 7,
        OnboardingStep.featureHighlights: 8,
        OnboardingStep.createAccount: 9,
        OnboardingStep.buildingProfile: 10,
        OnboardingStep.profileReady: 11,
        OnboardingStep.paywall: 12,
        OnboardingStep.giftModal: 13,
        OnboardingStep.discountPaywall: 14,
      };

      for (final entry in expectedIndexes.entries) {
        // act
        await onboardingAnalytics.logStepViewed(step: entry.key);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(
              named: 'parameters',
              that: containsPair('step_index', entry.value),
            ),
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
          name: 'onb_step_feature_highlights',
          parameters: any(
            named: 'parameters',
            that: containsPair('step_index', 8),
          ),
        ),
      ).called(4);
    });

    test('logStepViewed_includesMandatoryParameters', () async {
      await onboardingAnalytics.logStepViewed(step: OnboardingStep.landing);

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onb_step_landing',
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
        step: OnboardingStep.brandsSelection,
        prevDurationSec: 12,
        selectedSector: 'energy',
      );

      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onb_step_brands_selection',
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

  group('OnboardingAnalytics skip events', () {
    const tFieldSources = OnboardingFieldSources(
      name: OnboardingValueSource.userSelection,
      sector: OnboardingValueSource.remoteDefault,
      companies: OnboardingValueSource.userSelection,
      experience: OnboardingValueSource.localDefault,
      notifications: OnboardingValueSource.remoteDefault,
    );

    test('logSkipped_mapsStepAndFieldSourcesToParameters', () async {
      // act
      await onboardingAnalytics.logSkipped(
        step: OnboardingStep.brandsSelection,
        reason: OnboardingSkipReason.userSkipped,
        sessionId: 'session-1',
        hadAccount: false,
        brandsSelectedCount: 2,
        fieldSources: tFieldSources,
        notificationsDecided: true,
      );

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onb_skipped',
          parameters: any(
            named: 'parameters',
            that: allOf([
              containsPair('skip_step', 'brands_selection'),
              containsPair('reason', 'user_skipped'),
              containsPair('step_index', 3),
              containsPair('session_id', 'session-1'),
              containsPair('had_account', false),
              containsPair('brands_selected_count', 2),
              containsPair('sector_source', 'default'),
              containsPair('watchlist_source', 'user'),
              containsPair('experience_source', 'default'),
              containsPair('name_source', 'user'),
              containsPair('notifications_decided', true),
              containsPair('screen_name', 'onboarding'),
            ]),
          ),
        ),
      ).called(1);
    });

    test('logSkipped_purchaseAbort_logsPurchasedReason', () async {
      // arrange

      // act
      await onboardingAnalytics.logSkipped(
        step: OnboardingStep.companyProfile,
        reason: OnboardingSkipReason.purchased,
        sessionId: 'session-1',
        hadAccount: true,
        brandsSelectedCount: 1,
        fieldSources: tFieldSources,
        notificationsDecided: false,
      );

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onb_skipped',
          parameters: any(
            named: 'parameters',
            that: allOf([
              containsPair('skip_step', 'company_profile'),
              containsPair('step_index', 4),
              containsPair('reason', 'purchased'),
            ]),
          ),
        ),
      ).called(1);
    });

    test('logSkipped_unresolvedDefaults_logsNoneSource', () async {
      // arrange
      const tUnresolvedSources = OnboardingFieldSources(
        name: OnboardingValueSource.localDefault,
        sector: OnboardingValueSource.none,
        companies: OnboardingValueSource.none,
        experience: OnboardingValueSource.localDefault,
        notifications: OnboardingValueSource.localDefault,
      );

      // act
      await onboardingAnalytics.logSkipped(
        step: OnboardingStep.sectorSelection,
        reason: OnboardingSkipReason.userSkipped,
        sessionId: 'session-1',
        hadAccount: false,
        brandsSelectedCount: 0,
        fieldSources: tUnresolvedSources,
        notificationsDecided: false,
      );

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onb_skipped',
          parameters: any(
            named: 'parameters',
            that: allOf([
              containsPair('sector_source', 'none'),
              containsPair('watchlist_source', 'none'),
            ]),
          ),
        ),
      ).called(1);
    });

    test(
      'logInitialCompanyShown_skipped_logsTickerSourceAndExitType',
      () async {
        // act
        await onboardingAnalytics.logInitialCompanyShown(
          ticker: 'AAPL',
          tickerSource: OnboardingValueSource.remoteDefault,
          isSkipped: true,
          isGuest: true,
        );

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'onb_initial_company_shown',
            parameters: any(
              named: 'parameters',
              that: allOf([
                containsPair('ticker', 'AAPL'),
                containsPair('ticker_source', 'remote_default'),
                containsPair('exit_type', 'skipped'),
                containsPair('is_guest', true),
              ]),
            ),
          ),
        ).called(1);
      },
    );

    test(
      'logInitialCompanyShown_completedUserSelection_logsCompletedExitType',
      () async {
        // act
        await onboardingAnalytics.logInitialCompanyShown(
          ticker: 'TST',
          tickerSource: OnboardingValueSource.userSelection,
          isSkipped: false,
          isGuest: false,
        );

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'onb_initial_company_shown',
            parameters: any(
              named: 'parameters',
              that: allOf([
                containsPair('ticker_source', 'user_selection'),
                containsPair('exit_type', 'completed'),
                containsPair('is_guest', false),
              ]),
            ),
          ),
        ).called(1);
      },
    );

    test('logSessionSummary_includesDidSkip', () async {
      // act
      await onboardingAnalytics.logSessionSummary(
        const OnboardingSessionSummary(
          sessionId: 'session-1',
          exitStep: 'skipped_ask_name',
          totalDurationSeconds: 5,
          addedBrandsCount: 0,
          notificationsEnabled: false,
          didSignup: false,
          didSkip: true,
          dayOfWeek: DayOfWeek.monday,
        ),
      );

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'onboarding_session_summary',
          parameters: any(
            named: 'parameters',
            that: allOf([
              containsPair('exit_step', 'skipped_ask_name'),
              containsPair('did_skip', true),
              isNot(contains('highlights_skipped')),
            ]),
          ),
        ),
      ).called(1);
    });
  });
}
