import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';

class InvestingExperiencePage extends StatefulWidget {
  const InvestingExperiencePage({super.key});

  @override
  State<InvestingExperiencePage> createState() =>
      _InvestingExperiencePageState();
}

class _InvestingExperiencePageState extends State<InvestingExperiencePage> {
  // Local state to track selection before saving to Bloc on continue,
  // OR update Bloc immediately. Bloc is usually better for "source of truth".
  // However, "continue button enabled only when selection made" implies checking state.

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final selectedExperience = state.onboardingData.investingExperience;
        // Check if user has actually "touched"/selected this step?
        // The bloc initializes with 'beginner' based on the model default I saw earlier:
        // @Default(InvestingExperience.beginner) InvestingExperience investingExperience
        // This means it's always selected by default?
        // If the design requires "No selection made" initially, we might need to make it nullable in the model
        // OR just assume beginner is default.
        // The user prompt said: "no selection made view" vs "selection made view".
        // This implies it SHOULD be nullable or have a 'none' state.
        // Let's check OnboardingData again.

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // Back Button (Optional? Design usually has it)
                  // Figma screenshot had a back chevron
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.inputBorder),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  Text(
                    'Describe your\ninvesting experience',
                    style: AppTextStyles.h1,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'This helps us customize your Bizzie experience.',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Options
                  _ExperienceOption(
                    title: "I'm a beginner",
                    description: "I'm new to investing",
                    icon: Icons.grass, // Placeholder
                    isSelected:
                        selectedExperience == InvestingExperience.beginner,
                    onTap: () => context.read<OnboardingBloc>().add(
                      const OnboardingEvent.experienceSelected(
                        InvestingExperience.beginner,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ExperienceOption(
                    title: "Intermediate",
                    description: "I have some experience",
                    icon: Icons.trending_up, // Placeholder
                    isSelected:
                        selectedExperience == InvestingExperience.intermediate,
                    onTap: () => context.read<OnboardingBloc>().add(
                      const OnboardingEvent.experienceSelected(
                        InvestingExperience.intermediate,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ExperienceOption(
                    title: "I'm an expert",
                    description: "I'm an experienced investor",
                    icon: Icons.verified, // Placeholder
                    isSelected:
                        selectedExperience == InvestingExperience.expert,
                    onTap: () => context.read<OnboardingBloc>().add(
                      const OnboardingEvent.experienceSelected(
                        InvestingExperience.expert,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to next page
                        context.go(AppRoutes.onboardingFeatureHighlights);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ExperienceOption extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ExperienceOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF2B7FFF) : AppColors.inputBorder,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textTertiary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
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
