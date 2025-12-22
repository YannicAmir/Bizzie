import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/auth/presentation/widgets/auth_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_footer.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (user) {
            context.go(AppRoutes.home);
          },
          failure: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                // Mascot
                Center(
                  child: Image.asset(
                    AppAssets.defaultMascot,
                    height:
                        120, // Verify height from Figma if possible, keeping 120 for now
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32),
                // Titles
                const _LoginHeader(),
                const SizedBox(height: 24),
                // Form
                const LoginForm(),
                const SizedBox(height: 24),
                // OR Divider
                const AuthDivider(),
                const SizedBox(height: 24),
                // Social Buttons
                const SocialLoginButtons(),
                const SizedBox(height: 48),
                // Footer
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back!',
          style: AppTextStyles.h1.copyWith(
            fontSize: 32, // Figma says 32/33, keeping 32 standard
            // letterSpacing: 0.406, // from AppTextStyles.h1
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Log in to continue',
          style: AppTextStyles.subtitle.copyWith(
            fontSize:
                16, // Figma says 16px typical for subtitle here? Previous was 17
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
