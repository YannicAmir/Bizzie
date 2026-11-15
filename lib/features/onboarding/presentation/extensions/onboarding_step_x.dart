import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';

extension OnboardingStepX on OnboardingStep {
  String get analyticsName => switch (this) {
    OnboardingStep.landing => 'landing',
    OnboardingStep.sectorSelection => 'sector_selection',
    OnboardingStep.brandsSelection => 'brands_selection',
    OnboardingStep.companyProfile => 'company_profile',
    OnboardingStep.notificationsPrompt => 'notifications_prompt',
    OnboardingStep.investingExperience => 'investing_experience',
    OnboardingStep.askName => 'ask_name',
    OnboardingStep.featureHighlights => 'feature_highlights',
    OnboardingStep.highlight1 => 'highlight_1',
    OnboardingStep.highlight2 => 'highlight_2',
    OnboardingStep.highlight3 => 'highlight_3',
    OnboardingStep.createAccount => 'create_account',
    OnboardingStep.buildingProfile => 'building_profile',
    OnboardingStep.profileReady => 'profile_ready',
    OnboardingStep.paywall => 'paywall',
    OnboardingStep.giftModal => 'gift_modal',
    OnboardingStep.discountPaywall => 'discount_paywall',
  };
}
