import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/shared/widgets/buttons/social_login_button.dart';
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
    final theme = Theme.of(context);
    final socialTheme = theme.extension<SocialLoginThemeExtension>()!;

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
          SocialLoginButton(
            text: 'Continue with Apple',
            iconAsset: AppAssets.authAppleIcon,
            backgroundColor: socialTheme.appleBackgroundColor,
            foregroundColor: socialTheme.appleForegroundColor,
            isLoading: _loadingMethod == 'apple',
            onPressed: _loadingMethod != null
                ? null
                : () {
                    context.read<AuthBloc>().add(
                      const AuthEvent.appleSignInRequested(),
                    );
                  },
          ),
          const SizedBox(height: 12),
          SocialLoginButton(
            text: 'Continue with Google',
            iconAsset: AppAssets.authGoogleIcon,
            backgroundColor: socialTheme.googleBackgroundColor,
            foregroundColor: socialTheme.googleForegroundColor,
            textColor: socialTheme.googleTextColor,
            isLoading: _loadingMethod == 'google',
            onPressed: _loadingMethod != null
                ? null
                : () {
                    context.read<AuthBloc>().add(
                      const AuthEvent.googleSignInRequested(),
                    );
                  },
          ),
        ],
      ),
    );
  }
}
