import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_assets.dart';
import '../utils/onboarding_assets_helper.dart';

class MeetYourBizziePage extends StatefulWidget {
  const MeetYourBizziePage({super.key});

  @override
  State<MeetYourBizziePage> createState() => _MeetYourBizziePageState();
}

class _MeetYourBizziePageState extends State<MeetYourBizziePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final selectedSector = state.onboardingData.selectedSector;

        // Determine mascot asset based on selection
        String mascotAsset = AppAssets.defaultMascot;
        if (selectedSector != null) {
          mascotAsset = OnboardingAssetsHelper.getMascotForSector(
            selectedSector,
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                // Top Right Icon (from design)
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // Placeholder for the icon in the top left from Figma (1:239)
                    // It looks like a small back arrow or logo? Using back for now if needed,
                    // but design shows "Left: 16px".
                    // Figma design 1:240 is "Icon".
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                Padding(
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
                            height: 280,
                            fit: BoxFit.contain,
                            key: ValueKey(mascotAsset),
                          ),
                        ),
                      ),

                      const Spacer(flex: 1),

                      // Heading
                      Text(
                        'Got it! Meet your Bizzie',
                        style: AppTextStyles.h1.copyWith(
                          fontSize: 40,
                          height: 1.2,
                          letterSpacing: 0.37,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Description
                      Text(
                        '${selectedSector?.displayName ?? "Your"} Bizzie will send you a daily list of stocks & brands from your favorite sector.',
                        style: AppTextStyles.bodyLarge.copyWith(
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
                            // Navigate to Investing Experience Page
                            context.push(AppRoutes.onboardingExperience);
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
              ],
            ),
          ),
        );
      },
    );
  }
}
