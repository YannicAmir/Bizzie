import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/auth/presentation/widgets/auth_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_footer.dart';
import '../widgets/create_account_form.dart';
import '../widgets/mascot_info_card.dart';
import '../widgets/social_login_buttons.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';

import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_header.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (user) {
            context.go(AppRoutes.onboardingBuildingProfile);
          },
          failure: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingHeader(),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: BlocBuilder<OnboardingBloc, OnboardingState>(
                      builder: (context, onboardingState) {
                        return MascotInfoCard(
                          name: onboardingState.greetingName,
                          sectorName: onboardingState.displaySectorName,
                          mascotAsset: onboardingState.mascotAsset,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _CreateAccountHeader(),
                        const SizedBox(height: 32),
                        const CreateAccountForm(),
                        const SizedBox(height: 24),
                        const AuthDivider(),
                        const SizedBox(height: 24),
                        const SocialLoginButtons(),
                        const SizedBox(height: 48),
                        const AuthFooter(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateAccountHeader extends StatelessWidget {
  const _CreateAccountHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Create your account', style: AppTextStyles.h1),
        const SizedBox(height: 8),
        Text(
          'Save your progress',
          style: AppTextStyles.subtitle.copyWith(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
