class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String login = '/login';
  static const String createAccount = '/create-account';
  static const String forgotPassword = '/forgot-password';
  static const String emailSent = '/email-sent';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
  static const String notificationRequest = '/notifications';
  static const String companyProfile = '/company/:ticker';

  static const String reports = '/reports';
  static const String profile = '/profile';

  // Namespaced Company Profile Routes for Bottom Nav Stacks
  static const String companyProfileHome = 'companyProfileHome';
  static const String companyProfileReports = 'companyProfileReports';
  static const String companyProfileProfile = 'companyProfileProfile';
  static const String onboardingNotifications = '/onboarding/notifications';
  static const String landing = '/landing';
  static const String onboardingName = '/onboarding/name';
  static const String onboardingWelcome = '/onboarding/welcome';
  static const String onboardingSectors = '/onboarding/sectors';
  static const String onboardingMeetBizzie = '/onboarding/meet-bizzie';
  static const String onboardingBrands = '/onboarding/brands';
  static const String onboardingAnalyzing = '/onboarding/analyzing';
  static const String onboardingFoundCompanies = '/onboarding/found-companies';
  static const String onboardingAddingWatchlist =
      '/onboarding/adding-watchlist';
  static const String onboardingBuildingProfile =
      '/onboarding/building-profile';
  static const String onboardingProfileReady = '/onboarding/profile-ready';
  static const String onboardingExperience = '/onboarding/experience';
  static const String onboardingFeatureHighlights = '/onboarding/highlights';
  static const String navHome = '/home';
  static const String search = '/search';
  static const String splash = '/splash';
}
