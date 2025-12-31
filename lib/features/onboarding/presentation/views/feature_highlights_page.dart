import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';

class FeatureHighlightsPage extends StatefulWidget {
  const FeatureHighlightsPage({super.key});

  @override
  State<FeatureHighlightsPage> createState() => _FeatureHighlightsPageState();
}

class _FeatureHighlightsPageState extends State<FeatureHighlightsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<_CarouselItem> _getExpertItems() {
    return const [
      _CarouselItem(
        title: 'Experts will love...',
        description:
            'View the full financial history of Apple and other companies',
        illustration: _HistoryIllustration(),
      ),
      _CarouselItem(
        title: 'Experts will love...',
        description:
            'Never miss quarterly or annual report releases from your watchlist',
        illustration: _NotificationIllustration(),
      ),
      _CarouselItem(
        title: 'Experts will love...',
        description:
            'Deep dive into 10-K and 10-Q reports with AI-powered summaries',
        illustration: _SummaryIllustration(),
      ),
    ];
  }

  List<_CarouselItem> _getIntermediateItems() {
    return const [
      _CarouselItem(
        title: 'See the big picture',
        description: 'Visualize Apple and other company financials at a glance',
        illustration: _HistoryIllustration(),
      ),
      _CarouselItem(
        title: 'Find what you love',
        description: 'Easily find stocks by searching for your favorite brands',
        illustration: _SearchBrandsIllustration(),
      ),
      _CarouselItem(
        title: 'Insights made easy',
        description:
            'Bizzie analyzes full reports and summarizes with quick insights',
        illustration: _SummaryIllustration(),
      ),
    ];
  }

  List<_CarouselItem> _getBeginnerItems() {
    return const [
      _CarouselItem(
        title: 'Learn the basics',
        description: 'Bizzie makes complex topics easy to understand',
        illustration: _SummaryIllustration(),
      ),
      _CarouselItem(
        title: 'Find what you love',
        description:
            'Easily find stocks by searching for your favorite brands & products',
        illustration: _SearchBrandsIllustration(),
      ),
      _CarouselItem(
        title: 'Start your day right',
        description:
            'Get a daily list of stocks to explore--personalized just for you',
        illustration: _DailyListIllustration(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final experience = state.onboardingData.investingExperience;

        List<_CarouselItem> items;
        switch (experience) {
          case InvestingExperience.expert:
            items = _getExpertItems();
            break;
          case InvestingExperience.intermediate:
            items = _getIntermediateItems();
            break;
          case InvestingExperience.beginner:
          default:
            items = _getBeginnerItems();
            break;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Top Bar with Skip
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => context.go(AppRoutes.createAccount),
                        child: Text(
                          'Skip',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: items.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _CarouselSlide(item: items[index]);
                    },
                  ),
                ),

                // Pagination Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(items.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? AppColors.primary
                            : AppColors.slate200,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),

                // Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < items.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Navigate next
                          // context.go(AppRoutes.onboardingRegister); // Future step
                          // For now just loop or stay? OR go to home if done?
                          // Usually this leads to Account Creation or Login
                          // Let's assume creating account for now
                          context.go(AppRoutes.createAccount);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage < items.length - 1
                            ? 'Next'
                            : 'Get Started',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CarouselItem {
  final String title;
  final String description;
  final Widget illustration;

  const _CarouselItem({
    required this.title,
    required this.description,
    required this.illustration,
  });
}

class _CarouselSlide extends StatelessWidget {
  final _CarouselItem item;

  const _CarouselSlide({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          SizedBox(
            width: double.infinity,
            height: 300,
            child: item.illustration,
          ),
          const SizedBox(height: 48),
          Text(
            item.title,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            item.description,
            style: AppTextStyles.h1.copyWith(fontSize: 28, height: 1.2),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// --- Illustration Widgets ---

class _HistoryIllustration extends StatelessWidget {
  const _HistoryIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Simulated Bar Chart
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _Bar(height: 80, color: AppColors.slate200),
              const SizedBox(width: 12),
              _Bar(height: 120, color: AppColors.slate200),
              const SizedBox(width: 12),
              _Bar(
                height: 160,
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 12),
              _Bar(height: 200, color: AppColors.primary),
              const SizedBox(width: 12),
              _Bar(height: 140, color: AppColors.slate200),
            ],
          ),
          // Floating Label
          Positioned(
            top: 60,
            right: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                '+24%',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.green, // Positive growth
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double height;
  final Color color;

  const _Bar({required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class _SearchBrandsIllustration extends StatelessWidget {
  const _SearchBrandsIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fake Search Bar
            Container(
              width: 280,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.slate200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.textTertiary),
                  const SizedBox(width: 12),
                  Text(
                    'Search brands...',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Brand Chips
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _BrandChip(label: 'Apple', icon: Icons.apple),
                _BrandChip(label: 'Tesla', icon: Icons.electric_car),
                _BrandChip(
                  label: 'Nike',
                  icon: Icons.check_circle_outline,
                ), // Placeholder
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _BrandChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textPrimary),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyListIllustration extends StatelessWidget {
  const _DailyListIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Container(
          width: 240,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's Picks", style: AppTextStyles.h3),
              const SizedBox(height: 16),
              _ListItem(label: 'Tech Giants', color: Colors.blue),
              const SizedBox(height: 12),
              _ListItem(label: 'Green Energy', color: Colors.green),
              const SizedBox(height: 12),
              _ListItem(label: 'Top Gainers', color: Colors.orange),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String label;
  final Color color;

  const _ListItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.flash_on, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Container(height: 4, width: 60, color: AppColors.slate200),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: AppColors.slate200),
      ],
    );
  }
}

class _NotificationIllustration extends StatelessWidget {
  const _NotificationIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Container(
          width: 260,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_active,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Earnings Report',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tesla Inc. just released Q4',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryIllustration extends StatelessWidget {
  const _SummaryIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 180,
              height: 240,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12,
                    width: 80,
                    color: AppColors.slate200,
                    margin: const EdgeInsets.only(bottom: 16),
                  ),
                  Container(
                    height: 8,
                    width: double.infinity,
                    color: AppColors.slate100,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  Container(
                    height: 8,
                    width: double.infinity,
                    color: AppColors.slate100,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  Container(
                    height: 8,
                    width: 100,
                    color: AppColors.slate100,
                    margin: const EdgeInsets.only(bottom: 24),
                  ),

                  Container(
                    height: 12,
                    width: 60,
                    color: AppColors.slate200,
                    margin: const EdgeInsets.only(bottom: 16),
                  ),
                  Container(
                    height: 8,
                    width: double.infinity,
                    color: AppColors.slate100,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  Container(height: 8, width: 120, color: AppColors.slate100),
                ],
              ),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors
                      .amber, // Assuming secondary is a highlight color like yellow/gold, otherwise primary
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
