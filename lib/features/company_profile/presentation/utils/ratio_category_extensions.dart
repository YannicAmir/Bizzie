import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/company_profile/domain/enums/ratio_category.dart';
import 'package:flutter/material.dart';

extension RatioCategoryX on RatioCategory {
  String get label {
    switch (this) {
      case RatioCategory.veryHigh:
        return 'Very High';
      case RatioCategory.high:
        return 'High';
      case RatioCategory.aboveAverage:
        return 'Above Avg';
      case RatioCategory.average:
        return 'Average';
      case RatioCategory.low:
        return 'Low';
      case RatioCategory.veryLow:
        return 'Very Low';
      case RatioCategory.negative:
        return 'Negative';
      case RatioCategory.none:
        return '-';
    }
  }

  Color getBadgeBackgroundColor(BadgeThemeExtension theme) {
    switch (this) {
      case RatioCategory.veryHigh:
      case RatioCategory.negative:
        return theme.criticalBackground;
      case RatioCategory.high:
        return theme.issueBackground;
      case RatioCategory.aboveAverage:
        return theme.warningBackground;
      case RatioCategory.average:
        return theme.neutralBackground;
      case RatioCategory.low:
      case RatioCategory.veryLow:
        return theme.goodBackground;
      case RatioCategory.none:
        return theme.voidBackground;
    }
  }

  Color getBadgeTextColor(BadgeThemeExtension theme) {
    switch (this) {
      case RatioCategory.veryHigh:
      case RatioCategory.negative:
        return theme.criticalText;
      case RatioCategory.high:
        return theme.issueText;
      case RatioCategory.aboveAverage:
        return theme.warningText;
      case RatioCategory.average:
        return theme.neutralText;
      case RatioCategory.low:
      case RatioCategory.veryLow:
        return theme.goodText;
      case RatioCategory.none:
        return theme.voidText;
    }
  }
}
