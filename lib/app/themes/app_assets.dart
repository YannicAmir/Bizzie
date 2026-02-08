class AppAssets {
  AppAssets._();

  // Auth Feature
  static const String authAppleIcon = 'assets/images/auth/apple_icon.png';
  static const String authEmailIcon = 'assets/images/auth/email_icon.svg';
  static const String authGoogleIcon = 'assets/images/auth/google_icon.png';
  static const String authHidePasswordIcon =
      'assets/images/auth/hide_password_icon.png';
  static const String authLockIcon = 'assets/images/auth/lock_icon.svg';
  static const String authShowPasswordIcon =
      'assets/images/auth/show_password_icon.png';

  static const String splashLogo = 'assets/images/branding/splash_logo.png';
  static const String appIcon = 'assets/images/branding/app_icon.png';

  static const String authForgotPasswordMascot =
      'assets/images/auth/forgot_password_mascot.png';

  static const String authEmailSentMascot =
      'assets/images/auth/email_sent_mascot.png';

  // Onboarding Feature
  static const String onboardingBizzieMascot =
      'assets/images/onboarding/bizzie_mascot_waving_hello.png';
  static const String onboardingBizzieMascotAskName =
      'assets/images/onboarding/bizzie_mascot_ask_name.png';
  static const String onboardingBizzieMascotWelcome =
      'assets/images/onboarding/bizzie_mascot_welcome.png';
  static const String onboardingBizzieMascotInvestingExperience =
      'assets/images/onboarding/bizzie_mascot_investing_experience.png';
  static const String onboardingBizzieMascotFoundCompanies =
      'assets/images/onboarding/bizzie_mascot_found_companies.png';
  static const String favoriteSectorIcon =
      'assets/images/onboarding/favorite_sector_icon.png';
  static const String favoriteBrandsIcon =
      'assets/images/onboarding/favorite_brands_icon.png';
  static const String investorClassificationIcon =
      'assets/images/onboarding/investor_classification_icon.png';
  static const String onboardingLargeCheckIcon =
      'assets/images/onboarding/onboarding_large_check_icon.png';
  static const String onboardingLargePlusIcon =
      'assets/images/onboarding/onboarding_large_plus_icon.png';
  static const String arrowDownIcon =
      'assets/images/onboarding/arrow_down_icon.png';

  // Search Feature
  static const String searchIconLarge =
      'assets/images/search/search_icon_large.png';

  // Home Feature
  static const String homeUnselectedIcon =
      'assets/images/home/home_unselected_icon.svg';
  static const String homeSelectedIcon =
      'assets/images/home/home_selected_icon.svg';
  static const String homeReportsUnselectedIcon =
      'assets/images/home/reports_unselected_icon.svg';
  static const String homeReportsSelectedIcon =
      'assets/images/home/reports_selected_icon.svg';
  static const String homeProfileUnselectedIcon =
      'assets/images/home/profile_unselected_icon.svg';
  static const String homeProfileSelectedIcon =
      'assets/images/home/profile_selected_icon.svg';

  // Company Profile Feature
  static const String companyProfileWebsiteIcon =
      'assets/images/company_profile/website_icon.svg';
  static const String companyProfileLocationIcon =
      'assets/images/company_profile/location_icon.svg';
  static const String companyProfileDocIcon =
      'assets/images/company_profile/doc_icon.svg';
  static const String totalRevenueIcon =
      'assets/images/company_profile/total_revenue_icon.png';
  static const String chartGrowthIcon =
      'assets/images/company_profile/chart_growth_icon.png';
  static const String companyProfileCalendarIcon =
      'assets/images/company_profile/upcoming_earnings_calendar_icon.svg';

  // Shared
  static const String backArrowIcon =
      'assets/images/shared/back_arrow_icon.png';
  static const String searchIcon = 'assets/images/shared/search_icon.png';
  static const String circledCheckIcon =
      'assets/images/shared/circled_check_icon.png';
  static const String arrowUpIcon = 'assets/images/shared/arrow_up_icon.png';
  static const String plusIcon = 'assets/images/shared/plus_icon.png';
  static const String checkIcon = 'assets/images/shared/check_icon.png';
  static const String barChartIcon = 'assets/images/shared/bar_chart_icon.png';
  static const String sparkleIcon = 'assets/images/shared/sparkle_icon.png';
  static const String defaultMascot = 'assets/images/shared/default_mascot.png';
  static const String bizzieMascotIT =
      'assets/images/shared/bizzie_mascot_it.png';
  static const String bizzieMascotFinancials =
      'assets/images/shared/bizzie_mascot_financials.png';
  static const String bizzieMascotCommunicationServices =
      'assets/images/shared/bizzie_mascot_communication_services.png';
  static const String bizzieMascotConsumerDiscretionary =
      'assets/images/shared/bizzie_mascot_consumer_discretionary.png';
  static const String bizzieMascotConsumerStaples =
      'assets/images/shared/bizzie_mascot_consumer_staples.png';
  static const String bizzieMascotEnergy =
      'assets/images/shared/bizzie_mascot_energy.png';
  static const String bizzieMascotHealthcare =
      'assets/images/shared/bizzie_mascot_healthcare.png';
  static const String bizzieMascotIndustrials =
      'assets/images/shared/bizzie_mascot_industrials.png';
  static const String bizzieMascotMaterials =
      'assets/images/shared/bizzie_mascot_materials.png';
  static const String bizzieMascotRealEstate =
      'assets/images/shared/bizzie_mascot_real_estate.png';
  static const String bizzieMascotUtilities =
      'assets/images/shared/bizzie_mascot_utilities.png';
  static const String bellIcon = 'assets/images/shared/bell_icon.png';
  static const String businessIcon = 'assets/images/shared/business_icon.svg';
  static const String clearTextfieldIcon =
      'assets/images/shared/clear_textfield_icon.png';
  static const String modalCloseIcon =
      'assets/images/shared/modal_close_icon.svg';
  static const String bizziePlusIcon =
      'assets/images/shared/bizzie_plus_icon.svg';

  static String getMascotForSector(String sector) {
    final normalized = sector.trim().replaceAll('_', ' ').toLowerCase();
    switch (normalized) {
      case 'information technology':
      case 'informationtechnology':
      case 'technology':
        return bizzieMascotIT;
      case 'financials':
        return bizzieMascotFinancials;
      case 'communication services':
      case 'communicationservices':
        return bizzieMascotCommunicationServices;
      case 'consumer discretionary':
      case 'consumerdiscretionary':
        return bizzieMascotConsumerDiscretionary;
      case 'consumer staples':
      case 'consumerstaples':
        return bizzieMascotConsumerStaples;
      case 'energy':
        return bizzieMascotEnergy;
      case 'healthcare':
      case 'health care':
        return bizzieMascotHealthcare;
      case 'industrials':
        return bizzieMascotIndustrials;
      case 'materials':
        return bizzieMascotMaterials;
      case 'real estate':
      case 'realestate':
        return bizzieMascotRealEstate;
      case 'utilities':
        return bizzieMascotUtilities;
      default:
        if (normalized.contains('tech')) return bizzieMascotIT;
        if (normalized.contains('finance')) return bizzieMascotFinancials;
        if (normalized.contains('health')) return bizzieMascotHealthcare;
        return defaultMascot;
    }
  }
}
