import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class AuthSignInPrompt extends StatelessWidget {
  final VoidCallback onSignInPressed;

  const AuthSignInPrompt({super.key, required this.onSignInPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: AppTextStyles.bodyMediumSecondary,
        ),
        TextButton(
          onPressed: onSignInPressed,
          style: TextButton.styleFrom(
            minimumSize: AppConstants.minTouchTargetSize,
          ),
          child: Text(
            'Log in',
            semanticsLabel: 'Log in to an existing account',
            style: AppTextStyles.bodyMediumBold.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
