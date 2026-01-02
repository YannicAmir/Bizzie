import 'dart:async';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import '../widgets/onboarding_header.dart';

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
  late _CarouselAutoScroller _autoScroller;

  @override
  void initState() {
    super.initState();

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

    _pageController = PageController();
    _autoScroller = _CarouselAutoScroller(_pageController);
    _autoScroller.start();
  }

  void _onLoadingComplete() {
    _autoScroller.stop();
    context.go(AppRoutes.onboardingProfileReady);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pageController.dispose();
    _autoScroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final selectedSector = state.onboardingData.selectedSector;
        final experience = state.onboardingData.investingExperience;
        final brandsCount = state.selectedBrands.length;

        final carouselItems = [
          _ProfileItemData(
            iconAsset: AppAssets.favoriteSectorIcon,
            title: selectedSector?.displayName ?? 'Your Sector',
            subtitle: 'Favorite Sector',
            gradientColors: [const Color(0xFF2B7FFF), const Color(0xFF155DFC)],
          ),
          _ProfileItemData(
            iconAsset: AppAssets.investorClassificationIcon,
            title:
                experience?.name.toUpperCase() ?? 'INVESTOR', // e.g., BEGINNER
            subtitle: 'Investor Classification',
            gradientColors: [const Color(0xFF2B7FFF), const Color(0xFF155DFC)],
          ),
          _ProfileItemData(
            iconAsset: AppAssets.favoriteBrandsIcon,
            title: '$brandsCount',
            subtitle: 'Favorite Brands Count',
            gradientColors: [const Color(0xFF2B7FFF), const Color(0xFF155DFC)],
          ),
        ];

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                const OnboardingHeader(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ProfileCarousel(
                        pageController: _pageController,
                        carouselItems: carouselItems,
                      ),
                      const SizedBox(height: 48),
                      _ProfileCreationProgress(
                        progressAnimation: _progressAnimation,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        '   ${(_progressAnimation.value * 100).toInt()}%',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          height: 1.5,
                          letterSpacing: -0.449,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 56),
                    ],
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

class _CarouselAutoScroller {
  final PageController pageController;
  Timer? _timer;
  int _currentPage = 0;

  _CarouselAutoScroller(this.pageController);

  void start() {
    _timer = Timer.periodic(const Duration(milliseconds: 1600), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (pageController.hasClients) {
        pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void dispose() {
    stop();
  }
}

class _ProfileCarousel extends StatelessWidget {
  final PageController pageController;
  final List<_ProfileItemData> carouselItems;

  const _ProfileCarousel({
    required this.pageController,
    required this.carouselItems,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: carouselItems.length,
        itemBuilder: (context, index) {
          final item = carouselItems[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _ProfileCarouselItem(item: item),
          );
        },
      ),
    );
  }
}

class _ProfileCarouselItem extends StatelessWidget {
  final _ProfileItemData item;

  const _ProfileCarouselItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBackground, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: item.gradientColors,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Image.asset(
                item.iconAsset,
                width: 24,
                height: 24,
                errorBuilder: (c, o, s) => const Icon(
                  Icons.check_circle,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                Text(
                  item.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.5,
                    letterSpacing: -0.3125,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCreationProgress extends StatelessWidget {
  final Animation<double> progressAnimation;

  const _ProfileCreationProgress({required this.progressAnimation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: 340,
        height: 340,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 340,
              height: 340,
              child: CircularProgressIndicator(
                value: progressAnimation.value,
                strokeWidth: 15,
                backgroundColor: AppColors.slate100,
                color: AppColors.primary,
                strokeCap: StrokeCap.round,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                'Building your profile',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.2,
                  letterSpacing: 0.383,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileItemData {
  final String iconAsset;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;

  const _ProfileItemData({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
  });
}
