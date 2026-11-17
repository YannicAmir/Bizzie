import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:go_router/go_router.dart';

const _guestAuthRoutes = [AppRoutes.guestCreateAccount, AppRoutes.guestLogin];

const _publicRoutes = [
  AppRoutes.landing,
  AppRoutes.login,
  AppRoutes.createAccount,
  AppRoutes.forgotPassword,
  AppRoutes.emailSent,
  AppRoutes.terms,
  AppRoutes.privacy,
  ..._guestAuthRoutes,
  AppRoutes.splash,
];

bool _isOnboardingPath(String path) =>
    path.startsWith(AppRoutes.onboardingPrefix);

class AppRouterRedirect {
  static bool isOnboardingFlowPath(String path) =>
      path == AppRoutes.landing ||
      path == AppRoutes.createAccount ||
      _isOnboardingPath(path);

  final AuthState authState;
  final UserState userState;
  final GoRouterState state;

  AppRouterRedirect({
    required this.authState,
    required this.userState,
    required this.state,
  });

  String? computeRedirect() {
    if (_isAuthActionInProgress) return null;
    if (!_isAuthDetermined) return _redirectWhenUndetermined();
    if (!_isAuthenticated) return _redirectWhenUnauthenticated();
    return _redirectWhenAuthenticated();
  }

  String? _redirectWhenUndetermined() {
    if (_isPublic || _isSplash) return null;
    return AppRoutes.splash;
  }

  String? _redirectWhenUnauthenticated() {
    if (!_isPublic || _isSplash) return AppRoutes.landing;
    return null;
  }

  String? _redirectWhenAuthenticated() {
    if (_isUserLoading) return null;
    if (_needsProfile) return _redirectWhenNeedsProfile();
    if (_isGoingToLanding || _isGoingToLogin || _isSplash) {
      return AppRoutes.home;
    }
    return null;
  }

  String? _redirectWhenNeedsProfile() {
    if (_isGuestAuthRoute || _isGuestOnEntryRoute || _isOnboardingPath(_path)) {
      return null;
    }
    return AppRoutes.onboardingSectors;
  }

  String get _path => state.uri.path;

  bool get _isAuthDetermined => authState.maybeMap(
    authenticated: (_) => true,
    unauthenticated: (_) => true,
    failure: (_) => true,
    orElse: () => false,
  );

  bool get _isAuthActionInProgress =>
      authState.maybeMap(loading: (_) => true, orElse: () => false);

  bool get _isAuthenticated =>
      authState.maybeMap(authenticated: (_) => true, orElse: () => false);

  bool get _isUserLoading => userState.maybeWhen(
    initial: () => true,
    loading: (_) => true,
    orElse: () => false,
  );

  bool get _needsProfile =>
      userState.maybeWhen(needsProfile: () => true, orElse: () => false);

  bool get _isGoingToLogin => _path == AppRoutes.login;

  bool get _isGoingToLanding => _path == AppRoutes.landing;

  bool get _isSplash => _path == AppRoutes.splash;

  bool get _isPublic =>
      _isOnboardingPath(_path) || _publicRoutes.contains(_path);

  bool get _isGuestAuthRoute => _guestAuthRoutes.contains(_path);

  bool get _isGuestOnEntryRoute =>
      authState.isGuest && (_isGoingToLanding || _isGoingToLogin);
}
