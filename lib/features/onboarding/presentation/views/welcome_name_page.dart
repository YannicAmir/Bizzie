import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/themes/app_assets.dart';
import '../../../../app/themes/app_colors.dart';

import '../bloc/onboarding_bloc.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';

import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class WelcomeNamePage extends StatelessWidget {
  const WelcomeNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final firstName = state.onboardingData.firstName;
        final theme = Theme.of(context);

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnboardingHeader(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      const _WelcomeMascot(),
                      const SizedBox(height: 32),
                      _WelcomeTextContent(firstName: firstName),
                      const Spacer(),
                    ],
                  ),
                ),
                OnboardingFooter(
                  primaryButton: BizziePrimaryButton(
                    onPressed: () {
                      context.push(AppRoutes.onboardingSectors);
                    },
                    title: 'Continue',
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

class _WelcomeMascot extends StatelessWidget {
  const _WelcomeMascot();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Image.asset(
        AppAssets.onboardingBizzieMascotWelcome,
        height: 238,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _WelcomeTextContent extends StatelessWidget {
  final String firstName;

  const _WelcomeTextContent({required this.firstName});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 40,
                height: 1.2,
                letterSpacing: 0.406,
              ),
              children: [
                const TextSpan(text: 'Glad you joined us,\n'),
                TextSpan(
                  text: firstName,
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
                const TextSpan(text: '!'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Let's take on the Stock Market together",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
