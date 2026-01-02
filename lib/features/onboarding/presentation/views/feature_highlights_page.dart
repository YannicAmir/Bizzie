import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/feature_highlights/feature_highlight_factory.dart';

class FeatureHighlightsPage extends StatefulWidget {
  const FeatureHighlightsPage({super.key});

  @override
  State<FeatureHighlightsPage> createState() => _FeatureHighlightsPageState();
}

class _FeatureHighlightsPageState extends State<FeatureHighlightsPage> {
  final PageController _pageController = PageController();

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
            current.shouldNavigateToCreateAccount;
      },
      listener: (context, state) {
        if (state.shouldNavigateToCreateAccount) {
          context.go(AppRoutes.createAccount);
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
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Top Bar with Skip (Replaced by OnboardingHeader)
                OnboardingHeader(
                  onBackPressed: () => context.pop(),
                  trailing: GestureDetector(
                    onTap: () => context.read<OnboardingBloc>().add(
                      const OnboardingEvent.highlightSkipPressed(),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
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
                  ),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: Column(
                    children: [
                      // Illustration Carousel
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
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
                              child: FeatureHighlightFactory.buildIllustration(
                                item.type,
                                state,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Numbered Indicators (Left Aligned)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(items.length, (index) {
                            final isSelected = currentIndex == index;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 12),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.slate200,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: isSelected
                                        ? AppColors.white
                                        : AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                // Footer with Content and Button
                if (items.isNotEmpty)
                  OnboardingFooter(
                    shiftDown: true,
                    fixedTextHeight: 160,
                    title: items[currentIndex].title,
                    subtitle: items[currentIndex].description,
                    primaryButton: ElevatedButton(
                      onPressed: () => context.read<OnboardingBloc>().add(
                        const OnboardingEvent.highlightContinuePressed(),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        currentIndex < items.length - 1 ? 'Next' : 'Continue',
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.white,
                        ),
                      ),
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
