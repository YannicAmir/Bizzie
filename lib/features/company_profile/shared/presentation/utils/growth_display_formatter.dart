import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/growth_color_behavior.dart';
import 'package:flutter/material.dart';

abstract class GrowthDisplayFormatter {
  static ({String text, Color color}) format(
    double? growthPercent, {
    GrowthColorBehavior colorBehavior = GrowthColorBehavior.standard,
  }) {
    final color = colorFor(growthPercent, colorBehavior: colorBehavior);
    if (growthPercent == null) {
      return (text: '-', color: color);
    }
    if (growthPercent > 0) {
      return (text: '+${growthPercent.toStringAsFixed(1)}%', color: color);
    }
    if (growthPercent < 0) {
      return (text: '${growthPercent.toStringAsFixed(1)}%', color: color);
    }
    return (text: '0.0%', color: color);
  }

  static Color colorFor(
    double? growthPercent, {
    GrowthColorBehavior colorBehavior = GrowthColorBehavior.standard,
  }) {
    if (growthPercent == null || growthPercent == 0) {
      return AppColors.textPrimary;
    }
    return growthPercent > 0
        ? _positiveColor(colorBehavior)
        : _negativeColor(colorBehavior);
  }

  static Color _positiveColor(GrowthColorBehavior behavior) =>
      switch (behavior) {
        GrowthColorBehavior.standard => AppColors.successText,
        GrowthColorBehavior.inverted => AppColors.criticalText,
        GrowthColorBehavior.neutral => AppColors.textPrimary,
      };

  static Color _negativeColor(GrowthColorBehavior behavior) =>
      switch (behavior) {
        GrowthColorBehavior.standard => AppColors.criticalText,
        GrowthColorBehavior.inverted => AppColors.successText,
        GrowthColorBehavior.neutral => AppColors.textPrimary,
      };
}
