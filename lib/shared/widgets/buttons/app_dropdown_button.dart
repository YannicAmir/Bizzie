import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class AppDropdownButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppDropdownButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.mainSectionBorderRadius),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(
            AppConstants.mainSectionBorderRadius,
          ),
          border: Border.all(
            color: theme.dividerColor,
            width: AppConstants.defaultBorderWidth,
          ),
        ),
        padding: AppConstants.dropdownButtonPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyLargeBold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.black),
          ],
        ),
      ),
    );
  }
}
