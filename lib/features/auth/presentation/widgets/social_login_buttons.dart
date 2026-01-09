import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_theme.dart';
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
          _SocialLoginButton(
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
          _SocialLoginButton(
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

class _SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconAsset;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? textColor;
  final bool isLoading;
  final VoidCallback? onPressed;

  const _SocialLoginButton({
    required this.text,
    required this.iconAsset,
    required this.backgroundColor,
    required this.foregroundColor,
    this.textColor,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveTextColor = textColor ?? foregroundColor;

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: foregroundColor,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    iconAsset,
                    height: 24,
                    color: foregroundColor == Colors.white
                        ? Colors.white
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: effectiveTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
