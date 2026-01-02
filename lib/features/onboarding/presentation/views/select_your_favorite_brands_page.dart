import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';

class SelectYourFavoriteBrandsPage extends StatefulWidget {
  const SelectYourFavoriteBrandsPage({super.key});

  @override
  State<SelectYourFavoriteBrandsPage> createState() =>
      _SelectYourFavoriteBrandsPageState();
}

class _SelectYourFavoriteBrandsPageState
    extends State<SelectYourFavoriteBrandsPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(const OnboardingEvent.loadBrands());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final selectedSectorName =
            state.onboardingData.selectedSector?.displayName ?? 'Your Sector';

        final availableSectorBrands = state.sectorBrands
            .where((b) => !state.selectedBrands.contains(b))
            .toList();
        final availableGlobalBrands = state.globalBrands
            .where((b) => !state.selectedBrands.contains(b))
            .toList();

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingHeader(
                  title: 'Select your favorite brands & products',
                  subtitle: 'Select up to 5. You can search for more later',
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),

                        if (state.selectedBrands.isNotEmpty)
                          _SelectedBrandsSection(
                            brands: state.selectedBrands,
                            onToggle: (brand) => context
                                .read<OnboardingBloc>()
                                .add(OnboardingEvent.toggleBrand(brand)),
                          ),

                        if (state.onboardingData.selectedSector != null &&
                            availableSectorBrands.isNotEmpty)
                          _SectorBrandsSection(
                            sectorName: selectedSectorName,
                            brands: availableSectorBrands,
                            onToggle: (brand) => context
                                .read<OnboardingBloc>()
                                .add(OnboardingEvent.toggleBrand(brand)),
                          ),

                        if (availableGlobalBrands.isNotEmpty)
                          _GlobalBrandsSection(
                            brands: availableGlobalBrands,
                            onToggle: (brand) => context
                                .read<OnboardingBloc>()
                                .add(OnboardingEvent.toggleBrand(brand)),
                          ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                OnboardingFooter(
                  primaryButton: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: state.selectedBrands.isNotEmpty
                          ? () {
                              context.push(AppRoutes.onboardingAnalyzing);
                            }
                          : null,
                      style: FilledButton.styleFrom(
                        disabledBackgroundColor: theme.colorScheme.primary
                            .withValues(alpha: 0.5),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Continue',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
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

class _SelectedBrandsSection extends StatelessWidget {
  final List<Brand> brands;
  final ValueChanged<Brand> onToggle;

  const _SelectedBrandsSection({required this.brands, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your brands',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          children: brands.map((brand) {
            return _BrandChip(
              brand: brand,
              backgroundColor: AppColors.brandChipSelectedBackground,
              foregroundColor: AppColors.mascotSubtitle,
              iconData: Icons.close,
              onTap: () => onToggle(brand),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _SectorBrandsSection extends StatelessWidget {
  final String sectorName;
  final List<Brand> brands;
  final ValueChanged<Brand> onToggle;

  const _SectorBrandsSection({
    required this.sectorName,
    required this.brands,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular $sectorName brands',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          children: brands.map((brand) {
            return _BrandChip(
              brand: brand,
              backgroundColor: AppColors.mascotBackground,
              foregroundColor: AppColors.mascotSubtitle,
              borderColor: AppColors.brandChipSectorBorder,
              iconData: Icons.add,
              onTap: () => onToggle(brand),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _GlobalBrandsSection extends StatelessWidget {
  final List<Brand> brands;
  final ValueChanged<Brand> onToggle;

  const _GlobalBrandsSection({required this.brands, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other popular brands',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          children: brands.map((brand) {
            return _BrandChip(
              brand: brand,
              backgroundColor: AppColors.slate100,
              foregroundColor: AppColors.brandChipOtherForeground,
              iconData: Icons.add,
              onTap: () => onToggle(brand),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _BrandChip extends StatelessWidget {
  final Brand brand;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final IconData iconData;
  final VoidCallback onTap;

  const _BrandChip({
    required this.brand,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.iconData,
    required this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 0.665)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData == Icons.add) ...[
              Icon(iconData, size: 20, color: foregroundColor),
              Text(
                brand.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ] else ...[
              Text(
                brand.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(iconData, size: 20, color: foregroundColor),
            ],
          ],
        ),
      ),
    );
  }
}
