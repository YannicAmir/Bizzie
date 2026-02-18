import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/core/analytics/onboarding_tracker.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_assets_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import '../widgets/onboarding_header.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class ProfileReadyPage extends StatefulWidget {
  const ProfileReadyPage({super.key});

  @override
  State<ProfileReadyPage> createState() => _ProfileReadyPageState();
}

class _ProfileReadyPageState extends State<ProfileReadyPage> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    authState.mapOrNull(
      authenticated: (u) => context.read<UserBloc>().add(
        UserEvent.loadUser(uid: u.user.id, silent: true),
      ),
    );
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.profileReady),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final selectedSector = state.onboardingData.selectedSector;
        final firstName = state.onboardingData.firstName;

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
                        _ProfileMascot(mascotAsset: mascotAsset),
                        const Spacer(flex: 1),
                        _ProfileReadyHeader(firstName: firstName),
                        const Spacer(flex: 3),
                        const _ContinueButton(),
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

class _ProfileMascot extends StatelessWidget {
  final String mascotAsset;

  const _ProfileMascot({required this.mascotAsset});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Image.asset(mascotAsset, height: 272, fit: BoxFit.contain),
    );
  }
}

class _ProfileReadyHeader extends StatelessWidget {
  final String firstName;

  const _ProfileReadyHeader({required this.firstName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: theme.textTheme.displayLarge,
            children: [
              const TextSpan(text: 'Your profile is ready, '),
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
          'We have personalized Bizzie just for you. Let\'s get started!',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 17,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: BizziePrimaryButton(
        onPressed: () {
          context.read<OnboardingBloc>().add(
            const OnboardingEvent.profileReadyContinuePressed(),
          );
          context.goNamed(
            'home_subscribe',
            queryParameters: {
              'animate': 'onboarding',
              'source': PaywallSource.onboarding.name,
            },
          );
        },
        title: 'Continue',
      ),
    );
  }
}
