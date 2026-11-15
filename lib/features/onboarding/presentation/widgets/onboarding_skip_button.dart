import 'dart:async';

import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_navigation_orchestrator.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class OnboardingSkipButton extends StatelessWidget {
  final OnboardingStep step;

  const OnboardingSkipButton({super.key, required this.step});

  void _onPressed(BuildContext context) {
    unawaited(OnboardingNavigationOrchestrator.startSkipFlow(context, step));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () => _onPressed(context),
      style: TextButton.styleFrom(
        minimumSize: AppConstants.minTouchTargetSize,
        foregroundColor: theme.colorScheme.onSurfaceVariant,
      ),
      child: Text(
        'Skip',
        semanticsLabel: 'Skip onboarding',
        style: AppTextStyles.bodyMediumBoldSecondary,
      ),
    );
  }
}
