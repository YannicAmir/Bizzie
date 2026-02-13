import 'package:flutter/material.dart';

class AppConstants {
  static const EdgeInsets appBarActionsPadding = EdgeInsets.only(right: 16.0);
  static const EdgeInsets appBarBottomTabsPadding = EdgeInsets.only(left: 24.0);

  static const double defaultBorderWidth = 0.665;
  static const double tabHeight = 40.0;
  static const double mainSectionContainerPadding = 12.0;
  static const double mainButtonHeight = 54.0;
  static const double smallButtonHeight = 40.0;
  static const double bizzieSwitchHeight = 48.0;

  static const EdgeInsets pagePadding = EdgeInsets.fromLTRB(16, 16, 16, 24);
  static const EdgeInsets profileTabWidgetPadding = EdgeInsets.symmetric(
    horizontal: 16,
  );

  static const EdgeInsets reportModalPadding = EdgeInsets.fromLTRB(
    16,
    0,
    16,
    24,
  );
  static const EdgeInsets selectionModalItemPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 4,
  );
  static const EdgeInsets moreTabDropdownButtonPadding = EdgeInsets.fromLTRB(
    16,
    16,
    16,
    0,
  );

  static const EdgeInsets dropdownButtonPadding = EdgeInsets.symmetric(
    vertical: 16,
    horizontal: 12,
  );
  static const double newsPagePadding = 16.0;
  static const EdgeInsets bottomModalPadding = EdgeInsets.symmetric(
    horizontal: 20,
  );
  static const EdgeInsets dataRowVerticalPadding = EdgeInsets.symmetric(
    vertical: 16,
  );

  static const int chartVisibleCount = 7;
  static const int dividendTableRowCount = 8;
  static const double dateCardHeight = 120.0;

  static const SizedBox mainSectionSpacing = SizedBox(height: 24);
  static const SizedBox secondarySectionSpacing = SizedBox(height: 16);
  static const SizedBox subSectionSpacing = SizedBox(height: 8);
  static const SizedBox subSectionHorizontalSpacing = SizedBox(width: 8);
  static const SizedBox emptyStateTopSpacing = SizedBox(height: 48);
  static const double mainSectionBorderRadius = 16.0;

  static const double chartBarBorderRadius = 8.0;
  static const double componyProfileButtonBorderRadius = 10.0;
  static const double tooltipBorderRadius = 4.0;
  static const double tooltipPadding = 8.0;
  static const double chartLineWidth = 2.0;
  static const double chartPlotOffsetStart = 15.0;

  static const double kChartAnimationDuration = 600;

  static const int textfieldCharLimit = 100;
  static const int passwordFieldCharLimit = 128;

  // Onboarding
  static const SizedBox onboardSectionSpacing = SizedBox(height: 32);
  static const SizedBox onboardSecondarySectionSpacing = SizedBox(height: 16);
}
