import 'package:bizzie/app/routes/app_routes.dart';
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
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
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
      // Check if Auth is truly determined (auth/unauth/failure).
      // If Initial or Loading, we're not ready to redirect.
      final bool isAuthDetermined = authState.maybeMap(
        authenticated: (_) => true,
        unauthenticated: (_) => true,
        failure: (_) =>
            true, // Treat failure as determined (likely to stay on splash or go to error?) - usually unauth or stay.
        orElse: () => false,
      );

      final bool isAuthenticated = authState.maybeMap(
        authenticated: (_) => true,
        orElse: () => false,
      );

      final userState = userBloc.state;
      final bool needsProfile = userState.maybeWhen(
        needsProfile: () => true,
        orElse: () => false,
      );

      final isGoingToLogin = state.uri.path == AppRoutes.login;
      final isGoingToLanding = state.uri.path == AppRoutes.landing;
      final isSplash = state.uri.path == AppRoutes.splash;

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
        AppRoutes.onboardingNotifications,
        AppRoutes.splash,
      ];

      final isPublic = publicRoutes.any((route) => state.uri.path == route);

      // If Auth is NOT determined yet (Initial/Loading):
      // 1. If we are on a PUBLIC route (e.g. Login page doing Apple Sign In), let them stay there.
      // 2. If we are on a PRIVATE route, redirect to Splash to wait.
      if (!isAuthDetermined) {
        if (isPublic) {
          return null; // Stay on current public page (e.g. Login)
        } else {
          // If not public (e.g. Home), and we don't know auth yet, go to Splash.
          if (!isSplash) return AppRoutes.splash;
          return null;
        }
      }

      // Auth IS Determined below here.

      if (!isAuthenticated) {
        if (!isPublic) {
          return AppRoutes.landing;
        }

        // If we are still on Splash but Unauthenticated, go to Landing
        if (isSplash) {
          return AppRoutes.landing;
        }
      } else {
        // Authenticated
        final isUserLoading = userState.maybeWhen(
          initial: () => true,
          loading: (_) => true,
          orElse: () => false,
        );

        if (isUserLoading) {
          // If on Splash, keep waiting (return null).
          // If we were on landing/login, we might arguably want to stay there or show loading.
          // But usually 'User Loading' means we are fetching profile.
          // If we are on Splash, stay on Splash.
          if (isSplash) return null;
          return null;
        }

        if (needsProfile) {
          if (!state.uri.path.startsWith('/onboarding') &&
              state.uri.path != AppRoutes.onboardingName) {
            return AppRoutes.onboardingName;
          }
        } else if (isGoingToLanding || isGoingToLogin || isSplash) {
          return AppRoutes.home;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox.shrink(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      _buildNoTransitionRoute(AppRoutes.login, const LoginPage()),

      GoRoute(
        path: AppRoutes.search,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider<SearchBloc>(
              create: (_) =>
                  getIt<SearchBloc>()..add(const SearchEvent.started()),
              child: const SearchPage(),
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
