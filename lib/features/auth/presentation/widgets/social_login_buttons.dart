import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<AuthBloc>().add(
                const AuthEvent.appleSignInRequested(),
              );
            },
            icon: Image.asset(
              AppAssets.authAppleIcon,
              height: 24,
              color: Colors.white,
            ),
            label: Text(
              'Continue with Apple',
              style: AppTextStyles.button.copyWith(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appleBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<AuthBloc>().add(
                const AuthEvent.googleSignInRequested(),
              );
            },
            icon: Image.asset(AppAssets.authGoogleIcon, height: 24),
            label: Text(
              'Continue with Google',
              style: AppTextStyles.button.copyWith(color: AppColors.googleText),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.googleBackground,
              foregroundColor: AppColors.textPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}
