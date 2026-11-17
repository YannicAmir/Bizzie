import 'package:flutter/material.dart';

class AppConstants {
  static const EdgeInsets appBarActionsPadding = EdgeInsets.only(right: 16.0);
  static const EdgeInsets appBarBottomTabsPadding = EdgeInsets.only(left: 24.0);

  static const double defaultBorderWidth = 0.665;
  static const double tabHeight = 40.0;
  static const double tabBarHeight = 48.0;
  static const double mainSectionContainerPadding = 12.0;
  static const double mainButtonHeight = 54.0;
  static const double smallButtonHeight = 40.0;
  static const double bizzieSwitchHeight = 48.0;
  static const Size minTouchTargetSize = Size(48, 48);

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
  static const EdgeInsets confirmationSheetPadding = EdgeInsets.symmetric(
    horizontal: 16,
  );
  static const EdgeInsets dataRowVerticalPadding = EdgeInsets.symmetric(
    vertical: 16,
  );

  static const int dividendTableRowCount = 8;
  static const double dateCardHeight = 120.0;

  static const SizedBox largeSectionSpacing = SizedBox(height: 32);
  static const SizedBox mainSectionSpacing = SizedBox(height: 24);
  static const SizedBox secondarySectionSpacing = SizedBox(height: 16);
  static const SizedBox compactSectionSpacing = SizedBox(height: 12);
  static const SizedBox subSectionSpacing = SizedBox(height: 8);
  static const SizedBox subSectionHorizontalSpacing = SizedBox(width: 8);
  static const SizedBox emptyStateTopSpacing = SizedBox(height: 48);
  static const SizedBox watchlistLoaderTopSpacing = SizedBox(height: 128);

  // Home Empty Watchlist
  static const EdgeInsets emptyWatchlistPadding = EdgeInsets.symmetric(
    horizontal: 24,
  );
  static const SizedBox emptyWatchlistTopSpacing = SizedBox(height: 200);
  static const double emptyWatchlistMascotHeight = 160.0;
  static const SizedBox emptyWatchlistBottomSpacing = SizedBox(height: 32);

  // Watchlist YTD
  static const EdgeInsets watchlistYtdTitlePadding = EdgeInsets.only(
    top: 24,
    bottom: 16,
  );
  static const double watchlistYtdGridSpacing = 12.0;

  static const double mainSectionBorderRadius = 16.0;
  static const double cardBorderRadius = 12.0;

  static const double chartBarBorderRadius = 8.0;
  static const double companyProfileButtonBorderRadius = 10.0;
  static const EdgeInsets companyProfileButtonPadding = EdgeInsets.symmetric(
    horizontal: 12,
  );
  static const double companyProfileButtonIconSize = 20.0;
  static const double companyProfileButtonIconSpacing = 4.0;
  static const double bizzieChatFabImageSize = 56.0;
  static const double tooltipBorderRadius = 4.0;
  static const double tooltipPadding = 8.0;
  static const double chartLineWidth = 2.0;
  static const double chartPlotOffsetStart = 15.0;
  static const double chartCarouselHeight = 400.0;

  static const double kChartAnimationDuration = 600;

  static const int textfieldCharLimit = 100;
  static const int passwordFieldCharLimit = 128;

