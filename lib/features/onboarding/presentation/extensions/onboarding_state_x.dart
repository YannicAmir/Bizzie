import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:bizzie/features/onboarding/presentation/models/profile_summary_item.dart';

extension OnboardingStateX on OnboardingState {
  bool get isOnLastHighlight =>
      currentHighlightIndex >= featureHighlights.length - 1;

  List<ProfileSummaryItem> get profileSummaryItems => [
    ProfileSummaryItem(
      iconAsset: AppAssets.favoriteSectorIcon,
      title: displaySectorName,
      subtitle: 'Favorite Sector',
    ),
    ProfileSummaryItem(
      iconAsset: AppAssets.investorClassificationIcon,
      title:
          onboardingData.investingExperience?.name.toUpperCase() ?? 'INVESTOR',
      subtitle: 'Investor Classification',
    ),
    ProfileSummaryItem(
      iconAsset: AppAssets.favoriteBrandsIcon,
      title: '${selectedBrands.length}',
      subtitle: 'Favorite Brands Count',
    ),
  ];
}
