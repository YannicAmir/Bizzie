import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/auth/presentation/widgets/auth_divider.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import '../widgets/auth_footer.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_buttons.dart';

class LoginPage extends StatelessWidget {
  final AuthSource source;

  const LoginPage({super.key, this.source = AuthSource.landing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          failure: (failure) {
            BizzieSnackBar.show(
              context,
              message: failure.errorMessage,
              type: BizzieSnackBarType.error,
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    AppAssets.defaultMascot,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32),
                const _LoginHeader(),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                LoginForm(source: source),
                const SizedBox(height: 24),
                const AuthDivider(),
                const SizedBox(height: 24),
                SocialLoginButtons(source: source),
                const SizedBox(height: 48),
                const AuthFooter(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome Back!', style: theme.textTheme.displayLarge),
        const SizedBox(height: 8),
        Text(
          'Log in to continue',
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 16,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
