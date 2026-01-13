import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/routes/app_router_redirect.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/search/presentation/views/search_page.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';

import 'package:bizzie/features/auth/presentation/views/create_account_page.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_shell.dart';
import 'package:bizzie/features/auth/presentation/views/email_sent_page.dart';
import 'package:bizzie/features/auth/presentation/views/forgot_password_page.dart';
import 'package:bizzie/features/auth/presentation/views/login_page.dart';
import 'package:bizzie/features/home/presentation/views/home_page.dart';
import 'package:bizzie/features/notifications/presentation/views/notification_request_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/ask_name_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/landing_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/feature_highlights_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/meet_your_bizzie_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/select_your_favorite_brands_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/analyzing_brands_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/bizzie_found_companies_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/building_profile_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/profile_ready_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/adding_to_watchlist_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/investing_experience_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/sector_selection_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/welcome_name_page.dart';
import 'package:bizzie/features/company_profile/presentation/views/company_profile_page.dart';
import 'package:bizzie/features/reports/presentation/views/reports_page.dart';
import 'package:bizzie/features/profile/presentation/views/profile_page.dart';
import 'package:bizzie/app/navigation/bizzie_bottom_nav_wrapper.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:bizzie/shared/utils/go_router_refresh_stream.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/di/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:async/async.dart';

GoRouter createRouter(AuthBloc authBloc, UserBloc userBloc) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: GoRouterRefreshStream(
      StreamGroup.merge([authBloc.stream, userBloc.stream]),
    ),
    redirect: (context, state) {
      final authState = authBloc.state;
      final userState = userBloc.state;

      return AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: state,
      ).computeRedirect();
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox.shrink(),
        ),
      ),
      _buildNoTransitionRoute(AppRoutes.login, const LoginPage()),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BizzieBottomNavWrapper(navigationShell: navigationShell);
        },
        branches: [
          // BRANCH 1: HOME
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomePage(),
                routes: [_buildCompanyRoute(AppRoutes.companyProfileHome)],
              ),
            ],
          ),

          // BRANCH 2: REPORTS
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.reports,
                builder: (context, state) => const ReportsPage(),
                routes: [_buildCompanyRoute(AppRoutes.companyProfileReports)],
              ),
            ],
          ),

          // BRANCH 3: PROFILE
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfilePage(),
                routes: [_buildCompanyRoute(AppRoutes.companyProfileProfile)],
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.search,
        pageBuilder: (context, state) {
          final sourceTab = state.extra as String?;
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider<SearchBloc>(
              create: (_) =>
                  getIt<SearchBloc>()..add(const SearchEvent.started()),
              child: SearchPage(sourceTab: sourceTab),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return child;
                },
            transitionDuration: Duration.zero,
          );
        },
      ),

      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.emailSent,
        builder: (context, state) => const EmailSentPage(),
      ),
      GoRoute(
        path: AppRoutes.terms,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Terms of Service Screen')),
        ),
      ),
      GoRoute(
        path: AppRoutes.privacy,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Privacy Policy Screen'))),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider<OnboardingBloc>(
            create: (_) =>
                getIt<OnboardingBloc>()..add(const OnboardingEvent.started()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.landing,
            builder: (context, state) => const LandingPage(),
          ),
          ShellRoute(
            builder: (context, state, child) {
              return OnboardingShell(child: child);
            },
            routes: [
              _buildNoTransitionRoute(
                AppRoutes.onboardingName,
                const AskNamePage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingWelcome,
                const WelcomeNamePage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingExperience,
                const InvestingExperiencePage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingFeatureHighlights,
                const FeatureHighlightsPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingSectors,
                const SectorSelectionPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingMeetBizzie,
                const MeetYourBizziePage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingBrands,
                const SelectYourFavoriteBrandsPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingAnalyzing,
                const AnalyzingBrandsPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingFoundCompanies,
                const BizzieFoundCompaniesPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingAddingWatchlist,
                const AddingToWatchlistPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingBuildingProfile,
                const BuildingProfilePage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingProfileReady,
                const ProfileReadyPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.createAccount,
                const CreateAccountPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingNotifications,
                const NotificationRequestPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

GoRoute _buildNoTransitionRoute(String path, Widget child) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      transitionDuration: Duration.zero,
    ),
  );
}

GoRoute _buildCompanyRoute(String routeName) {
  return GoRoute(
    path: 'company/:ticker',
    name: routeName,
    builder: (context, state) {
      final ticker = state.pathParameters['ticker']!;
      final company = state.extra as Company?;
      return CompanyProfilePage(ticker: ticker, company: company);
    },
  );
}
