import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/auth/presentation/views/create_account_page.dart';
import 'package:bizzie/features/auth/presentation/views/email_sent_page.dart';
import 'package:bizzie/features/auth/presentation/views/forgot_password_page.dart';
import 'package:bizzie/features/auth/presentation/views/login_page.dart';
import 'package:bizzie/features/home/presentation/views/home_page.dart';
import 'package:bizzie/features/notifications/presentation/views/notification_request_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/ask_name_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/landing_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/feature_highlights_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/meet_your_bizzie_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/name_your_favorite_brands_page.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/di/injection.dart';

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
      // final isGoingToCreateAccount = state.uri.path == AppRoutes.createAccount; // Removed
      final isGoingToLanding = state.uri.path == AppRoutes.landing;

      // If not authenticated and trying to go to a protected route (like Home),
      // redirect to Landing (or Login).
      // Here we allow specific routes to be public.
      if (!isAuthenticated) {
        // List of public routes
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
          // Redirect to Landing if trying to access protected route (Home)
          return AppRoutes.landing;
        }
      } else {
        // If authenticated, redirect away from Landing/Login pages to Home
        // Note: We exclude CreateAccount here to allow the page's BlocListener to handle
        // the navigation to BuildingProfilePage upon successful sign-up.
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
        path: AppRoutes.createAccount,
        builder: (context, state) => const CreateAccountPage(),
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
      GoRoute(
        path: AppRoutes.notificationRequest,
        builder: (context, state) => const NotificationRequestPage(),
      ),
      GoRoute(
        path: AppRoutes.landing,
        builder: (context, state) => const LandingPage(),
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
            path: AppRoutes.onboardingName,
            builder: (context, state) => const AskNamePage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingWelcome,
            builder: (context, state) => const WelcomeNamePage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingExperience,
            builder: (context, state) => const InvestingExperiencePage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingFeatureHighlights,
            builder: (context, state) => const FeatureHighlightsPage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingSectors,
            builder: (context, state) => const SectorSelectionPage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingMeetBizzie,
            builder: (context, state) => const MeetYourBizziePage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingBrands,
            builder: (context, state) => const NameYourFavoriteBrandsPage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingAnalyzing,
            builder: (context, state) => const AnalyzingBrandsPage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingFoundCompanies,
            builder: (context, state) => const BizzieFoundCompaniesPage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingAddingWatchlist,
            builder: (context, state) => const AddingToWatchlistPage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingBuildingProfile,
            builder: (context, state) => const BuildingProfilePage(),
          ),
          GoRoute(
            path: AppRoutes.onboardingProfileReady,
            builder: (context, state) => const ProfileReadyPage(),
          ),
        ],
      ),
    ],
  );
}
