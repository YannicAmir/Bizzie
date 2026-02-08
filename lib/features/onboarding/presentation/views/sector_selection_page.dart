import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/themes/app_assets.dart';

import '../utils/onboarding_assets_helper.dart';
import '../bloc/onboarding_bloc.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/interfaces/i_select_brands_repository.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/models/sector_view_model.dart';

class SectorSelectionPage extends StatelessWidget {
  const SectorSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final selectedSector = state.onboardingData.selectedSector;
        final sectors = state.availableSectors;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                OnboardingHeader(
                  title: "Select the sector that interests you most",
                  subtitle:
                      "Your favorite sector can be changed in your profile",
                  onBackPressed: null,
                ),
                AppConstants.onboardSectionSpacing,
                Center(
                  child: SizedBox(
                    height: 250,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                      child: _SectorMascot(
                        key: ValueKey(selectedSector?.name ?? 'default'),
                        sector: selectedSector,
                      ),
                    ),
                  ),
                ),
                AppConstants.onboardSectionSpacing,
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectorList(
                            isLoading: state.isLoadingSectors,
                            sectors: sectors,
                            selectedSector: selectedSector,
                            onSectorSelected: (sector) {
                              HapticFeedback.lightImpact();

                              context.read<OnboardingBloc>().add(
                                OnboardingEvent.sectorSelected(sector),
                              );
                            },
                          ),
                          AppConstants.onboardSectionSpacing,
                        ],
                      ),
                    ),
                  ),
                ),
                OnboardingFooter(
                  primaryButton: BizziePrimaryButton(
                    onPressed: selectedSector != null
                        ? () {
                            getIt<ISelectBrandsRepository>().getDailyBrands(
                              selectedSector,
                            );
                            context.push(AppRoutes.onboardingMeetBizzie);
                          }
                        : null,
                    title: 'Continue',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectorMascot extends StatelessWidget {
  final Sector? sector;

  const _SectorMascot({super.key, this.sector});

  @override
  Widget build(BuildContext context) {
    if (sector == null) {
      return Image.asset(
        AppAssets.defaultMascot,
        fit: BoxFit.contain,
        key: const ValueKey('default_mascot'),
      );
    }

    final asset = OnboardingAssetsHelper.getMascotForSector(sector!);

    Widget child = Image.asset(
      asset,
      fit: BoxFit.contain,
      key: ValueKey(sector!.name),
    );
    if (sector == Sector.financials) {
      child = Transform.translate(offset: const Offset(-7, 0), child: child);
    } else if (sector == Sector.communicationServices) {
      child = Transform.translate(offset: const Offset(6, 0), child: child);
    } else if (sector == Sector.consumerStaples) {
      child = Transform.translate(offset: const Offset(20, 0), child: child);
    } else if (sector == Sector.energy) {
      child = Transform.translate(offset: const Offset(-22, 0), child: child);
    } else if (sector == Sector.utilities) {
      child = Transform.translate(offset: const Offset(7, 0), child: child);
    }
    final sectorsWithPadding = [
      Sector.informationTechnology,
      Sector.financials,
      Sector.communicationServices,
      Sector.consumerDiscretionary,
      Sector.healthCare,
      Sector.consumerStaples,
    ];
    if (sectorsWithPadding.contains(sector)) {
      child = Padding(padding: const EdgeInsets.all(7.0), child: child);
    }
    return KeyedSubtree(key: ValueKey(sector!.name), child: child);
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
      spacing: 12,
      runSpacing: 12,
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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? badgeTheme?.neutralBackground
              : theme.colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 14,
                      color: theme.colorScheme.surface,
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              viewModel.displayName,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
