import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
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
            // Navigate to Home or Post-Login Screen
            // User didn't specify exact destination yet, but usually it's Home
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Welcome back, ${user.id}!')),
            );
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20,
              ),
              onPressed: () => context.pop(),
            ),
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
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32), // Increased gap
                // Titles
                Text('Welcome Back!', style: AppTextStyles.h1),
                const SizedBox(height: 8),
                Text('Log in to continue', style: AppTextStyles.subtitle),
                const SizedBox(height: 24), // Gap: 24px (Calculated from Figma)
                // Form
                const LoginForm(),
                const SizedBox(height: 24), // Gap: 24px
                // OR Divider
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: AppColors.inputBorder,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or continue with',
                        style: AppTextStyles.caption,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: AppColors.inputBorder,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ), // Gap: 24px (Calculated: 26.4 -> 24)
                // Social Buttons
                const SocialLoginButtons(),
                const SizedBox(height: 48), // Footer Gap (Estimated/Kept)
                // Footer
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.smallLink,
                      children: [
                        const TextSpan(
                          text: 'By continuing, you agree to Bizzie\'s ',
                        ),
                        TextSpan(
                          text: 'Terms of Service',
                          style: AppTextStyles.smallLinkBold,
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to Terms
                                  context.push('/terms');
                                },
                        ),
                        const TextSpan(text: ' and\n'),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: AppTextStyles.smallLinkBold,
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to Privacy
                                  context.push('/privacy');
                                },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
