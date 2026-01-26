import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';

import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_header.dart';

class InvestingExperiencePage extends StatelessWidget {
  const InvestingExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final selectedExperience = state.onboardingData.investingExperience;
        final theme = Theme.of(context);

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                const OnboardingHeader(
                  title: 'Describe your investing experience',
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 48),
                        const _InvestingExperienceMascot(),
                        const Spacer(),
                        _ExperienceOptionsList(
                          selectedExperience: selectedExperience,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                _ContinueButton(selectedExperience: selectedExperience),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InvestingExperienceMascot extends StatelessWidget {
  const _InvestingExperienceMascot();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.onboardingBizzieMascotInvestingExperience,
        height: 230,
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
        _ExperienceOption(
          title: "Expert",
          description: "I'm an experienced investor",
          iconPath: AppAssets.arrowUpIcon,
          isSelected: selectedExperience == InvestingExperience.expert,
          onTap: () => context.read<OnboardingBloc>().add(
            const OnboardingEvent.experienceSelected(
              InvestingExperience.expert,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _ExperienceOption(
          title: "Intermediate",
          description: "I have some experience",
          iconPath: AppAssets.barChartIcon,
          isSelected: selectedExperience == InvestingExperience.intermediate,
          onTap: () => context.read<OnboardingBloc>().add(
            const OnboardingEvent.experienceSelected(
              InvestingExperience.intermediate,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _ExperienceOption(
          title: "Beginner",
          description: "I'm new to investing",
          iconPath: AppAssets.sparkleIcon,
          isSelected: selectedExperience == InvestingExperience.beginner,
          onTap: () => context.read<OnboardingBloc>().add(
            const OnboardingEvent.experienceSelected(
              InvestingExperience.beginner,
            ),
          ),
        ),
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
              ? () {
                  context.push(AppRoutes.onboardingFeatureHighlights);
                }
              : null,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
          ),
          child: Text(
            'Continue',
            style: theme.textTheme.labelLarge?.copyWith(color: Colors.white),
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mascotBackground : theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.outline, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  iconPath,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
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
