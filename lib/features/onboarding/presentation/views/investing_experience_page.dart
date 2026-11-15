import 'dart:async';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/extensions/investing_experience_x.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_skip_overlay.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const _experienceDisplayOrder = [
  InvestingExperience.expert,
  InvestingExperience.intermediate,
  InvestingExperience.beginner,
];

class InvestingExperiencePage extends StatefulWidget {
  const InvestingExperiencePage({super.key});

  @override
  State<InvestingExperiencePage> createState() =>
      _InvestingExperiencePageState();
}

class _InvestingExperiencePageState extends State<InvestingExperiencePage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.investingExperience),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedExperience = context
        .select<OnboardingBloc, InvestingExperience?>(
          (bloc) => bloc.state.onboardingData.investingExperience,
        );
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: OnboardingSkipOverlay(
          step: OnboardingStep.investingExperience,
          child: Column(
            children: [
              const OnboardingHeader(
                title: 'Describe your investing experience',
              ),
              Expanded(
                child: _InvestingExperienceContent(
                  selectedExperience: selectedExperience,
                ),
              ),
              _ContinueButton(selectedExperience: selectedExperience),
            ],
          ),
        ),
      ),
    );
  }
}

class _InvestingExperienceContent extends StatelessWidget {
  final InvestingExperience? selectedExperience;

  const _InvestingExperienceContent({required this.selectedExperience});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: AppConstants.onboardHorizontalPadding,
                child: _InvestingExperienceBody(
                  selectedExperience: selectedExperience,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InvestingExperienceBody extends StatelessWidget {
  final InvestingExperience? selectedExperience;

  const _InvestingExperienceBody({required this.selectedExperience});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppConstants.onboardHeaderSpacing,
        const _InvestingExperienceMascot(),
        const Spacer(),
        _ExperienceOptionsList(selectedExperience: selectedExperience),
        AppConstants.mainSectionSpacing,
      ],
    );
  }
}

class _InvestingExperienceMascot extends StatelessWidget {
  const _InvestingExperienceMascot();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final responsiveHeight =
        screenHeight * AppConstants.onboardMascotScreenHeightFactor;

    return Center(
      child: Image.asset(
        AppAssets.onboardingBizzieMascotInvestingExperience,
        width: double.infinity,
        height: responsiveHeight,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _ExperienceOptionsList extends StatelessWidget {
  final InvestingExperience? selectedExperience;

  const _ExperienceOptionsList({required this.selectedExperience});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (index, experience) in _experienceDisplayOrder.indexed) ...[
          if (index > 0) AppConstants.onboardSecondarySectionSpacing,
          _ExperienceOption(
            title: experience.title,
            description: experience.description,
            iconPath: experience.iconPath,
            isSelected: selectedExperience == experience,
            onTap: () => context.read<OnboardingBloc>().add(
              OnboardingEvent.experienceSelected(experience),
            ),
          ),
        ],
      ],
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final InvestingExperience? selectedExperience;

  const _ContinueButton({required this.selectedExperience});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OnboardingFooter(
      primaryButton: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: selectedExperience != null
              ? () => unawaited(
                  context.push(AppRoutes.onboardingFeatureHighlights),
                )
              : null,
          style: FilledButton.styleFrom(
            disabledBackgroundColor: AppColors.primary.withValues(
              alpha: AppConstants.onboardContinueButtonDisabledAlpha,
            ),
            padding: AppConstants.onboardContinueButtonPadding,
          ),
          child: Text(
            'Continue',
            style: theme.textTheme.labelLarge?.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

class _ExperienceOption extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const _ExperienceOption({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppConstants.onboardExperienceOptionPadding,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mascotBackground : theme.cardColor,
          borderRadius: BorderRadius.circular(
            AppConstants.mainSectionBorderRadius,
          ),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
            width: AppConstants.onboardExperienceOptionBorderWidth,
          ),
        ),
        child: Row(
          children: [
            _ExperienceOptionIcon(iconPath: iconPath, isSelected: isSelected),
            AppConstants.onboardExperienceOptionContentSpacing,
            Expanded(
              child: _ExperienceOptionLabels(
                title: title,
                description: description,
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

class _ExperienceOptionIcon extends StatelessWidget {
  final String iconPath;
  final bool isSelected;

  const _ExperienceOptionIcon({
    required this.iconPath,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: AppConstants.onboardExperienceIconContainerSize,
      height: AppConstants.onboardExperienceIconContainerSize,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(
          color: theme.colorScheme.outline,
          width: AppConstants.onboardExperienceOptionBorderWidth,
        ),
      ),
      child: Padding(
        padding: AppConstants.onboardExperienceIconPadding,
        child: Image.asset(
          iconPath,
          width: AppConstants.onboardExperienceIconSize,
          height: AppConstants.onboardExperienceIconSize,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ExperienceOptionLabels extends StatelessWidget {
  final String title;
  final String description;

  const _ExperienceOptionLabels({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: AppTextStyles.bodyLargeBold.fontWeight,
          ),
        ),
        AppConstants.onboardExperienceTitleSpacing,
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
