import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/routes/app_routes.dart';

class NameYourFavoriteBrandsPage extends StatefulWidget {
  const NameYourFavoriteBrandsPage({super.key});

  @override
  State<NameYourFavoriteBrandsPage> createState() =>
      _NameYourFavoriteBrandsPageState();
}

class _NameYourFavoriteBrandsPageState
    extends State<NameYourFavoriteBrandsPage> {
  final TextEditingController _customBrandController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load brands when entering the page
    context.read<OnboardingBloc>().add(const OnboardingEvent.loadBrands());

    // Listen to controller
    _customBrandController.addListener(() {
      context.read<OnboardingBloc>().add(
        OnboardingEvent.updateCustomBrandInput(_customBrandController.text),
      );
    });
  }

  @override
  void dispose() {
    _customBrandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final selectedSectorName =
            state.onboardingData.selectedSector?.displayName ?? 'Your Sector';

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Image.asset(AppAssets.backArrowIcon, width: 24, height: 24),
              onPressed: () => context.pop(),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Name your favorite brands & products',
                        style: AppTextStyles.h2,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We\'ll tell you if they\'re public...',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Sector Specific Brands
                      if (state.onboardingData.selectedSector != null) ...[
                        Text(
                          'Popular $selectedSectorName brands',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: state.sectorBrands.map((brand) {
                            return _BrandChip(
                              brand: brand,
                              isSelected: state.selectedBrands.contains(brand),
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
                      Text(
                        'Other popular brands',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.globalBrands.map((brand) {
                          return _BrandChip(
                            brand: brand,
                            isSelected: state.selectedBrands.contains(brand),
                            onTap: () {
                              context.read<OnboardingBloc>().add(
                                OnboardingEvent.toggleBrand(brand),
                              );
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 32),
                      // Custom Input
                      TextField(
                        controller: _customBrandController,
                        style: AppTextStyles.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'Enter any other brand...',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textTertiary,
                          ),
                          filled: true,
                          fillColor: AppColors.inputBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // Bottom Button
              Padding(
                padding: EdgeInsets.fromLTRB(
                  24,
                  16,
                  24,
                  32 + MediaQuery.of(context).padding.bottom,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(
                        OnboardingEvent.uploadBrands(
                          _customBrandController.text,
                        ),
                      );
                      context.push(AppRoutes.onboardingAnalyzing);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Continue', style: AppTextStyles.button),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BrandChip extends StatelessWidget {
  final Brand brand;
  final bool isSelected;
  final VoidCallback onTap;

  const _BrandChip({
    required this.brand,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.inputBorder,
          ),
        ),
        child: Text(
          brand.name,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
