import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/company_profile/domain/enums/market_cap_category.dart';
import 'package:flutter/material.dart';

extension MarketCapCategoryX on MarketCapCategory {
  String get label {
    switch (this) {
      case MarketCapCategory.mega:
        return 'Mega-Cap';
      case MarketCapCategory.large:
        return 'Large-Cap';
      case MarketCapCategory.mid:
        return 'Mid-Cap';
      case MarketCapCategory.small:
        return 'Small-Cap';
      case MarketCapCategory.micro:
        return 'Micro-Cap';
      case MarketCapCategory.nano:
        return 'Nano-Cap';
    }
  }

  Color getBadgeBackgroundColor(BadgeThemeExtension theme) {
    return theme.neutralBackground;
  }

  Color getBadgeTextColor(BadgeThemeExtension theme) {
    return theme.neutralText;
  }
}
