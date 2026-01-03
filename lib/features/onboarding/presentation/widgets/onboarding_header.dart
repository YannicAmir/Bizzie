import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';

import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  final Widget? progressIndicator;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onBackPressed;

  const OnboardingHeader({
    super.key,
    this.progressIndicator,
    this.title,
    this.subtitle,
    this.onBackPressed,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (progressIndicator != null) ...[progressIndicator!],
        if (onBackPressed != null || trailing != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (onBackPressed != null)
                  GestureDetector(
                    onTap: onBackPressed,
                    child: Image.asset(
                      AppAssets.backArrowIcon,
                      width: 24,
                      height: 24,
                    ),
                  )
                else
                  const SizedBox(width: 24),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        if (title != null || subtitle != null) ...[
          const SizedBox(height: 56),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: theme.textTheme.displayLarge?.copyWith(height: 1.2),
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
