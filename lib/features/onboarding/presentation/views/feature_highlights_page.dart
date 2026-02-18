import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/core/analytics/onboarding_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/feature_highlights/feature_highlight_factory.dart';

import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class FeatureHighlightsPage extends StatefulWidget {
  const FeatureHighlightsPage({super.key});

  @override
  State<FeatureHighlightsPage> createState() => _FeatureHighlightsPageState();
}

class _FeatureHighlightsPageState extends State<FeatureHighlightsPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.featureHighlights),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listenWhen: (previous, current) {
        return previous.currentHighlightIndex !=
                current.currentHighlightIndex ||
            current.shouldNavigateToCreateAccount ||
            current.shouldNavigateToBuildingProfile;
      },
      listener: (context, state) {
        if (state.shouldNavigateToCreateAccount) {
          context.go(AppRoutes.createAccount);
        } else if (state.shouldNavigateToBuildingProfile) {
          context.go(AppRoutes.onboardingBuildingProfile);
        } else if (_pageController.hasClients &&
            _pageController.page?.round() != state.currentHighlightIndex) {
          _pageController.animateToPage(
            state.currentHighlightIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        final items = state.featureHighlights;
        final currentIndex = state.currentHighlightIndex;

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                OnboardingHeader(
                  onBackPressed: () => context.pop(),
                  trailing: const _SkipButton(),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Column(
                    children: [
                      _HighlightsCarousel(
                        pageController: _pageController,
                        items: items,
                        state: state,
                      ),
                      const SizedBox(height: 24),
                      _PageIndicators(
                        itemCount: items.length,
                        currentIndex: currentIndex,
                      ),
                    ],
                  ),
                ),
                if (items.isNotEmpty)
                  OnboardingFooter(
                    shiftDown: true,
                    fixedTextHeight: 160,
                    title: items[currentIndex].title,
                    subtitle: items[currentIndex].description,
                    primaryButton: _ContinueButton(
                      isLastPage: currentIndex >= items.length - 1,
                    ),
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<OnboardingBloc>().add(
        const OnboardingEvent.highlightSkipPressed(),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.slate100,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          'Skip',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.brandChipOtherForeground,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _HighlightsCarousel extends StatelessWidget {
  final PageController pageController;
  final List<dynamic> items;
  final OnboardingState state;

  const _HighlightsCarousel({
    required this.pageController,
    required this.items,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: items.length,
        onPageChanged: (index) {
          context.read<OnboardingBloc>().add(
            OnboardingEvent.highlightPageChanged(index),
          );
        },
        itemBuilder: (context, index) {
          final item = items[index];
          return SizedBox(
            width: double.infinity,
            child: FeatureHighlightFactory.buildIllustration(item.type, state),
          );
        },
      ),
    );
  }
}

class _PageIndicators extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const _PageIndicators({required this.itemCount, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(itemCount, (index) {
          final isSelected = currentIndex == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(right: 12),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.slate200,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final bool isLastPage;

  const _ContinueButton({required this.isLastPage});

  @override
  Widget build(BuildContext context) {
    return BizziePrimaryButton(
      onPressed: () => context.read<OnboardingBloc>().add(
        const OnboardingEvent.highlightContinuePressed(),
      ),
      title: isLastPage ? 'Continue' : 'Next',
    );
  }
}
