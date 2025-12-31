import 'dart:async';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_assets.dart';

class BuildingProfilePage extends StatefulWidget {
  const BuildingProfilePage({super.key});

  @override
  State<BuildingProfilePage> createState() => _BuildingProfilePageState();
}

class _BuildingProfilePageState extends State<BuildingProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  late PageController _pageController;
  Timer? _carouselTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // 1. Progress Animation (0% -> 100% over 5 seconds)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _progressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_progressController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _onLoadingComplete();
            }
          });

    _progressController.forward();

    // 2. Carousel Auto-scroll setup
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _carouselTimer = Timer.periodic(const Duration(milliseconds: 1600), (
      timer,
    ) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onLoadingComplete() {
    _carouselTimer?.cancel();
    // Navigate to Profile Ready Page (or next step)
    context.go(AppRoutes.onboardingProfileReady);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pageController.dispose();
    _carouselTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final selectedSector = state.onboardingData.selectedSector;
        final experience = state.onboardingData.investingExperience;

        // Carousel Items Data
        final carouselItems = [
          _ProfileItemData(
            iconAsset: AppAssets.favoriteSectorIcon,
            title: selectedSector?.displayName ?? 'Your Sector',
            subtitle: 'Selected Sector',
          ),
          _ProfileItemData(
            iconAsset: AppAssets
                .investorClassificationIcon, // Need to add this asset or use placeholder
            title:
                experience?.name.toUpperCase() ?? 'INVESTOR', // e.g., Beginner
            subtitle: 'Investing Experience',
          ),
          const _ProfileItemData(
            iconAsset: AppAssets.favoriteBrandsIcon,
            title: 'Your Brands', // Could ideally list brands if available
            subtitle: 'Watchlist Created',
          ),
        ];

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // "Building your profile" Header
                Text(
                  'Building your profile',
                  style: AppTextStyles.h2.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 48),

                // Progress Indicator + Carousel Stack
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular Progress Indicator
                      SizedBox(
                        width: 280,
                        height: 280,
                        child: CircularProgressIndicator(
                          value: _progressAnimation.value,
                          strokeWidth: 12,
                          backgroundColor: AppColors.slate100,
                          color: AppColors.primary,
                          strokeCap: StrokeCap.round,
                        ),
                      ),

                      // Center Content (Carousel)
                      Container(
                        width: 220, // Inner circle size
                        height: 220,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          // Optional inner shadow or formatting
                        ),
                        child: PageView.builder(
                          controller: _pageController,
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable user swipe
                          itemCount: carouselItems.length,
                          itemBuilder: (context, index) {
                            final item = carouselItems[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item.iconAsset,
                                  height: 60,
                                  width: 60,
                                  errorBuilder: (c, o, s) => const Icon(
                                    Icons.check_circle,
                                    size: 60,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  item.title,
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  item.subtitle,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      // Percentage Text (Bottom positioned relative to circle)
                      Positioned(
                        bottom: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.slate200),
                          ),
                          child: Text(
                            '${(_progressAnimation.value * 100).toInt()}%',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileItemData {
  final String iconAsset;
  final String title;
  final String subtitle;

  const _ProfileItemData({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
  });
}