  // Onboarding
  static const SizedBox onboardSectionSpacing = SizedBox(height: 32);
  static const SizedBox onboardSecondarySectionSpacing = SizedBox(height: 16);
  static const SizedBox onboardHeaderSpacing = SizedBox(height: 40);
  static const EdgeInsets onboardHorizontalPadding = EdgeInsets.symmetric(
    horizontal: 24,
  );
  static const SizedBox onboardNotificationCardTopSpacing = SizedBox(
    height: 80,
  );
  static const EdgeInsets onboardNotificationCardPadding = EdgeInsets.all(16);
  static const double onboardNotificationCardBorderRadius = 24.0;
  static const double onboardNotificationCardSurfaceAlpha = 0.95;
  static const double onboardNotificationCardBorderAlpha = 0.5;
  static const double onboardNotificationCardShadowBlur = 50.0;
  static const Offset onboardNotificationCardShadowOffset = Offset(0, 25);
  static const double onboardNotificationIconSize = 44.0;
  static const double onboardNotificationIconBorderRadius = 8.0;
  static const SizedBox onboardNotificationIconSpacing = SizedBox(width: 12);
  static const SizedBox onboardNotificationTitleSpacing = SizedBox(height: 2);
  static const SizedBox onboardFooterClearanceSpacing = SizedBox(height: 140);
  static const double onboardBuildingProfileCarouselHeight = 110.0;
  static const SizedBox onboardBuildingProfileCarouselSpacing = SizedBox(
    height: 48,
  );
  static const double onboardBuildingProfileProgressSize = 340.0;
  static const double onboardBuildingProfileProgressStrokeWidth = 15.0;
  static const EdgeInsets onboardBuildingProfileProgressTextPadding =
      EdgeInsets.all(40);
  static const EdgeInsets onboardBuildingProfileStatusTopPadding =
      EdgeInsets.only(top: 8);
  static const SizedBox onboardBuildingProfileBottomSpacing = SizedBox(
    height: 56,
  );
  static const EdgeInsets onboardProfileSummaryCardPadding = EdgeInsets.all(16);
  static const double onboardProfileSummaryIconContainerSize = 48.0;
  static const double onboardProfileSummaryIconContainerRadius = 14.0;
  static const double onboardProfileSummaryIconSize = 24.0;
  static const SizedBox onboardProfileSummaryIconSpacing = SizedBox(width: 12);
  static const double onboardMascotScreenHeightFactor = 0.225;
  static const EdgeInsets onboardContinueButtonPadding = EdgeInsets.symmetric(
    vertical: 16,
  );
  static const double onboardContinueButtonDisabledAlpha = 0.5;
  static const EdgeInsets onboardExperienceOptionPadding = EdgeInsets.all(16);
  static const double onboardExperienceOptionBorderWidth = 2.0;
  static const double onboardExperienceIconContainerSize = 48.0;
  static const EdgeInsets onboardExperienceIconPadding = EdgeInsets.all(12);
  static const double onboardExperienceIconSize = 20.0;
  static const SizedBox onboardExperienceOptionContentSpacing = SizedBox(
    width: 16,
  );
  static const SizedBox onboardExperienceTitleSpacing = SizedBox(height: 4);
  static const double onboardHighlightFooterTextHeight = 160.0;
  static const double onboardHighlightIndicatorSize = 32.0;
  static const EdgeInsets onboardHighlightIndicatorMargin = EdgeInsets.only(
    right: 12,
  );
  static const double onboardLandingMascotTopFactor = 0.24;
  static const EdgeInsets onboardLandingMascotPadding = EdgeInsets.symmetric(
    horizontal: 40,
  );
  static const double onboardLandingMascotHeight = 255.0;
  static const double onboardLandingChartTopOffset = 15.0;
  static const double onboardLandingChartHeight = 200.0;
  static const List<double> onboardLandingChartFadeStops = [0.0, 0.5, 1.0];
  static const double onboardLandingChartFillAlpha = 0.1;
  static const double onboardLandingChartGradientStartAlpha = 0.2;
  static const double onboardLandingChartGradientEndAlpha = 0.0;
  static const Duration onboardProgressAnimationDuration = Duration(
    milliseconds: 300,
  );
  static const double onboardSectorChipSpacing = 12.0;
  static const EdgeInsets onboardSectorChipPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );
  static const double onboardSectorChipBorderRadius = 100.0;
  static const double onboardSectorChipBorderWidth = 2.0;
  static const double onboardSectorCheckboxSize = 20.0;
  static const double onboardSectorCheckboxBorderRadius = 4.0;
  static const double onboardSectorCheckIconSize = 14.0;

  // Bizzie Chat
  static const double chatModalHeightFactor = 0.875;
  static const double chatModalHeightFactorKeyboard = 0.78;
  static const double chatModalTopRadius = 20.0;
  static const double chatScrollAtBottomThreshold = 80.0;
  static const double chatFabSize = 36.0;
  static const double chatFabShadowBlur = 8.0;
  static const double chatFabIconSize = 22.0;
  static const double chatFabBottomOffset = 8.0;
  static const double chatActionIconSize = 18.0;
  static const double chatEmptyStatePadding = 32.0;
  static const double chatEmptyStateIconContainerSize = 64.0;
  static const double chatEmptyStateIconSize = 32.0;
  static const double chatMascotThinkingSize = 28.0;
  static const double chatThinkingRowSpacing = 10.0;
  static const EdgeInsets chatListPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
  );
  static const double chatFooterFeedbackPaddingV = 4.0;
  static const double chatFooterDisclaimerPaddingBottom = 16.0;
  static const double chatFollowUpHeaderPaddingH = 8.0;
  static const double chatFollowUpHeaderPaddingV = 16.0;
  static const double chatFollowUpChevronSize = 20.0;
  static const double chatFollowUpItemPaddingV = 8.0;
  static const double chatBubbleMascotSize = 40.0;
  static const double chatBubbleMascotSpacing = 16.0;
  static const double chatBubbleVerticalPadding = 6.0;
  static const double chatUserBubbleVerticalPadding = 32.0;
  static const double chatBubblePaddingH = 14.0;
  static const double chatBubblePaddingV = 10.0;
  static const double chatBubbleRadiusLarge = 16.0;
  static const double chatBubbleRadiusSmall = 4.0;
  static const double chatMarkdownLineHeight = 1.7;
  static const double chatMarkdownBlockSpacing = 6.0;
  static const double chatMarkdownListIndent = 16.0;
  static const double chatMarkdownCodeRadius = 8.0;
  static const double chatMarkdownBlockquotePaddingH = 12.0;
  static const double chatMarkdownBlockquotePaddingV = 4.0;
  static const double chatMarkdownBlockquoteBorderWidth = 3.0;
  static const double chatInputPaddingH = 16.0;
  static const double chatInputPaddingV = 12.0;
  static const double chatInputBorderRadius = 24.0;
  static const double chatSendButtonSize = 44.0;
  static const double chatSendIconSize = 20.0;
  static const double chatSendButtonSpacing = 8.0;
  static const double chatTabHintOuterPaddingH = 32.0;
  static const double chatHintChipPaddingH = 16.0;
  static const double chatHintChipPaddingV = 16.0;
  static const double chatHintChipRadius = 10.0;

  // Edit Tabs Modal
  static const double editTabsModalHeightFactor = 0.85;
  static const EdgeInsets editTabsSaveButtonPadding = EdgeInsets.fromLTRB(
    16,
    8,
    16,
    16,
  );
  static const EdgeInsets editTabsItemPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 16,
  );
  static const EdgeInsets editTabsDividerPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );
  static const EdgeInsets editTabsDividerLabelPadding = EdgeInsets.symmetric(
    horizontal: 12,
  );
  static const double editTabsLockIconSize = 16.0;
  static const double editTabsDragHandleOpacity = 0.4;

  // More Tab
  static const double moreTabLockIconSize = 16.0;
  static const EdgeInsets moreTabModalEditButtonPadding = EdgeInsets.fromLTRB(
    16,
    8,
    16,
    16,
  );

  // Subscription
  static const double subscriptionContentBottomInset = 120.0;
  static const double discountedSubscriptionContentBottomInset = 100.0;
  static const Duration paywallOnEnterDelay = Duration(milliseconds: 300);

  // Settings
  static const EdgeInsets settingsListPadding = EdgeInsets.only(bottom: 32);
  static const EdgeInsets settingsFooterPadding = EdgeInsets.all(24);
  static const EdgeInsets settingsPermissionSheetPadding = EdgeInsets.all(24);
  static const double settingsTileDividerHeight = 1.0;
  static const double settingsTileDividerIndent = 52.0;
  static const double settingsDiscountBadgeBorderRadius = 50.0;
  static const EdgeInsets settingsDiscountBadgePadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 6,
  );
}
