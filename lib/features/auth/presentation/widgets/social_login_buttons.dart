import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SocialLoginButtons extends StatefulWidget {
  const SocialLoginButtons({super.key});

  @override
  State<SocialLoginButtons> createState() => _SocialLoginButtonsState();
}

class _SocialLoginButtonsState extends State<SocialLoginButtons> {
  String? _loadingMethod;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: (method) {
            if (mounted) {
              setState(() => _loadingMethod = method);
            }
          },
          failure: (_) {
            if (mounted) {
              setState(() => _loadingMethod = null);
            }
          },
          unauthenticated: () {
            if (mounted) {
              setState(() => _loadingMethod = null);
            }
          },
          orElse: () {
            // Provide explicit cases for other states where we typically WANT to keep loading
            // (e.g. authenticated) so we don't clear it.
          },
        );
      },
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton(
              onPressed: _loadingMethod != null
                  ? null
                  : () {
                      context.read<AuthBloc>().add(
                        const AuthEvent.appleSignInRequested(),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appleBlack,
                disabledBackgroundColor: AppColors.appleBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: _loadingMethod == 'apple'
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.authAppleIcon,
                          height: 24,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Continue with Apple',
                          style: AppTextStyles.button.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton(
              onPressed: _loadingMethod != null
                  ? null
                  : () {
                      context.read<AuthBloc>().add(
                        const AuthEvent.googleSignInRequested(),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.googleBackground,
                disabledBackgroundColor: AppColors.googleBackground,
                foregroundColor: AppColors.textPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: _loadingMethod == 'google'
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.textPrimary,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.authGoogleIcon, height: 24),
                        const SizedBox(width: 12),
                        Text(
                          'Continue with Google',
                          style: AppTextStyles.button.copyWith(
                            color: AppColors.googleText,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
