import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_navigation_orchestrator.dart';
import 'package:bizzie/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.profileReady),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const SafeArea(
        child: Column(
          children: [
            OnboardingHeader(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 2),
                    _ProfileMascot(),
                    Spacer(flex: 1),
                    _ProfileReadyHeader(),
                    Spacer(flex: 3),
                    _ContinueButton(),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMascot extends StatelessWidget {
  const _ProfileMascot();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OnboardingBloc, OnboardingState, String>(
      selector: (state) => state.mascotAsset,
      builder: (context, mascotAsset) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Image.asset(
            mascotAsset,
            key: ValueKey(mascotAsset),
            height: 272,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}

class _ProfileReadyHeader extends StatelessWidget {
  const _ProfileReadyHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocSelector<OnboardingBloc, OnboardingState, String>(
      selector: (state) => state.greetingName,
      builder: (context, greetingName) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: theme.textTheme.displayLarge,
                children: [
                  const TextSpan(text: 'Your profile is ready, '),
                  TextSpan(
                    text: greetingName,
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                  const TextSpan(text: '!'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'We have personalized Bizzie just for you. Let\'s get started!',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        );
      },
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
        onPressed: () => getIt<OnboardingNavigationOrchestrator>()
            .startTerminalFlow(context),
        title: 'Continue',
      ),
    );
  }
}
