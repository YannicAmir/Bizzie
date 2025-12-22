import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          children: [
            const TextSpan(text: 'By continuing, you agree to our '),
            TextSpan(
              text: 'Terms of Service',
              style: AppTextStyles.smallLinkBold.copyWith(fontSize: 14),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () => context.push(AppRoutes.terms),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: AppTextStyles.smallLinkBold.copyWith(fontSize: 14),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () => context.push(AppRoutes.privacy),
            ),
          ],
        ),
      ),
    );
  }
}
