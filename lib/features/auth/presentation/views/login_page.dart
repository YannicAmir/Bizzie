import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/auth/presentation/widgets/auth_divider.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../utils/auth_failure_snackbar.dart';
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
          authenticated: (user) {
            if (source == AuthSource.guestGate && !user.isAnonymous) {
              context.pop(true);
            }
          },
          failure: (failure) => AuthFailureSnackBar.show(context, failure),
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
                AppConstants.secondarySectionSpacing,
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
    return Text(
      'Welcome Back!',
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}
