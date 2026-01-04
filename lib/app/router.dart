import 'package:bizzie/app/routes/app_routes.dart';
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
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/shared/utils/go_router_refresh_stream.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/di/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GoRouter createRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: AppRoutes.landing,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final bool isAuthenticated = authState.when(
        initial: () => false,
        loading: () => false,
        authenticated: (_) => true,
        unauthenticated: () => false,
        failure: (_) => false,
      );

      final isGoingToLogin = state.uri.path == AppRoutes.login;
      final isGoingToLanding = state.uri.path == AppRoutes.landing;

      if (!isAuthenticated) {
        const publicRoutes = [
          AppRoutes.landing,
          AppRoutes.login,
          AppRoutes.createAccount,
          AppRoutes.forgotPassword,
          AppRoutes.emailSent,
          AppRoutes.terms,
          AppRoutes.privacy,
          AppRoutes.onboardingName,
          AppRoutes.onboardingWelcome,
          AppRoutes.onboardingSectors,
          AppRoutes.onboardingMeetBizzie,
          AppRoutes.onboardingExperience,
          AppRoutes.onboardingFeatureHighlights,
          AppRoutes.onboardingBrands,
          AppRoutes.onboardingAnalyzing,
          AppRoutes.onboardingFoundCompanies,
          AppRoutes.onboardingAddingWatchlist,
          AppRoutes.onboardingBuildingProfile,
          AppRoutes.onboardingProfileReady,
          AppRoutes.notificationRequest,
        ];

        final isPublic = publicRoutes.any((route) => state.uri.path == route);

        if (!isPublic) {
          return AppRoutes.landing;
        }
      } else {
        if (isGoingToLanding || isGoingToLogin) {
          return AppRoutes.home;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
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
                AppRoutes.notificationRequest,
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
