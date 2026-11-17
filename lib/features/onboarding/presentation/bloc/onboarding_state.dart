import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_field_sources.dart';
import 'package:bizzie/features/onboarding/domain/models/post_onboarding_destination.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/presentation/models/feature_highlight_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_assets_helper.dart';
import 'package:bizzie/features/onboarding/presentation/utils/brand_display_helper.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';

import 'package:bizzie/shared/models/sector_view_model.dart';

part 'onboarding_state.freezed.dart';

enum OnboardingStatus { initial, loading, success, failure, existingProfile }

enum OnboardingSkipStatus {
  initial,
  inProgress,
  success,
  failure,
  existingProfile,
}

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial({
    @Default(OnboardingData()) OnboardingData onboardingData,
    @Default(OnboardingStatus.initial) OnboardingStatus status,

    @Default(false) bool isSubmitting,
    @Default(false) bool isLoadingSectors,
    @Default(false) bool isLoadingHistory,

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
    @Default(false) bool didSubscribe,
    @Default('none') String subscriptionType,
    @Default(OnboardingSkipStatus.initial) OnboardingSkipStatus skipStatus,
    OnboardingStep? skippedAtStep,
    OnboardingFieldSources? skipFieldSources,
    PostOnboardingDestination? postOnboardingDestination,
    @Default(false) bool hasViewedCompanyProfile,
    String? savedProfileUid,
  }) = _OnboardingState;

  const OnboardingState._();

  String? get initialCompanyTicker => selectedBrands.firstOrNull?.ticker;

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
