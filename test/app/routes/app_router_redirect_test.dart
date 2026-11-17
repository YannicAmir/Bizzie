import 'package:bizzie/app/routes/app_router_redirect.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart'
    as auth_user;
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/auth/presentation/enums/auth_loading_method.dart';

import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/core/domain/models/user_model.dart' as onboarding_user;
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

    final tGuestUser = auth_user.UserModel(
      id: tUserId,
      email: '',
      isAnonymous: true,
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

    test(
      'computeRedirect_authenticatedNeedsProfile_returnsOnboardingSectors',
      () {
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
        expect(result, AppRoutes.onboardingSectors);
      },
    );

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
    test(
      'computeRedirect_authenticatedGuestOnGuestCreateAccount_returnsNull',
      () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        final userState = UserState.loaded(tOnboardingUser);
        when(
          () => mockState.uri,
        ).thenReturn(Uri.parse(AppRoutes.guestCreateAccount));

        // act
        final result = AppRouterRedirect(
          authState: authState,
          userState: userState,
          state: mockState,
        ).computeRedirect();

        // assert
        expect(result, isNull);
      },
    );

    test('computeRedirect_authenticatedGuestOnGuestLogin_returnsNull', () {
      // arrange
      final authState = AuthState.authenticated(tGuestUser);
      final userState = UserState.loaded(tOnboardingUser);
      when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.guestLogin));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, isNull);
    });

    test('computeRedirect_authLoadingOnGuestCreateAccount_returnsNull', () {
      // arrange
      final authState = const AuthState.loading(
        method: AuthLoadingMethod.emailSignUp,
      );
      final userState = UserState.loaded(tOnboardingUser);
      when(
        () => mockState.uri,
      ).thenReturn(Uri.parse(AppRoutes.guestCreateAccount));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, isNull);
    });

    test('computeRedirect_authLoadingOnGuestLogin_returnsNull', () {
      // arrange
      final authState = const AuthState.loading(
        method: AuthLoadingMethod.google,
      );
      final userState = UserState.loaded(tOnboardingUser);
      when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.guestLogin));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, isNull);
    });

    test('computeRedirect_authLoadingOnShellLocation_returnsNull', () {
      // arrange
      final authState = const AuthState.loading(
        method: AuthLoadingMethod.emailSignUp,
      );
      final userState = UserState.loaded(tOnboardingUser);
      when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.home));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, isNull);
    });

    test('computeRedirect_authFailureOnGuestCreateAccount_returnsNull', () {
      // arrange
      final authState = const AuthState.failure(Failure.emailAlreadyInUse());
      final userState = UserState.loaded(tOnboardingUser);
      when(
        () => mockState.uri,
      ).thenReturn(Uri.parse(AppRoutes.guestCreateAccount));

      // act
      final result = AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: mockState,
      ).computeRedirect();

      // assert
      expect(result, isNull);
    });

    test(
      'computeRedirect_authenticatedGuestNeedsProfileOnGuestCreateAccount_returnsNull',
      () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        final userState = const UserState.needsProfile();
        when(
          () => mockState.uri,
        ).thenReturn(Uri.parse(AppRoutes.guestCreateAccount));

        // act
        final result = AppRouterRedirect(
          authState: authState,
          userState: userState,
          state: mockState,
        ).computeRedirect();

        // assert
        expect(result, isNull);
      },
    );

    test(
      'computeRedirect_authenticatedNeedsProfileOnOnboardingFinishing_returnsNull',
      () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        final userState = const UserState.needsProfile();
        when(
          () => mockState.uri,
        ).thenReturn(Uri.parse(AppRoutes.onboardingFinishing));

        // act
        final result = AppRouterRedirect(
          authState: authState,
          userState: userState,
          state: mockState,
        ).computeRedirect();

        // assert
        expect(result, isNull);
      },
    );

    test(
      'computeRedirect_unauthenticatedOnOnboardingFinishing_returnsNull',
      () {
        // arrange
        final authState = const AuthState.unauthenticated();
        final userState = const UserState.initial();
        when(
          () => mockState.uri,
        ).thenReturn(Uri.parse(AppRoutes.onboardingFinishing));

        // act
        final result = AppRouterRedirect(
          authState: authState,
          userState: userState,
          state: mockState,
        ).computeRedirect();

        // assert
        expect(result, isNull);
      },
    );

    test(
      'computeRedirect_reauthenticatedGuestAfterLinkFailureOnHome_returnsNull',
      () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        final userState = UserState.loaded(tOnboardingUser);
        when(() => mockState.uri).thenReturn(Uri.parse(AppRoutes.home));

        // act
        final result = AppRouterRedirect(
          authState: authState,
          userState: userState,
          state: mockState,
        ).computeRedirect();

        // assert
        expect(result, isNull);
      },
    );

    group('route matrix', () {
      const tCompanyRoute = '/company/AAPL';

      String? redirectFor({
        required AuthState authState,
        required UserState userState,
        required String path,
      }) {
        when(() => mockState.uri).thenReturn(Uri.parse(path));
        return AppRouterRedirect(
          authState: authState,
          userState: userState,
          state: mockState,
        ).computeRedirect();
      }

      test('computeRedirect_guestLoadedOnLanding_returnsHome', () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        final userState = UserState.loaded(tOnboardingUser);

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.landing,
        );

        // assert
        expect(result, AppRoutes.home);
      });

      test('computeRedirect_guestLoadedOnLogin_returnsHome', () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        final userState = UserState.loaded(tOnboardingUser);

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.login,
        );

        // assert
        expect(result, AppRoutes.home);
      });

      test('computeRedirect_guestLoadedOnCompanyRoute_returnsNull', () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        final userState = UserState.loaded(tOnboardingUser);

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: tCompanyRoute,
        );

        // assert
        expect(result, isNull);
      });

      test('computeRedirect_guestLoadedOnOnboardingFinishing_returnsNull', () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        final userState = UserState.loaded(tOnboardingUser);

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.onboardingFinishing,
        );

        // assert
        expect(result, isNull);
      });

      test(
        'computeRedirect_guestNeedsProfileOnHome_returnsOnboardingSectors',
        () {
          // arrange
          final authState = AuthState.authenticated(tGuestUser);
          const userState = UserState.needsProfile();

          // act
          final result = redirectFor(
            authState: authState,
            userState: userState,
            path: AppRoutes.home,
          );

          // assert
          expect(result, AppRoutes.onboardingSectors);
        },
      );

      test(
        'computeRedirect_guestNeedsProfileOnCompanyRoute_returnsOnboardingSectors',
        () {
          // arrange
          final authState = AuthState.authenticated(tGuestUser);
          const userState = UserState.needsProfile();

          // act
          final result = redirectFor(
            authState: authState,
            userState: userState,
            path: tCompanyRoute,
          );

          // assert
          expect(result, AppRoutes.onboardingSectors);
        },
      );

      test('computeRedirect_guestNeedsProfileOnGuestLogin_returnsNull', () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        const userState = UserState.needsProfile();

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.guestLogin,
        );

        // assert
        expect(result, isNull);
      });

      test('computeRedirect_guestUserLoadingOnHome_returnsNull', () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        const userState = UserState.loading();

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.home,
        );

        // assert
        expect(result, isNull);
      });

      test('computeRedirect_registeredLoadedOnLanding_returnsHome', () {
        // arrange
        final authState = AuthState.authenticated(tAuthUser);
        final userState = UserState.loaded(tOnboardingUser);

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.landing,
        );

        // assert
        expect(result, AppRoutes.home);
      });

      test('computeRedirect_registeredLoadedOnLogin_returnsHome', () {
        // arrange
        final authState = AuthState.authenticated(tAuthUser);
        final userState = UserState.loaded(tOnboardingUser);

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.login,
        );

        // assert
        expect(result, AppRoutes.home);
      });

      test('computeRedirect_registeredLoadedOnHome_returnsNull', () {
        // arrange
        final authState = AuthState.authenticated(tAuthUser);
        final userState = UserState.loaded(tOnboardingUser);

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.home,
        );

        // assert
        expect(result, isNull);
      });

      test('computeRedirect_registeredLoadedOnCompanyRoute_returnsNull', () {
        // arrange
        final authState = AuthState.authenticated(tAuthUser);
        final userState = UserState.loaded(tOnboardingUser);

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: tCompanyRoute,
        );

        // assert
        expect(result, isNull);
      });

      test(
        'computeRedirect_registeredLoadedOnGuestCreateAccount_returnsNull',
        () {
          // arrange
          final authState = AuthState.authenticated(tAuthUser);
          final userState = UserState.loaded(tOnboardingUser);

          // act
          final result = redirectFor(
            authState: authState,
            userState: userState,
            path: AppRoutes.guestCreateAccount,
          );

          // assert
          expect(result, isNull);
        },
      );

      test(
        'computeRedirect_registeredLoadedOnOnboardingFinishing_returnsNull',
        () {
          // arrange
          final authState = AuthState.authenticated(tAuthUser);
          final userState = UserState.loaded(tOnboardingUser);

          // act
          final result = redirectFor(
            authState: authState,
            userState: userState,
            path: AppRoutes.onboardingFinishing,
          );

          // assert
          expect(result, isNull);
        },
      );

      test(
        'computeRedirect_registeredNeedsProfileOnCompanyRoute_returnsOnboardingSectors',
        () {
          // arrange
          final authState = AuthState.authenticated(tAuthUser);
          const userState = UserState.needsProfile();

          // act
          final result = redirectFor(
            authState: authState,
            userState: userState,
            path: tCompanyRoute,
          );

          // assert
          expect(result, AppRoutes.onboardingSectors);
        },
      );

      test('computeRedirect_unauthenticatedOnLanding_returnsNull', () {
        // arrange
        const authState = AuthState.unauthenticated();
        const userState = UserState.initial();

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.landing,
        );

        // assert
        expect(result, isNull);
      });

      test('computeRedirect_unauthenticatedOnGuestLogin_returnsNull', () {
        // arrange
        const authState = AuthState.unauthenticated();
        const userState = UserState.initial();

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.guestLogin,
        );

        // assert
        expect(result, isNull);
      });

      test('computeRedirect_unauthenticatedOnCompanyRoute_returnsLanding', () {
        // arrange
        const authState = AuthState.unauthenticated();
        const userState = UserState.initial();

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: tCompanyRoute,
        );

        // assert
        expect(result, AppRoutes.landing);
      });

      test('computeRedirect_unauthenticatedOnSplash_returnsLanding', () {
        // arrange
        const authState = AuthState.unauthenticated();
        const userState = UserState.initial();

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.splash,
        );

        // assert
        expect(result, AppRoutes.landing);
      });
    });

    group('onboarding v2', () {
      const tOnboardingCompanyRoute = '/onboarding/company/AAPL';

      String? redirectFor({
        required AuthState authState,
        required UserState userState,
        required String path,
      }) {
        when(() => mockState.uri).thenReturn(Uri.parse(path));
        return AppRouterRedirect(
          authState: authState,
          userState: userState,
          state: mockState,
        ).computeRedirect();
      }

      test(
        'computeRedirect_guestNeedsProfileOnSplash_returnsOnboardingSectors',
        () {
          // arrange
          final authState = AuthState.authenticated(tGuestUser);
          const userState = UserState.needsProfile();

          // act
          final result = redirectFor(
            authState: authState,
            userState: userState,
            path: AppRoutes.splash,
          );

          // assert
          expect(result, AppRoutes.onboardingSectors);
        },
      );

      test('computeRedirect_guestNeedsProfileOnLanding_returnsNull', () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        const userState = UserState.needsProfile();

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.landing,
        );

        // assert
        expect(result, isNull);
      });

      test('computeRedirect_guestNeedsProfileOnLogin_returnsNull', () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);
        const userState = UserState.needsProfile();

        // act
        final result = redirectFor(
          authState: authState,
          userState: userState,
          path: AppRoutes.login,
        );

        // assert
        expect(result, isNull);
      });

      test(
        'computeRedirect_registeredNeedsProfileOnLanding_returnsOnboardingSectors',
        () {
          // arrange
          final authState = AuthState.authenticated(tAuthUser);
          const userState = UserState.needsProfile();

          // act
          final result = redirectFor(
            authState: authState,
            userState: userState,
            path: AppRoutes.landing,
          );

          // assert
          expect(result, AppRoutes.onboardingSectors);
        },
      );

      test(
        'computeRedirect_guestNeedsProfileOnOnboardingCompany_returnsNull',
        () {
          // arrange
          final authState = AuthState.authenticated(tGuestUser);
          const userState = UserState.needsProfile();

          // act
          final result = redirectFor(
            authState: authState,
            userState: userState,
            path: tOnboardingCompanyRoute,
          );

          // assert
          expect(result, isNull);
        },
      );

      test(
        'computeRedirect_unauthenticatedOnOnboardingCompany_returnsNull',
        () {
          // arrange
          const authState = AuthState.unauthenticated();
          const userState = UserState.initial();

          // act
          final result = redirectFor(
            authState: authState,
            userState: userState,
            path: tOnboardingCompanyRoute,
          );

          // assert
          expect(result, isNull);
        },
      );

      test(
        'computeRedirect_guestNeedsProfileOnOnboardingFinishing_returnsNull',
        () {
          // arrange
          final authState = AuthState.authenticated(tGuestUser);
          const userState = UserState.needsProfile();

          // act
          final result = redirectFor(
            authState: authState,
            userState: userState,
            path: AppRoutes.onboardingFinishing,
          );

          // assert
          expect(result, isNull);
        },
      );
    });

    group('failure then restored guest', () {
      String? redirectFor({
        required AuthState authState,
        required String path,
      }) {
        when(() => mockState.uri).thenReturn(Uri.parse(path));
        return AppRouterRedirect(
          authState: authState,
          userState: UserState.loaded(tOnboardingUser),
          state: mockState,
        ).computeRedirect();
      }

      test('computeRedirect_authFailureOnGuestLogin_returnsNull', () {
        // arrange
        const authState = AuthState.failure(Failure.server('link failed'));

        // act
        final result = redirectFor(
          authState: authState,
          path: AppRoutes.guestLogin,
        );

        // assert
        expect(result, isNull);
      });

      test('computeRedirect_authFailureOnHome_returnsLanding', () {
        // arrange
        const authState = AuthState.failure(Failure.server('link failed'));

        // act
        final result = redirectFor(authState: authState, path: AppRoutes.home);

        // assert
        expect(result, AppRoutes.landing);
      });

      test('computeRedirect_restoredGuestOnCompanyRoute_returnsNull', () {
        // arrange
        final authState = AuthState.authenticated(tGuestUser);

        // act
        final result = redirectFor(authState: authState, path: '/company/AAPL');

        // assert
        expect(result, isNull);
      });
    });
  });

  group('AppRouterRedirect.isOnboardingFlowPath', () {
    test('isOnboardingFlowPath_onboardingRoutes_returnsTrue', () {
      // arrange
      const paths = [
        AppRoutes.landing,
        AppRoutes.createAccount,
        AppRoutes.onboardingSectors,
        AppRoutes.onboardingBrands,
        '/onboarding/company/AAPL',
        AppRoutes.onboardingFinishing,
      ];

      // act
      final results = paths.map(AppRouterRedirect.isOnboardingFlowPath);

      // assert
      expect(results, everyElement(isTrue));
    });

    test('isOnboardingFlowPath_appRoutes_returnsFalse', () {
      // arrange
      const paths = [
        AppRoutes.home,
        AppRoutes.login,
        AppRoutes.splash,
        AppRoutes.guestCreateAccount,
      ];

      // act
      final results = paths.map(AppRouterRedirect.isOnboardingFlowPath);

      // assert
      expect(results, everyElement(isFalse));
    });
  });
}
