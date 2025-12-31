import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

enum OnboardingStatus { initial, loading, success, failure }

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    required OnboardingData onboardingData,
    @Default(0) int currentStep,
    @Default(OnboardingStatus.initial) OnboardingStatus status,

    // Loading states
    @Default(false) bool isSubmitting,
    @Default(false) bool isLoadingSectors,
    @Default(false) bool isAnalyzingBrands,
    @Default(false) bool isLoadingHistory,

    // Analysis Simulation (0-3)
    // 0: Initial
    // 1: Analyzing your brands
    // 2: Identifying public companies
    // 3: Building your watchlist (Complete)
    @Default(0) int analysisStep,

    // Watchlist Simulation (0-N)
    // 0: Initial
    // N: Complete (based on detectedCompanies.length)
    @Default(0) int watchlistStep,

    // Data from API/RemoteConfig
    // Updated to use Sector enum
    @Default([]) List<Sector> availableSectors,
    @Default([]) List<HistoricalPrice> sp500History,

    // Brand Data
    @Default([]) List<Brand> globalBrands,
    @Default([]) List<Brand> sectorBrands,
    @Default([]) List<Brand> selectedBrands,
    @Default('') String customBrandInput,

    // Error message
    String? failureMessage,
  }) = _OnboardingState;

  const OnboardingState._();

  factory OnboardingState.initial() =>
      const OnboardingState(onboardingData: OnboardingData());
}
