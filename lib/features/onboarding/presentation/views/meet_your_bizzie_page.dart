import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/themes/app_assets.dart';
import '../utils/onboarding_assets_helper.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';

import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

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
                        AppConstants.onboardSectionSpacing,
                        Text(
                          'Got it! Meet your Bizzie',
                          style: theme.textTheme.displayLarge,
                        ),
                        AppConstants.onboardSecondarySectionSpacing,
                        Text(
                          '${selectedSector?.displayName ?? "Your"} Bizzie will send you a daily list of stocks & brands from your favorite sector.',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 128),
                      ],
                    ),
                  ),
                ),
                OnboardingFooter(
                  primaryButton: BizziePrimaryButton(
                    onPressed: () {
                      context.push(AppRoutes.onboardingBrands);
                    },
                    title: 'Continue',
                    width: double.infinity,
                    height: 56,
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
