import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class BizzieChartTooltip extends StatelessWidget {
  final String label;
  final double value;
  final Color? backgroundColor;

  const BizzieChartTooltip({
    super.key,
    required this.label,
    required this.value,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppConstants.tooltipPadding),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(AppConstants.tooltipBorderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: theme.colorScheme.surface,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: AppTextStyles.bodySmallBold.copyWith(
              color: theme.colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
