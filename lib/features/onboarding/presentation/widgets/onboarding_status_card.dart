import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';

class OnboardingStatusCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget icon;
  final AnalysisStepStatus status;

  const OnboardingStatusCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: status.borderColor, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: status.iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: icon),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: status.textColor,
                  ),
                ),
                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: status == AnalysisStepStatus.pending
                          ? badgeTheme?.voidText
                          : (status == AnalysisStepStatus.active
                                ? badgeTheme?.neutralText
                                : badgeTheme?.goodText),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (status == AnalysisStepStatus.active)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            )
          else
            const SizedBox(width: 24, height: 24),
        ],
      ),
    );
  }
}

extension AnalysisStepStatusStyles on AnalysisStepStatus {
  Color get backgroundColor {
    switch (this) {
      case AnalysisStepStatus.completed:
        return AppColors.successBackground;
      case AnalysisStepStatus.active:
        return AppColors.watchlistActiveBackground;
      case AnalysisStepStatus.pending:
        return AppColors.inputBackground;
    }
  }

  Color get borderColor {
    switch (this) {
      case AnalysisStepStatus.completed:
        return AppColors.successBorder;
      case AnalysisStepStatus.active:
        return AppColors.watchlistActiveBorder;
      case AnalysisStepStatus.pending:
        return AppColors.inputBorder;
    }
  }

  Color get textColor {
    switch (this) {
      case AnalysisStepStatus.completed:
      case AnalysisStepStatus.active:
        return AppColors.textPrimary;
      case AnalysisStepStatus.pending:
        return AppColors.textTertiary;
    }
  }

  Color get iconBgColor {
    switch (this) {
      case AnalysisStepStatus.completed:
        return AppColors.successIconBackground;
      case AnalysisStepStatus.active:
        return AppColors.brandChipSelectedBackground;
      case AnalysisStepStatus.pending:
        return AppColors.slate100;
    }
  }

  Color get iconColor {
    switch (this) {
      case AnalysisStepStatus.completed:
        return AppColors.successText;
      case AnalysisStepStatus.active:
        return AppColors.primary;
      case AnalysisStepStatus.pending:
        return AppColors.textTertiary;
    }
  }
}
