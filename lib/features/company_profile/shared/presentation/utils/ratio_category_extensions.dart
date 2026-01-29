import 'package:bizzie/features/company_profile/shared/domain/enums/ratio_category.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';

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

  AppBadgeStyle get badgeStyle {
    switch (this) {
      case RatioCategory.veryHigh:
      case RatioCategory.negative:
        return AppBadgeStyle.critical;
      case RatioCategory.high:
        return AppBadgeStyle.issue;
      case RatioCategory.aboveAverage:
        return AppBadgeStyle.warning;
      case RatioCategory.average:
        return AppBadgeStyle.neutral;
      case RatioCategory.low:
      case RatioCategory.veryLow:
        return AppBadgeStyle.good;
      case RatioCategory.none:
        return AppBadgeStyle.neutral;
    }
  }
}
