import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BizzieChartTooltip extends StatelessWidget {
  final String label;
  final double value;
  final Color? backgroundColor;
  final NumberFormat? numberFormat;

  const BizzieChartTooltip({
    super.key,
    required this.label,
    required this.value,
    this.backgroundColor,
    this.numberFormat,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String formattedValue;
    if (numberFormat != null) {
      numberFormat!.maximumFractionDigits = 2;
      numberFormat!.minimumFractionDigits = 2;
      formattedValue = numberFormat!.format(value);
    } else {
      formattedValue = value.toStringAsFixed(2);
    }

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
            formattedValue,
            style: AppTextStyles.bodySmallBold.copyWith(
              color: theme.colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
