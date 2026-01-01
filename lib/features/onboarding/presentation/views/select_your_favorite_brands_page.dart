import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_colors.dart';
// import 'package:bizzie/app/themes/app_assets.dart'; // Unused now
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
  // Removed _customBrandController as requested

  @override
  void initState() {
    super.initState();
    // Load brands when entering the page
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
        final selectedSectorName =
            state.onboardingData.selectedSector?.displayName ?? 'Your Sector';

        // Filter out selected brands from the lists so they move to "Your brands"
        final availableSectorBrands = state.sectorBrands
            .where((b) => !state.selectedBrands.contains(b))
            .toList();
        final availableGlobalBrands = state.globalBrands
            .where((b) => !state.selectedBrands.contains(b))
            .toList();

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingHeader(
                  progressIndicator: LinearProgressIndicator(
                    value: 5 / 14,
                    backgroundColor: AppColors.slate200,
                    color: AppColors.primary,
                    minHeight: 4,
                  ),
                  title: 'Select your favorite brands & product',
                  subtitle: 'Select up to 5. You can search for more later',
                  // No back button as requested
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),

                        // YOUR BRANDS Section (Only if selections exist)
                        if (state.selectedBrands.isNotEmpty) ...[
                          Text(
                            'Your brands',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.start,
                            children: state.selectedBrands.map((brand) {
                              return _BrandChip(
                                brand: brand,
                                backgroundColor: const Color(0xFFDBEAFE),
                                foregroundColor: const Color(0xFF1447E6),
                                iconData: Icons.close,
                                onTap: () {
                                  context.read<OnboardingBloc>().add(
                                    OnboardingEvent.toggleBrand(brand),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 32),
                        ],

                        // Sector Specific Brands
                        if (state.onboardingData.selectedSector != null &&
                            availableSectorBrands.isNotEmpty) ...[
                          Text(
                            'Popular $selectedSectorName brands',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.start,
                            children: availableSectorBrands.map((brand) {
                              return _BrandChip(
                                brand: brand,
                                backgroundColor: const Color(0xFFEFF6FF),
                                foregroundColor: const Color(0xFF1447E6),
                                borderColor: const Color(0xFFBEDBFF),
                                iconData: Icons.add,
                                onTap: () {
                                  context.read<OnboardingBloc>().add(
                                    OnboardingEvent.toggleBrand(brand),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Other Global Brands
                        if (availableGlobalBrands.isNotEmpty) ...[
                          Text(
                            'Other popular brands',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.start,
                            children: availableGlobalBrands.map((brand) {
                              return _BrandChip(
                                brand: brand,
                                backgroundColor: const Color(0xFFF1F5F9),
                                foregroundColor: const Color(0xFF314158),
                                iconData: Icons.add,
                                onTap: () {
                                  context.read<OnboardingBloc>().add(
                                    OnboardingEvent.toggleBrand(brand),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ],

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
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: AppColors.primary.withValues(
                          alpha: 0.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Continue',
                        style: AppTextStyles.button.copyWith(
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
                style: AppTextStyles.bodyMedium.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ] else ...[
              Text(
                brand.name,
                style: AppTextStyles.bodyMedium.copyWith(
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
