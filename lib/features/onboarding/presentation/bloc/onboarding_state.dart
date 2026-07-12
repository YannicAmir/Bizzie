import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/presentation/models/feature_highlight_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_assets_helper.dart';
import 'package:bizzie/features/onboarding/presentation/utils/brand_display_helper.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';

import 'package:bizzie/shared/models/sector_view_model.dart';

part 'onboarding_state.freezed.dart';

enum OnboardingStatus { initial, loading, success, failure }

enum AnalysisStepStatus { pending, active, completed }

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial({
    @Default(OnboardingData()) OnboardingData onboardingData,
    @Default(0) int currentStep,
    @Default(OnboardingStatus.initial) OnboardingStatus status,

    @Default(false) bool isSubmitting,
    @Default(false) bool isLoadingSectors,
    @Default(false) bool isAnalyzingBrands,
    @Default(false) bool isLoadingHistory,

    @Default(0) int analysisStep,
    @Default(0) int watchlistStep,
    @Default([]) List<SectorViewModel> availableSectors,
    @Default([]) List<HistoricalPrice> sp500History,

    @Default([]) List<Brand> selectedBrands,
    @Default('') String customBrandInput,
    String? failureMessage,
    @Default([]) List<FeatureHighlightItem> featureHighlights,
    @Default(0) int currentHighlightIndex,
    @Default(false) bool shouldNavigateToCreateAccount,
    @Default(false) bool shouldNavigateToBuildingProfile,
    DateTime? sessionEntryTime,
    @Default('') String sessionId,
    OnboardingStep? lastStep,
    @Default(false) bool highlightsSkipped,
    @Default(false) bool didSubscribe,
    @Default('none') String subscriptionType,
  }) = _OnboardingState;

  const OnboardingState._();

  String get analysisTitle {
    if (analysisStep >= 3) return 'All done!';
    switch (analysisStep) {
      case 0:
        return 'Analyzing your\nbrands';
      case 1:
        return 'Identifying public\ncompanies';
      case 2:
        return 'Building your\nwatchlist';
      case 3:
        return 'All done!';
      default:
        return 'Analyzing your\nbrands';
    }
  }

  AnalysisStepStatus get stepAnalysisStatus {
    if (analysisStep >= 1) return AnalysisStepStatus.completed;
    if (analysisStep == 0) return AnalysisStepStatus.active;
    return AnalysisStepStatus.pending;
  }

  AnalysisStepStatus get stepPublicCompaniesStatus {
    if (analysisStep >= 2) return AnalysisStepStatus.completed;
    if (analysisStep == 1) return AnalysisStepStatus.active;
    return AnalysisStepStatus.pending;
  }

  AnalysisStepStatus get stepWatchlistStatus {
    if (analysisStep >= 3) return AnalysisStepStatus.completed;
    if (analysisStep == 2) return AnalysisStepStatus.active;
    if (analysisStep == 2) return AnalysisStepStatus.active;
    return AnalysisStepStatus.pending;
  }

  bool get isSingleCompanyView => onboardingData.detectedCompanies.length == 1;

  String get foundCompaniesTitle {
    final count = onboardingData.detectedCompanies.length;
    return 'Bizzie found $count ${count == 1 ? 'company' : 'companies'}';
  }

  String get foundCompaniesSubtitle {
    return isSingleCompanyView
        ? 'Check out the company that makes the product you love below!'
        : 'Check out the companies that make the products you love!';
  }

  bool get isWatchlistComplete =>
      watchlistStep >= onboardingData.detectedCompanies.length;

  String get watchlistTitle =>
      isWatchlistComplete ? 'Added to Watchlist' : 'Adding to Watchlist';

  String get watchlistSubtitle {
    final count = onboardingData.detectedCompanies.length;
    final companyText = count == 1 ? 'company' : 'companies';
    return isWatchlistComplete
        ? 'Added the $companyText Bizzie found to your personal watchlist.'
        : 'Adding the $companyText Bizzie found to your personal watchlist.';
  }

  AnalysisStepStatus getWatchlistItemStatus(int index) {
    if (index < watchlistStep) return AnalysisStepStatus.completed;
    if (index == watchlistStep) return AnalysisStepStatus.active;
    if (index == watchlistStep) return AnalysisStepStatus.active;
    return AnalysisStepStatus.pending;
  }

  String get notificationTicker =>
      onboardingData.detectedCompanies.firstOrNull?.ticker ?? 'NVDA';

  String get notificationCompanyName =>
      onboardingData.detectedCompanies.firstOrNull?.name ?? 'NVIDIA';

  List<Brand> get dailyPicksDisplayBrands {
    return BrandDisplayHelper.getDailyPicksDisplayBrands(selectedBrands);
  }

  String get greetingName =>
      onboardingData.firstName.isEmpty ? 'Friend' : onboardingData.firstName;

  String get displaySectorName {
    final sector = onboardingData.selectedSector;
    if (sector == null) return '';
    final viewModel = availableSectors.firstWhere(
      (s) => s.sector == sector,
      orElse: () =>
          SectorViewModel(sector: sector, displayName: '', description: ''),
    );
    return viewModel.displayName;
  }

  String get mascotAsset {
    final sector = onboardingData.selectedSector;
    return sector != null
        ? OnboardingAssetsHelper.getMascotForSector(sector)
        : AppAssets.defaultMascot;
  }
}
