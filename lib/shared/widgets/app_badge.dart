import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';

enum AppBadgeStyle { neutral, critical, good, warning, issue }

class AppBadge extends StatelessWidget {
  final String text;
  final AppBadgeStyle style;

  const AppBadge({super.key, required this.text, required this.style});

  Color get _backgroundColor {
    switch (style) {
      case AppBadgeStyle.neutral:
        return AppColors.mascotBackground;
      case AppBadgeStyle.critical:
        return AppColors.red100;
      case AppBadgeStyle.good:
        return AppColors.successBackground;
      case AppBadgeStyle.warning:
        return AppColors.warningBackground;
      case AppBadgeStyle.issue:
        return AppColors.orange100;
    }
  }

  Color get _textColor {
    switch (style) {
      case AppBadgeStyle.neutral:
        return AppColors.primary;
      case AppBadgeStyle.critical:
        return AppColors.criticalText;
      case AppBadgeStyle.good:
        return AppColors.goodText;
      case AppBadgeStyle.warning:
        return AppColors.warningText;
      case AppBadgeStyle.issue:
        return AppColors.orange700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: _textColor,
        ),
      ),
    );
  }
}
