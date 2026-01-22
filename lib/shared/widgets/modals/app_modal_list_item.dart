import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class AppModalListItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const AppModalListItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? badgeTheme?.neutralBackground
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(
            AppConstants.mainSectionBorderRadius,
          ),
        ),
        margin: AppConstants.selectionModalItemPadding,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: isSelected
                    ? AppTextStyles.bodyMediumBold.copyWith(
                        color: badgeTheme?.neutralText,
                      )
                    : AppTextStyles.bodyMedium,
              ),
            ),
            if (isSelected)
              Icon(Icons.check, color: badgeTheme?.neutralText, size: 20),
          ],
        ),
      ),
    );
  }
}
