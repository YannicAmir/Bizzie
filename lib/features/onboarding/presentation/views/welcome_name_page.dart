import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/themes/app_assets.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text_styles.dart';
import '../bloc/onboarding_bloc.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';

class WelcomeNamePage extends StatelessWidget {
  const WelcomeNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final firstName = state.onboardingData.firstName;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnboardingHeader(
                  progressIndicator: LinearProgressIndicator(
                    value: 2 / 14,
                    backgroundColor: AppColors.slate200,
                    color: AppColors.primary,
                    minHeight: 4,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Spacer(),

                      // Mascot
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Image.asset(
                          AppAssets.onboardingBizzieMascotWelcome,
                          height: 238, // Reduced by 15% (280 * 0.85)
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Text Content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Rich Text for "Glad you joined us, Name !"
                            RichText(
                              text: TextSpan(
                                style: AppTextStyles.h1.copyWith(
                                  fontSize: 40,
                                  height: 1.2,
                                  letterSpacing: 0.406,
                                ),
                                children: [
                                  const TextSpan(text: 'Glad you joined us,\n'),
                                  TextSpan(
                                    text: firstName,
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                  const TextSpan(text: '!'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Let's take on the Stock Market together",
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
                // Footer
                OnboardingFooter(
                  primaryButton: FilledButton(
                    onPressed: () {
                      // Navigate to Sectors page
                      context.push(AppRoutes.onboardingSectors);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: AppTextStyles.button.copyWith(color: Colors.white),
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
