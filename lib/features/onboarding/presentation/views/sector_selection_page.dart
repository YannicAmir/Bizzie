import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/themes/app_assets.dart';
import '../../../../app/themes/app_colors.dart';

import '../utils/onboarding_assets_helper.dart';
import '../bloc/onboarding_bloc.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';
import '../../domain/models/sector.dart';

class SectorSelectionPage extends StatefulWidget {
  const SectorSelectionPage({super.key});

  @override
  State<SectorSelectionPage> createState() => _SectorSelectionPageState();
}

class _SectorSelectionPageState extends State<SectorSelectionPage> {
  // Moved _buildMascot to _SectorMascot class at bottom of file

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

                const SizedBox(height: 32),

                // Mascot Display Area
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

                const SizedBox(height: 32),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sectors Wrap
                          if (state.isLoadingSectors)
                            const Center(child: CircularProgressIndicator())
                          else
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: sectors.map((sector) {
                                final isSelected = sector == selectedSector;
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      context.read<OnboardingBloc>().add(
                                        OnboardingEvent.sectorSelected(sector),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(100),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 12.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.mascotBackground
                                            : AppColors.inputBackground,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors.inputBorder,
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Checkbox
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                color: isSelected
                                                    ? theme.colorScheme.primary
                                                    : AppColors.inputBorder,
                                                width: 2,
                                              ),
                                            ),
                                            child: isSelected
                                                ? const Icon(
                                                    Icons.check,
                                                    size: 14,
                                                    color: Colors.white,
                                                  )
                                                : null,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            sector.displayName,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  color: AppColors.textPrimary,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),

                // Footer
                OnboardingFooter(
                  primaryButton: FilledButton(
                    onPressed: selectedSector != null
                        ? () {
                            // Navigate to Meet Your Bizzie Page
                            context.push(AppRoutes.onboardingMeetBizzie);
                          }
                        : null,
                    style: FilledButton.styleFrom(
                      disabledBackgroundColor: theme.colorScheme.primary
                          .withValues(alpha: 0.5),
                    ),
                    child: Text(
                      'Continue',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
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
      key: ValueKey(sector!.name), // Unique key for AnimatedSwitcher
    );

    // Apply Offsets
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

    // Apply Padding
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
