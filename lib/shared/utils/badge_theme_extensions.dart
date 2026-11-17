import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:material_ui/material_ui.dart';

extension BadgeThemeTextColors on BadgeThemeExtension? {
  Color get goodTextOrDefault => this?.goodText ?? AppColors.goodText;

  Color get criticalTextOrDefault =>
      this?.criticalText ?? AppColors.criticalText;
}
