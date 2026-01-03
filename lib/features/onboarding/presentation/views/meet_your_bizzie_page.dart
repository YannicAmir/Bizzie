import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_assets.dart';
import '../utils/onboarding_assets_helper.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';

class MeetYourBizziePage extends StatelessWidget {
  const MeetYourBizziePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final selectedSector = state.onboardingData.selectedSector;
        final theme = Theme.of(context);
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
                OnboardingHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(flex: 2),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset(
                            mascotAsset,
                            height: 280,
                            fit: BoxFit.contain,
                            key: ValueKey(mascotAsset),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Got it! Meet your Bizzie',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 40,
                            height: 1.2,
                            letterSpacing: 0.406,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${selectedSector?.displayName ?? "Your"} Bizzie will send you a daily list of stocks & brands from your favorite sector.',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 17,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 128),
                      ],
                    ),
                  ),
                ),
                OnboardingFooter(
                  primaryButton: FilledButton(
                    onPressed: () {
                      context.push(AppRoutes.onboardingBrands);
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: Text(
                      'Continue',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
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
