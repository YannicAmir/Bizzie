import 'package:bizzie/app/routes/app_router_redirect.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart'
    as auth_user;
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';

import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart'
    as onboarding_user;
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouterState extends Mock implements GoRouterState {}

void main() {
  late MockGoRouterState mockState;

  setUp(() {
    mockState = MockGoRouterState();
    registerFallbackValue(Uri.parse('http://localhost'));
  });

  group('AppRouterRedirect', () {
    const tUserId = 'user123';

    final tAuthUser = auth_user.UserModel(
      id: tUserId,
      email: 'test@example.com',
    );

    final tOnboardingUser = onboarding_user.UserModel(
      uid: tUserId,
      name: 'Test',
      favoriteSector: 'Tech',
      watchlist: [],
      investingExperience: InvestingExperience.beginner,
      createdAt: DateTime.now(),
      isSubscribed: false,
      fcmTokens: {},
    );

    test('computeRedirect_authUndeterminedPublicRoute_returnsNull', () {
      // arrange
      final authState = const AuthState.initial();
      final userState = const UserState.initial();
      when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.login));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, isNull);
    });

    test('computeRedirect_authUndeterminedPrivateRoute_returnsSplash', () {
      // arrange
      final authState = const AuthState.initial();
      final userState = const UserState.initial();
      when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.home));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, AppRoutes.splash);
    });

    test('computeRedirect_unauthenticatedPrivateRoute_returnsLanding', () {
      // arrange
      final authState = const AuthState.unauthenticated();
      final userState = const UserState.initial();
      when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.home));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, AppRoutes.landing);
    });

    test('computeRedirect_unauthenticatedPublicRoute_returnsNull', () {
      // arrange
      final authState = const AuthState.unauthenticated();
      final userState = const UserState.initial();
      when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.login));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, isNull);
    });

    test('computeRedirect_authenticatedUserLoading_returnsNull', () {
      // arrange
      final authState = AuthState.authenticated(tAuthUser);
      final userState = const UserState.loading();
      when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.splash));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, isNull);
    });

    test('computeRedirect_authenticatedNeedsProfile_returnsOnboardingName', () {
      // arrange
      final authState = AuthState.authenticated(tAuthUser);
      final userState = const UserState.needsProfile();
      when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.home));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, AppRoutes.onboardingName);
    });

    test('computeRedirect_authenticatedHasProfileOnSplash_returnsHome', () {
      // arrange
      final authState = AuthState.authenticated(tAuthUser);
      final userState = UserState.loaded(tOnboardingUser);
      when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.splash));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, AppRoutes.home);
    });
  });
}
