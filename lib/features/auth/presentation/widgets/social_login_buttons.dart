import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../enums/auth_loading_method.dart';

class SocialLoginButtons extends StatefulWidget {
  final AuthSource source;

  const SocialLoginButtons({super.key, required this.source});

  @override
  State<SocialLoginButtons> createState() => _SocialLoginButtonsState();
}

class _SocialLoginButtonsState extends State<SocialLoginButtons> {
  AuthLoadingMethod? _loadingMethod;

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    state.maybeWhen(
      loading: (method) => setState(() => _loadingMethod = method),
      failure: (_) => _clearLoading(),
      unauthenticated: _clearLoading,
      orElse: () {},
    );
  }

  void _clearLoading() => setState(() => _loadingMethod = null);

  VoidCallback? _dispatchUnlessLoading(AuthEvent event) =>
      _loadingMethod != null ? null : () => context.read<AuthBloc>().add(event);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final socialTheme =
        theme.extension<SocialLoginThemeExtension>() ??
        SocialLoginThemeExtension.light;

    return BlocListener<AuthBloc, AuthState>(
      listener: _onAuthStateChanged,
      child: Row(
        children: [
          Expanded(
            child: SocialLoginButton(
              text: 'Continue with Apple',
              iconAsset: AppAssets.authAppleIcon,
              backgroundColor: socialTheme.appleBackgroundColor,
              foregroundColor: socialTheme.appleForegroundColor,
              isLoading: _loadingMethod == AuthLoadingMethod.apple,
              iconOnly: true,
              onPressed: _dispatchUnlessLoading(
                AuthEvent.appleSignInRequested(source: widget.source),
              ),
            ),
          ),
          AppConstants.subSectionHorizontalSpacing,
          Expanded(
            child: SocialLoginButton(
              text: 'Continue with Google',
              iconAsset: AppAssets.authGoogleIcon,
              backgroundColor: socialTheme.googleBackgroundColor,
              foregroundColor: socialTheme.googleForegroundColor,
              textColor: socialTheme.googleTextColor,
              isLoading: _loadingMethod == AuthLoadingMethod.google,
              iconOnly: true,
              onPressed: _dispatchUnlessLoading(
                AuthEvent.googleSignInRequested(source: widget.source),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
