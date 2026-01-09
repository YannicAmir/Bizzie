import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouterRedirect {
  final AuthState authState;
  final UserState userState;
  final GoRouterState state;

  AppRouterRedirect({
    required this.authState,
    required this.userState,
    required this.state,
  });

  String? computeRedirect() {
    final bool isAuthDetermined = authState.maybeMap(
      authenticated: (_) => true,
      unauthenticated: (_) => true,
      failure: (_) => true,
      orElse: () => false,
    );

    final bool isAuthenticated = authState.maybeMap(
      authenticated: (_) => true,
      orElse: () => false,
    );

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

    if (!isAuthDetermined) {
      if (isPublic) {
        return null;
      } else {
        if (!isSplash) return AppRoutes.splash;
        return null;
      }
    }

    if (!isAuthenticated) {
      if (!isPublic) {
        return AppRoutes.landing;
      }

      if (isSplash) {
        return AppRoutes.landing;
      }
    } else {
      final isUserLoading = userState.maybeWhen(
        initial: () => true,
        loading: (_) => true,
        orElse: () => false,
      );

      if (isUserLoading) {
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
  }
}
