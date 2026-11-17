import 'dart:async';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_assets_helper.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_skip_overlay.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/models/sector_view_model.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const _mascotSwitchDuration = Duration(milliseconds: 300);
const _chipAnimationDuration = Duration(milliseconds: 200);
const _defaultMascotKey = 'default';

class SectorSelectionPage extends StatefulWidget {
  const SectorSelectionPage({super.key});

  @override
  State<SectorSelectionPage> createState() => _SectorSelectionPageState();
}

class _SectorSelectionPageState extends State<SectorSelectionPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.sectorSelection),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      buildWhen: _hasSectorSelectionChanged,
      builder: (context, state) {
        final selectedSector = state.onboardingData.selectedSector;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: OnboardingSkipOverlay(
              step: OnboardingStep.sectorSelection,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const OnboardingHeader(
                    title: "Select the sector that interests you most",
                    subtitle:
                        "Your favorite sector can be changed in your profile",
                  ),
                  AppConstants.onboardSectionSpacing,
                  _SectorMascotSection(selectedSector: selectedSector),
                  AppConstants.onboardSectionSpacing,
                  Expanded(
                    child: _SectorListSection(
                      isLoading: state.isLoadingSectors,
                      sectors: state.availableSectors,
                      selectedSector: selectedSector,
                    ),
                  ),
                  OnboardingFooter(
                    primaryButton: BizziePrimaryButton(
                      onPressed: selectedSector != null
                          ? _onContinuePressed
                          : null,
                      title: 'Continue',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _hasSectorSelectionChanged(
    OnboardingState previous,
    OnboardingState current,
  ) =>
      previous.onboardingData.selectedSector !=
          current.onboardingData.selectedSector ||
      previous.availableSectors != current.availableSectors ||
      previous.isLoadingSectors != current.isLoadingSectors;

  void _onContinuePressed() {
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.brandsPrefetchRequested(),
    );
    unawaited(context.push(AppRoutes.onboardingBrands));
  }
}

class _SectorMascotSection extends StatelessWidget {
  final Sector? selectedSector;

  const _SectorMascotSection({required this.selectedSector});

  @override
  Widget build(BuildContext context) {
    final mascotHeight =
        MediaQuery.of(context).size.height *
        AppConstants.onboardMascotScreenHeightFactor;

    return Center(
      child: SizedBox(
        height: mascotHeight,
        child: AnimatedSwitcher(
          duration: _mascotSwitchDuration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: _SectorMascot(
            key: ValueKey(selectedSector?.name ?? _defaultMascotKey),
            sector: selectedSector,
            height: mascotHeight,
          ),
        ),
      ),
    );
  }
}

class _SectorMascot extends StatelessWidget {
  final Sector? sector;
  final double height;

  const _SectorMascot({super.key, required this.sector, required this.height});

  @override
  Widget build(BuildContext context) {
    final sector = this.sector;
    if (sector == null) {
      return Image.asset(
        AppAssets.defaultMascot,
        height: height,
        fit: BoxFit.contain,
      );
    }

    return Transform.translate(
      offset: OnboardingAssetsHelper.getMascotOffsetForSector(sector),
      child: Image.asset(
        OnboardingAssetsHelper.getMascotForSector(sector),
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _SectorListSection extends StatelessWidget {
  final bool isLoading;
  final List<SectorViewModel> sectors;
  final Sector? selectedSector;

  const _SectorListSection({
    required this.isLoading,
    required this.sectors,
    required this.selectedSector,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppConstants.onboardHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectorList(
              isLoading: isLoading,
              sectors: sectors,
              selectedSector: selectedSector,
              onSectorSelected: (sector) => _onSectorSelected(context, sector),
            ),
            AppConstants.onboardSectionSpacing,
          ],
        ),
      ),
    );
  }

  void _onSectorSelected(BuildContext context, Sector sector) {
    unawaited(HapticFeedback.lightImpact());
    context.read<OnboardingBloc>().add(OnboardingEvent.sectorSelected(sector));
  }
}

class _SectorList extends StatelessWidget {
  final bool isLoading;
  final List<SectorViewModel> sectors;
  final Sector? selectedSector;
  final ValueChanged<Sector> onSectorSelected;

  const _SectorList({
    required this.isLoading,
    required this.sectors,
    required this.selectedSector,
    required this.onSectorSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Wrap(
      spacing: AppConstants.onboardSectorChipSpacing,
      runSpacing: AppConstants.onboardSectorChipSpacing,
      children: sectors.map((viewModel) {
        return _SectorChip(
          viewModel: viewModel,
          isSelected: viewModel.sector == selectedSector,
          onTap: () => onSectorSelected(viewModel.sector),
        );
      }).toList(),
    );
  }
}

class _SectorChip extends StatelessWidget {
  final SectorViewModel viewModel;
  final bool isSelected;
  final VoidCallback onTap;

  const _SectorChip({
    required this.viewModel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();
    final borderRadius = BorderRadius.circular(
      AppConstants.onboardSectorChipBorderRadius,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: AnimatedContainer(
        duration: _chipAnimationDuration,
        padding: AppConstants.onboardSectorChipPadding,
        decoration: BoxDecoration(
          color: isSelected
              ? badgeTheme?.neutralBackground
              : theme.colorScheme.tertiaryContainer,
          borderRadius: borderRadius,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
            width: AppConstants.onboardSectorChipBorderWidth,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SectorCheckbox(isSelected: isSelected),
            AppConstants.subSectionHorizontalSpacing,
            Text(viewModel.displayName, style: AppTextStyles.bodyMediumBold),
          ],
        ),
      ),
    );
  }
}

class _SectorCheckbox extends StatelessWidget {
  final bool isSelected;

  const _SectorCheckbox({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: AppConstants.onboardSectorCheckboxSize,
      height: AppConstants.onboardSectorCheckboxSize,
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primary : colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppConstants.onboardSectorCheckboxBorderRadius,
        ),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: AppConstants.onboardSectorChipBorderWidth,
        ),
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              size: AppConstants.onboardSectorCheckIconSize,
              color: colorScheme.surface,
            )
          : null,
    );
  }
}
