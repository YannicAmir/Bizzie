import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailSentPage extends StatelessWidget {
  const EmailSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 192), // Top spacing from Figma
                  // Mascot
                  Image.asset(
                    AppAssets.authEmailSentMascot,
                    width: 160,
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 32),
                  // Title
                  Text(
                    'Check Your Email',
                    style: AppTextStyles.h1.copyWith(
                      fontSize: 40,
                      height: 1.2, // 48px leading / 40px size
                      letterSpacing: 0.37,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ), // Consistent gap from Figma flex-col gap
                  // Body Text
                  Text(
                    'If your account is associated with this email address, you will receive an email to reset your password. If you don\'t, please try another email.',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: const Color(0xFF45556C),
                      height: 1.6, // 27.2px leading / 17px size
                    ),
                  ),
                ],
              ),
            ),
            // Floating Button at Bottom
            Positioned(
              left: 24,
              right: 24,
              bottom: 16,
              child: SizedBox(
                height: 58,
                child: ElevatedButton(
                  onPressed: () => context.go(AppRoutes.login),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Back to Login',
                    style: AppTextStyles.button.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600, // SemiBold in Figma
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
