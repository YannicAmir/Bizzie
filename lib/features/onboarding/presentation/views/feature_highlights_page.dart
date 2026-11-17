import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/extensions/onboarding_state_x.dart';
import 'package:bizzie/features/onboarding/presentation/models/feature_highlight_item.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_skip_button.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/feature_highlights/feature_highlight_illustration.dart';
import '../widgets/onboarding_header.dart';

const _pageTransitionDuration = Duration(milliseconds: 300);
const _indicatorAnimationDuration = Duration(milliseconds: 300);

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
            duration: _pageTransitionDuration,
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                OnboardingHeader(
                  onBackPressed: () => context.pop(),
                  trailing: const OnboardingSkipButton(
                    step: OnboardingStep.featureHighlights,
                  ),
                ),
                AppConstants.mainSectionSpacing,
                _HighlightsBody(pageController: _pageController, state: state),
                if (state.featureHighlights.isNotEmpty)
                  _HighlightsFooter(
                    item: state.featureHighlights[state.currentHighlightIndex],
                    isLastPage: state.isOnLastHighlight,
                  ),
                AppConstants.onboardSecondarySectionSpacing,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HighlightsBody extends StatelessWidget {
  final PageController pageController;
  final OnboardingState state;

  const _HighlightsBody({required this.pageController, required this.state});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _HighlightsCarousel(pageController: pageController, state: state),
          AppConstants.mainSectionSpacing,
          _PageIndicators(
            itemCount: state.featureHighlights.length,
            currentIndex: state.currentHighlightIndex,
          ),
        ],
      ),
    );
  }
}

class _HighlightsCarousel extends StatelessWidget {
  final PageController pageController;
  final OnboardingState state;

  const _HighlightsCarousel({
    required this.pageController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final items = state.featureHighlights;

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
            child: FeatureHighlightIllustration(type: item.type, state: state),
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
      padding: AppConstants.onboardHorizontalPadding,
      child: Row(
        children: List.generate(
          itemCount,
          (index) => _PageIndicatorDot(
            index: index,
            isSelected: currentIndex == index,
          ),
        ),
      ),
    );
  }
}

class _PageIndicatorDot extends StatelessWidget {
  final int index;
  final bool isSelected;

  const _PageIndicatorDot({required this.index, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _indicatorAnimationDuration,
      margin: AppConstants.onboardHighlightIndicatorMargin,
      width: AppConstants.onboardHighlightIndicatorSize,
      height: AppConstants.onboardHighlightIndicatorSize,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.slate200,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: AppTextStyles.onboardingHighlightIndicator.copyWith(
            color: isSelected ? AppColors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _HighlightsFooter extends StatelessWidget {
  final FeatureHighlightItem item;
  final bool isLastPage;

  const _HighlightsFooter({required this.item, required this.isLastPage});

  @override
  Widget build(BuildContext context) {
    return OnboardingFooter(
      shiftDown: true,
      fixedTextHeight: AppConstants.onboardHighlightFooterTextHeight,
      title: item.title,
      subtitle: item.description,
      primaryButton: _ContinueButton(isLastPage: isLastPage),
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
