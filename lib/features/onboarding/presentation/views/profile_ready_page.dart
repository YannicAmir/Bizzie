import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_assets_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import '../widgets/onboarding_header.dart';

class ProfileReadyPage extends StatelessWidget {
  const ProfileReadyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final selectedSector = state.onboardingData.selectedSector;
        final firstName = state.onboardingData.firstName;

        // Determine mascot asset based on selection
        String mascotAsset = AppAssets.defaultMascot;
        if (selectedSector != null) {
          mascotAsset = OnboardingAssetsHelper.getMascotForSector(
            selectedSector,
          );
        }

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                const OnboardingHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(flex: 2),

                        // Mascot Image
                        Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: Image.asset(
                              mascotAsset,
                              height: 320,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const Spacer(flex: 1),

                        // Heading
                        RichText(
                          text: TextSpan(
                            style: theme.textTheme.displayLarge?.copyWith(
                              fontSize: 40,
                              height: 1.2,
                              letterSpacing: 0.37,
                              color: AppColors.textPrimary,
                            ),
                            children: [
                              const TextSpan(text: 'Your profile is ready, '),
                              TextSpan(
                                text: firstName,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const TextSpan(text: '!'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Description
                        Text(
                          'We have personalized Bizzie just for you. Let\'s get started!',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 17,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),

                        const Spacer(flex: 3),

                        // Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go(AppRoutes.home);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Continue',
                              style: theme.textTheme.labelLarge?.copyWith(
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
              ],
            ),
          ),
        );
      },
    );
  }
}
