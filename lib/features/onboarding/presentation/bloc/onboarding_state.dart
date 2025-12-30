part of 'onboarding_bloc.dart';

enum OnboardingStatus { initial, loading, success, failure }

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default([]) List<Company> detectedCompanies,
    @Default([]) List<HistoricalPrice> sp500History,
    @Default(OnboardingStatus.initial) OnboardingStatus status,
    @Default(OnboardingData()) OnboardingData onboardingData,
    @Default([]) List<String> availableSectors,
    @Default(false) bool isLoadingSectors,
    @Default(false) bool isLoadingHistory,
    @Default(false) bool isAnalyzingBrands,
    @Default(false) bool isSubmitting,
    String? failureMessage,
    @Default(1) int currentStep,
  }) = _OnboardingState;

  factory OnboardingState.initial() => const OnboardingState();
}
