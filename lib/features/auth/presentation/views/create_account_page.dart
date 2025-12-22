import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/create_account_form.dart';
import '../widgets/social_login_buttons.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (user) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Account Created! Welcome ${user.id}')),
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
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Onboarding Bar (Figma Node 31:16557 & 31:16558)
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 4,
                      color: AppColors.inputBorder, // Slate-200
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 4,
                      color: AppColors.primary, // #155DFC
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Back Button (Figma Node 31:16423)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: InkWell(
                    onTap: () => context.pop(),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 24, // Matches Figma Icon frame 24x24
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Mascot Info Widget (Figma Node 31:16428)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    padding: const EdgeInsets.all(21),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.mascotCardGradientStart,
                          AppColors.mascotCardGradientEnd,
                        ],
                        transform: GradientRotation(165 * 3.14159 / 180),
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.mascotCardBorder,
                        width: 0.665,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.1),
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.1),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                          spreadRadius: -1,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Mascot Image & Dot
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 2, // Figma 1.994px
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      offset: const Offset(0, 4),
                                      blurRadius: 6,
                                      spreadRadius: -1,
                                    ),
                                    BoxShadow(
                                      color: AppColors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      offset: const Offset(0, 2),
                                      blurRadius: 4,
                                      spreadRadius: -2,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    14,
                                  ), // Inner radius
                                  child: Image.asset(
                                    AppAssets.defaultMascot,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Notification Dot
                              Positioned(
                                top: -4,
                                right: -4, // Overlapping edge
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary, // #155DFC
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.white,
                                      width: 2, // Figma 1.994px
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black.withValues(
                                          alpha: 0.1,
                                        ),
                                        offset: const Offset(0, 1),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16), // Gap between image and text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yannic',
                              style: AppTextStyles.h2.copyWith(
                                fontSize: 19,
                                fontWeight: FontWeight.bold, // w700
                                color: AppColors.textPrimary,
                                height: 28.5 / 19, // Line height ratio
                                letterSpacing: -0.4453,
                              ),
                            ),
                            // Gap 2px (Figma gap-[1.994px])
                            const SizedBox(height: 2),
                            Text(
                              'Information Technology',
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500, // Medium
                                color:
                                    AppColors
                                        .mascotSubtitle, // Distinct blue from primary
                                height: 21 / 14,
                                letterSpacing: -0.1504,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titles
                      Text(
                        'Create your account',
                        style: AppTextStyles.h1, // Matches 32px ExtraBold
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Save your progress',
                        style: AppTextStyles.subtitle.copyWith(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Form
                      const CreateAccountForm(),

                      const SizedBox(height: 24),
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
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textTertiary,
                              ),
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
                      const SizedBox(height: 24),
                      // Social Buttons
                      const SocialLoginButtons(),
                      const SizedBox(height: 48),

                      // Footer (Disclaimer)
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(
                                text: 'By continuing, you agree to our ',
                              ),
                              TextSpan(
                                text: 'Terms of Service',
                                style: AppTextStyles.smallLinkBold.copyWith(
                                  fontSize: 14,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () => context.push(AppRoutes.terms),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: AppTextStyles.smallLinkBold.copyWith(
                                  fontSize: 14,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () => context.push(AppRoutes.privacy),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
