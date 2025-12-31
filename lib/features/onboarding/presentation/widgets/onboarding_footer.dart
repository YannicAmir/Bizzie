import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingFooter extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? primaryButton;
  final Widget? secondaryButton;

  const OnboardingFooter({
    super.key,
    this.title,
    this.subtitle,
    this.primaryButton,
    this.secondaryButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: AppTextStyles.h1.copyWith(
                fontSize: 32,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.left,
            ),
          ],
          if (subtitle != null) ...[
            if (title != null) const SizedBox(height: 8),
            Text(
              subtitle!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.left,
            ),
          ],
          if (title != null || subtitle != null) const SizedBox(height: 48),
          if (primaryButton != null) ...[
            SizedBox(width: double.infinity, height: 56, child: primaryButton),
          ],
          if (primaryButton != null && secondaryButton != null)
            const SizedBox(height: 16),
          if (secondaryButton != null) ...[
            // If primary button is null, we might want to ensure this sits at the bottom or maintain the layout.
            // Based on request "give that button the same placement as the current",
            // just rendering it here does that effectively in the column flow.
            secondaryButton!,
          ],
          const SizedBox(height: 16), // Bottom safe area padding
        ],
      ),
    );
  }
}
