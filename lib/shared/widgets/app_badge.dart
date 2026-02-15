import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_theme.dart';

enum AppBadgeStyle { neutral, critical, good, warning, issue }

class AppBadge extends StatelessWidget {
  final String text;
  final AppBadgeStyle style;
  final bool isLarge;
  final bool isExtraLarge;
  final bool noBackground;

  const AppBadge({
    super.key,
    required this.text,
    required this.style,
    this.isLarge = false,
    this.isExtraLarge = false,
    this.noBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();

    Color backgroundColor;
    Color textColor;

    switch (style) {
      case AppBadgeStyle.neutral:
        backgroundColor =
            badgeTheme?.neutralBackground ?? theme.colorScheme.surface;
        textColor = badgeTheme?.neutralText ?? theme.colorScheme.onSurface;
        break;
      case AppBadgeStyle.critical:
        backgroundColor =
            badgeTheme?.criticalBackground ?? theme.colorScheme.errorContainer;
        textColor =
            badgeTheme?.criticalText ?? theme.colorScheme.onErrorContainer;
        break;
      case AppBadgeStyle.good:
        backgroundColor =
            badgeTheme?.goodBackground ?? theme.colorScheme.primaryContainer;
        textColor =
            badgeTheme?.goodText ?? theme.colorScheme.onPrimaryContainer;
        break;
      case AppBadgeStyle.warning:
        backgroundColor =
            badgeTheme?.warningBackground ??
            theme.colorScheme.tertiaryContainer;
        textColor =
            badgeTheme?.warningText ?? theme.colorScheme.onTertiaryContainer;
        break;
      case AppBadgeStyle.issue:
        backgroundColor =
            badgeTheme?.issueBackground ?? theme.colorScheme.errorContainer;
        textColor = badgeTheme?.issueText ?? theme.colorScheme.onErrorContainer;
        break;
    }

    return Container(
      padding: noBackground
          ? EdgeInsets.all(0)
          : const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: noBackground ? theme.colorScheme.surface : backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: isExtraLarge
            ? AppTextStyles.bodyLargeBold.copyWith(color: textColor)
            : isLarge
            ? AppTextStyles.bodyMediumBold.copyWith(color: textColor)
            : AppTextStyles.bodySmallBold.copyWith(color: textColor),
      ),
    );
  }
}
