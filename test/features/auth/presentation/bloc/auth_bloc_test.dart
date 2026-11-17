import 'package:bizzie/core/enums/guest_gate_trigger.dart';
import 'package:bizzie/core/usecase/usecase.dart';

import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/models/link_with_email_params.dart';
import 'package:bizzie/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_apple_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/link_with_apple_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/link_with_email_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/link_with_google_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_up_with_email_usecase.dart';
import 'package:bizzie/features/auth/presentation/analytics/auth_tracker.dart';
import 'package:bizzie/features/settings/domain/usecases/launch_url_usecase.dart';
import 'package:bizzie/features/auth/domain/enums/auth_method.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/auth/presentation/enums/auth_loading_method.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthTracker extends Mock implements AuthTracker {}

class MockGetAuthStreamUseCase extends Mock implements GetAuthStreamUseCase {}

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

class MockSignInWithGoogleUseCase extends Mock
    implements SignInWithGoogleUseCase {}

class MockSignInWithAppleUseCase extends Mock
    implements SignInWithAppleUseCase {}

class MockSignInWithEmailUseCase extends Mock
    implements SignInWithEmailUseCase {}

class MockSignUpWithEmailUseCase extends Mock
    implements SignUpWithEmailUseCase {}

class MockLinkWithEmailUseCase extends Mock implements LinkWithEmailUseCase {}

class MockLinkWithGoogleUseCase extends Mock implements LinkWithGoogleUseCase {}

class MockLinkWithAppleUseCase extends Mock implements LinkWithAppleUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

class MockDeleteAccountUseCase extends Mock implements DeleteAccountUseCase {}

class MockLaunchUrlUseCase extends Mock implements LaunchUrlUseCase {}

void main() {
  late AuthBloc authBloc;
  late MockGetAuthStreamUseCase mockGetAuthStream;
  late MockGetCurrentUserUseCase mockGetCurrentUser;
  late MockSignInWithGoogleUseCase mockSignInWithGoogle;
  late MockSignInWithAppleUseCase mockSignInWithApple;
  late MockSignInWithEmailUseCase mockSignInWithEmail;
  late MockSignUpWithEmailUseCase mockSignUpWithEmail;
  late MockLinkWithEmailUseCase mockLinkWithEmail;
  late MockLinkWithGoogleUseCase mockLinkWithGoogle;
  late MockLinkWithAppleUseCase mockLinkWithApple;
  late MockSignOutUseCase mockSignOut;
  late MockResetPasswordUseCase mockResetPassword;
  late MockDeleteAccountUseCase mockDeleteAccount;
  late MockLaunchUrlUseCase mockLaunchUrlUseCase;
  late MockAuthTracker mockAuthTracker;

  setUpAll(() {
    registerFallbackValue(AuthMethod.email);
    registerFallbackValue(AuthSource.landing);
    registerFallbackValue(GuestGateTrigger.subscribe);
  });

  setUp(() {
    mockGetAuthStream = MockGetAuthStreamUseCase();
    mockGetCurrentUser = MockGetCurrentUserUseCase();
    mockSignInWithGoogle = MockSignInWithGoogleUseCase();
    mockSignInWithApple = MockSignInWithAppleUseCase();
    mockSignInWithEmail = MockSignInWithEmailUseCase();
    mockSignUpWithEmail = MockSignUpWithEmailUseCase();
    mockLinkWithEmail = MockLinkWithEmailUseCase();
    mockLinkWithGoogle = MockLinkWithGoogleUseCase();
    mockLinkWithApple = MockLinkWithAppleUseCase();
    mockSignOut = MockSignOutUseCase();
    mockResetPassword = MockResetPasswordUseCase();
    mockDeleteAccount = MockDeleteAccountUseCase();
    mockLaunchUrlUseCase = MockLaunchUrlUseCase();
    mockAuthTracker = MockAuthTracker();

    when(
      () => mockAuthTracker.logLoginStarted(
        method: any(named: 'method'),
        source: any(named: 'source'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockAuthTracker.logLoginSuccess(
        method: any(named: 'method'),
        source: any(named: 'source'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockAuthTracker.logLoginFailure(
        method: any(named: 'method'),
        source: any(named: 'source'),
        error: any(named: 'error'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockAuthTracker.logSignUpStarted(
        method: any(named: 'method'),
        source: any(named: 'source'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockAuthTracker.logSignUpSuccess(
        method: any(named: 'method'),
        source: any(named: 'source'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockAuthTracker.logSignUpFailure(
        method: any(named: 'method'),
        source: any(named: 'source'),
        error: any(named: 'error'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockAuthTracker.logPasswordResetRequested(
        source: any(named: 'source'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockAuthTracker.logLogout()).thenAnswer((_) async {});
    when(() => mockAuthTracker.logAccountDeleted()).thenAnswer((_) async {});
    when(() => mockAuthTracker.setUserId(any())).thenAnswer((_) async {});
    when(
      () => mockAuthTracker.setAccountType(isGuest: any(named: 'isGuest')),
    ).thenAnswer((_) async {});
    when(
      () => mockAuthTracker.logGuestGateShown(trigger: any(named: 'trigger')),
    ).thenAnswer((_) async {});
    when(
      () => mockAuthTracker.logGuestAccountLinked(
        method: any(named: 'method'),
        trigger: any(named: 'trigger'),
        fallbackSignIn: any(named: 'fallbackSignIn'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockAuthTracker.logAuthLinkClicked(type: any(named: 'type')),
    ).thenAnswer((_) async {});
    when(
      () => mockLaunchUrlUseCase(any()),
    ).thenAnswer((_) async => const Right(null));

    when(() => mockGetAuthStream(any())).thenAnswer((_) => Stream.value(null));
    when(() => mockGetCurrentUser(any())).thenReturn(null);

    authBloc = AuthBloc(
      mockAuthTracker,
      mockGetAuthStream,
      mockGetCurrentUser,
      mockSignInWithGoogle,
      mockSignInWithApple,
      mockSignInWithEmail,
      mockSignUpWithEmail,
      mockLinkWithEmail,
      mockLinkWithGoogle,
      mockLinkWithApple,
      mockSignOut,
      mockResetPassword,
      mockDeleteAccount,
      mockLaunchUrlUseCase,
    );
  });

  registerFallbackValue(NoParams());
  registerFallbackValue(NoParams());
  registerFallbackValue(SignInWithEmailParams(email: 'test', password: 'test'));
  registerFallbackValue(ResetPasswordParams(email: 'test'));
  registerFallbackValue(SignUpWithEmailParams(email: 'test', password: 'test'));
  registerFallbackValue(LinkWithEmailParams(email: 'test', password: 'test'));

  const tUser = UserModel(id: '1', email: 'test@example.com');
  const tGuestUser = UserModel(id: 'guest', email: '', isAnonymous: true);
  const tFailure = Failure.server('Test Failure');

  test('initial state is AuthState.unauthenticated', () {
    expect(authBloc.state, const AuthState.unauthenticated());
  });

  group('AuthEmailSignInRequested', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    blocTest<AuthBloc, AuthState>(
      'authEmailSignInRequested_failure_emitsLoadingAndFailure',
      // arrange
      build: () {
        when(
          () => mockSignInWithEmail(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthEmailSignInRequested(
          tEmail,
          tPassword,
          source: AuthSource.landing,
        ),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignIn),
        const AuthState.failure(tFailure),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'authEmailSignInRequested_guestGateFailure_restoresGuestSession',
      // arrange
      build: () {
        when(
          () => mockSignInWithEmail(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        when(() => mockGetCurrentUser(any())).thenReturn(tGuestUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthEmailSignInRequested(
          tEmail,
          tPassword,
          source: AuthSource.guestGate,
        ),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignIn),
        const AuthState.failure(tFailure),
        const AuthState.authenticated(tGuestUser),
      ],
      verify: (bloc) {
        expect(bloc.state.isGuest, isTrue);
        verifyNever(
          () => mockAuthTracker.logGuestAccountLinked(
            method: any(named: 'method'),
            trigger: any(named: 'trigger'),
            fallbackSignIn: any(named: 'fallbackSignIn'),
          ),
        );
      },
    );

    blocTest<AuthBloc, AuthState>(
      'authEmailSignInRequested_guestGateSuccess_logsLinkedWithFallbackAndTrigger',
      // arrange
      build: () {
        when(
          () => mockSignInWithEmail(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) async {
        bloc.add(const AuthGuestGateShown(trigger: GuestGateTrigger.subscribe));
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const AuthEmailSignInRequested(
            tEmail,
            tPassword,
            source: AuthSource.guestGate,
          ),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const AuthEmailSignInRequested(
            tEmail,
            tPassword,
            source: AuthSource.guestGate,
          ),
        );
      },
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignIn),
      ],
      verify: (_) {
        verifyInOrder([
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.email,
            trigger: GuestGateTrigger.subscribe,
            fallbackSignIn: true,
          ),
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.email,
            trigger: null,
            fallbackSignIn: true,
          ),
        ]);
        verify(() => mockAuthTracker.setAccountType(isGuest: false)).called(2);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'authEmailSignInRequested_nonGuestSuccess_doesNotLogGuestAccountLinked',
      // arrange
      build: () {
        when(
          () => mockSignInWithEmail(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthEmailSignInRequested(
          tEmail,
          tPassword,
          source: AuthSource.landing,
        ),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignIn),
      ],
      verify: (_) {
        verifyNever(
          () => mockAuthTracker.logGuestAccountLinked(
            method: any(named: 'method'),
            trigger: any(named: 'trigger'),
            fallbackSignIn: any(named: 'fallbackSignIn'),
          ),
        );
      },
    );
  });

  group('AuthSignOutRequested', () {
    blocTest<AuthBloc, AuthState>(
      'authLogoutRequested_success_callsUseCase',
      // arrange
      build: () {
        when(
          () => mockSignOut(any()),
        ).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthLogoutRequested()),
      // assert
      expect: () => [],
      verify: (_) {
        verify(() => mockSignOut(any())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'authLogoutRequested_failureWithSignedInUser_emitsFailureThenRestoresSession',
      // arrange
      build: () {
        when(
          () => mockSignOut(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        when(() => mockGetCurrentUser(any())).thenReturn(tUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthLogoutRequested()),
      // assert
      expect: () => [
        const AuthState.failure(tFailure),
        const AuthState.authenticated(tUser),
      ],
    );
  });

  group('AuthGoogleSignInRequested', () {
    blocTest<AuthBloc, AuthState>(
      'authGoogleSignInRequested_success_callsUseCaseAndEmitsLoading',
      // arrange
      build: () {
        when(
          () => mockSignInWithGoogle(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) =>
          bloc.add(const AuthGoogleSignInRequested(source: AuthSource.landing)),
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.google)],
      verify: (_) {
        verify(() => mockSignInWithGoogle(any())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'authGoogleSignInRequested_failureWithSignedInGuest_emitsFailureThenRestoresGuest',
      // arrange
      build: () {
        when(
          () => mockSignInWithGoogle(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        when(() => mockGetCurrentUser(any())).thenReturn(tGuestUser);
        return authBloc;
      },
      // act
      act: (bloc) =>
          bloc.add(const AuthGoogleSignInRequested(source: AuthSource.landing)),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.google),
        const AuthState.failure(tFailure),
        const AuthState.authenticated(tGuestUser),
      ],
    );
  });

  group('AuthAppleSignInRequested', () {
    blocTest<AuthBloc, AuthState>(
      'authAppleSignInRequested_success_callsUseCaseAndEmitsLoading',
      // arrange
      build: () {
        when(
          () => mockSignInWithApple(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) =>
          bloc.add(const AuthAppleSignInRequested(source: AuthSource.landing)),
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.apple)],
      verify: (_) {
        verify(() => mockSignInWithApple(any())).called(1);
      },
    );
  });

  group('AuthResetPasswordRequested', () {
    const tEmail = 'test@example.com';

    blocTest<AuthBloc, AuthState>(
      'authResetPasswordRequested_success_callsUseCaseAndNoStateEmission',
      // arrange
      build: () {
        when(
          () => mockResetPassword(any()),
        ).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthResetPasswordRequested(tEmail, source: AuthSource.landing),
      ),
      // assert
      expect: () => [],
      verify: (_) {
        verify(() => mockResetPassword(any())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'authResetPasswordRequested_failure_emitsFailure',
      // arrange
      build: () {
        when(
          () => mockResetPassword(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthResetPasswordRequested(tEmail, source: AuthSource.landing),
      ),
      // assert
      expect: () => [const AuthState.failure(tFailure)],
    );
  });

  group('AuthDeleteAccountRequested', () {
    blocTest<AuthBloc, AuthState>(
      'authDeleteAccountRequested_success_callsUseCaseAndEmitsLoading',
      // arrange
      build: () {
        when(
          () => mockDeleteAccount(any()),
        ).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthDeleteAccountRequested()),
      // assert
      expect: () => [const AuthState.loading()],
      verify: (_) {
        verify(() => mockDeleteAccount(any())).called(1);
        verify(() => mockAuthTracker.logAccountDeleted()).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'authDeleteAccountRequested_failure_emitsLoadingAndFailure',
      // arrange
      build: () {
        when(
          () => mockDeleteAccount(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthDeleteAccountRequested()),
      // assert
      expect: () => [
        const AuthState.loading(),
        const AuthState.failure(tFailure),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'authDeleteAccountRequested_failureWithSignedInUser_emitsFailureThenRestoresSession',
      // arrange
      build: () {
        when(
          () => mockDeleteAccount(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        when(() => mockGetCurrentUser(any())).thenReturn(tUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthDeleteAccountRequested()),
      // assert
      expect: () => [
        const AuthState.loading(),
        const AuthState.failure(tFailure),
        const AuthState.authenticated(tUser),
      ],
      verify: (_) {
        verifyNever(() => mockAuthTracker.logAccountDeleted());
      },
    );
  });

  group('AuthLegalLinkOpened', () {
    const tUrl = 'https://example.com';

    blocTest<AuthBloc, AuthState>(
      'authLegalLinkOpened_callsTrackerAndLaunchUseCase',
      build: () => authBloc,
      act: (bloc) => bloc.add(const AuthLegalLinkOpened(tUrl)),
      verify: (_) {
        verify(() => mockAuthTracker.logAuthLinkClicked(type: tUrl)).called(1);
        verify(() => mockLaunchUrlUseCase(tUrl)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'authLegalLinkOpened_launchFailure_doesNotEmit',
      // arrange
      build: () {
        when(
          () => mockLaunchUrlUseCase(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthLegalLinkOpened(tUrl)),
      // assert
      expect: () => <AuthState>[],
      errors: () => <Object>[],
    );
  });

  group('AuthState.isGuest', () {
    test('isGuest_authenticatedAnonymousUser_returnsTrue', () {
      // arrange
      const sut = AuthState.authenticated(
        UserModel(id: 'anon', email: '', isAnonymous: true),
      );
      // act
      final result = sut.isGuest;
      // assert
      expect(result, isTrue);
    });

    test('isGuest_authenticatedRegisteredUser_returnsFalse', () {
      // arrange
      const sut = AuthState.authenticated(tUser);
      // act
      final result = sut.isGuest;
      // assert
      expect(result, isFalse);
    });

    test('isGuest_unauthenticated_returnsFalse', () {
      // arrange
      const sut = AuthState.unauthenticated();
      // act
      final result = sut.isGuest;
      // assert
      expect(result, isFalse);
    });
  });

  group('AuthStatusRequested', () {
    const tAnonymousUser = UserModel(id: '1', email: '', isAnonymous: true);
    const tLinkedUser = UserModel(
      id: '1',
      email: 'test@example.com',
      providers: ['password'],
    );

    blocTest<AuthBloc, AuthState>(
      'statusRequested_anonymousUserLinked_emitsAuthenticatedRegisteredUser',
      // arrange
      build: () {
        when(
          () => mockGetAuthStream(any()),
        ).thenAnswer((_) => Stream.value(tLinkedUser));
        return authBloc;
      },
      seed: () => const AuthState.authenticated(tAnonymousUser),
      // act
      act: (bloc) => bloc.add(const AuthStatusRequested()),
      // assert
      expect: () => [const AuthState.authenticated(tLinkedUser)],
      verify: (_) {
        verify(() => mockAuthTracker.setUserId('1')).called(1);
        verify(() => mockAuthTracker.setAccountType(isGuest: false)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'statusRequested_anonymousUser_setsGuestAccountType',
      // arrange
      build: () {
        when(
          () => mockGetAuthStream(any()),
        ).thenAnswer((_) => Stream.value(tAnonymousUser));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthStatusRequested()),
      // assert
      expect: () => [const AuthState.authenticated(tAnonymousUser)],
      verify: (_) {
        verify(() => mockAuthTracker.setAccountType(isGuest: true)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'statusRequested_nullUser_doesNotSetAccountType',
      // arrange
      build: () => authBloc,
      seed: () => const AuthState.authenticated(tAnonymousUser),
      // act
      act: (bloc) => bloc.add(const AuthStatusRequested()),
      // assert
      expect: () => [const AuthState.unauthenticated()],
      verify: (_) {
        verifyNever(
          () => mockAuthTracker.setAccountType(isGuest: any(named: 'isGuest')),
        );
      },
    );

    blocTest<AuthBloc, AuthState>(
      'statusRequested_streamError_keepsCurrentState',
      // arrange
      build: () {
        when(
          () => mockGetAuthStream(any()),
        ).thenAnswer((_) => Stream.error(Exception('stream failure')));
        return authBloc;
      },
      seed: () => const AuthState.authenticated(tAnonymousUser),
      // act
      act: (bloc) => bloc.add(const AuthStatusRequested()),
      // assert
      expect: () => <AuthState>[],
      errors: () => <Object>[],
    );
  });

  group('Guest gate analytics', () {
    blocTest<AuthBloc, AuthState>(
      'guestGateShown_logsShownWithTrigger',
      // arrange
      build: () => authBloc,
      // act
      act: (bloc) => bloc.add(
        const AuthGuestGateShown(trigger: GuestGateTrigger.subscribe),
      ),
      // assert
      expect: () => <AuthState>[],
      verify: (_) {
        verify(
          () => mockAuthTracker.logGuestGateShown(
            trigger: GuestGateTrigger.subscribe,
          ),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'guestGateDismissed_logsNoGuestGateEvent',
      // arrange
      build: () => authBloc,
      // act
      act: (bloc) => bloc.add(const AuthGuestGateDismissed()),
      // assert
      expect: () => <AuthState>[],
      verify: (_) {
        verifyNever(
          () =>
              mockAuthTracker.logGuestGateShown(trigger: any(named: 'trigger')),
        );
        verifyNever(
          () => mockAuthTracker.logGuestAccountLinked(
            method: any(named: 'method'),
            trigger: any(named: 'trigger'),
            fallbackSignIn: any(named: 'fallbackSignIn'),
          ),
        );
      },
    );

    blocTest<AuthBloc, AuthState>(
      'guestGateShown_thenLinkSucceeds_logsLinkedWithGateTrigger',
      // arrange
      build: () {
        when(
          () => mockLinkWithEmail(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) async {
        bloc.add(const AuthGuestGateShown(trigger: GuestGateTrigger.subscribe));
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const AuthEmailSignUpRequested(
            'a@b.com',
            'password',
            source: AuthSource.guestGate,
          ),
        );
      },
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignUp),
      ],
      verify: (_) {
        verify(
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.email,
            trigger: GuestGateTrigger.subscribe,
            fallbackSignIn: false,
          ),
        ).called(1);
        verify(() => mockAuthTracker.setAccountType(isGuest: false)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'guestGateDismissed_thenLinkSucceeds_logsLinkedWithoutTrigger',
      // arrange
      build: () {
        when(
          () => mockLinkWithApple(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) async {
        bloc.add(const AuthGuestGateShown(trigger: GuestGateTrigger.subscribe));
        bloc.add(const AuthGuestGateDismissed());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const AuthAppleSignInRequested(source: AuthSource.guestGate));
      },
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.apple)],
      verify: (_) {
        verify(
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.apple,
            trigger: null,
            fallbackSignIn: false,
          ),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'guestLinkStartedFromSettings_thenFallbackSignInSucceeds_logsLinkedWithFallback',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Left(Failure.credentialAlreadyInUse()));
        when(
          () => mockSignInWithGoogle(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) async {
        bloc.add(
          const AuthGuestLinkStarted(trigger: GuestGateTrigger.settings),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(const AuthGoogleSignInRequested(source: AuthSource.guestGate));
      },
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.google)],
      verify: (_) {
        verify(
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.google,
            trigger: GuestGateTrigger.settings,
            fallbackSignIn: true,
          ),
        ).called(1);
        verify(() => mockAuthTracker.setAccountType(isGuest: false)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'guestLinkStartedFromSettings_thenDismissed_thenGateLinkSucceeds_logsLinkedWithGateTrigger',
      // arrange
      build: () {
        when(
          () => mockLinkWithEmail(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) async {
        bloc.add(
          const AuthGuestLinkStarted(trigger: GuestGateTrigger.settings),
        );
        bloc.add(const AuthGuestGateDismissed());
        bloc.add(const AuthGuestGateShown(trigger: GuestGateTrigger.subscribe));
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const AuthEmailSignUpRequested(
            'a@b.com',
            'password',
            source: AuthSource.guestGate,
          ),
        );
      },
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignUp),
      ],
      verify: (_) {
        verify(
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.email,
            trigger: GuestGateTrigger.subscribe,
            fallbackSignIn: false,
          ),
        ).called(1);
        verifyNever(
          () => mockAuthTracker.logGuestAccountLinked(
            method: any(named: 'method'),
            trigger: GuestGateTrigger.settings,
            fallbackSignIn: any(named: 'fallbackSignIn'),
          ),
        );
      },
    );

    blocTest<AuthBloc, AuthState>(
      'guestLinkStartedFromSettings_thenDismissed_thenLinkSucceeds_logsLinkedWithoutTrigger',
      // arrange
      build: () {
        when(
          () => mockLinkWithApple(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) async {
        bloc.add(
          const AuthGuestLinkStarted(trigger: GuestGateTrigger.settings),
        );
        bloc.add(const AuthGuestGateDismissed());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const AuthAppleSignInRequested(source: AuthSource.guestGate));
      },
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.apple)],
      verify: (_) {
        verify(
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.apple,
            trigger: null,
            fallbackSignIn: false,
          ),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'linkFails_doesNotLogGuestAccountLinked',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Left(Failure.credentialAlreadyInUse()));
        when(
          () => mockSignInWithGoogle(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthGoogleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.google),
        const AuthState.failure(tFailure),
      ],
      verify: (_) {
        verifyNever(
          () => mockAuthTracker.logGuestAccountLinked(
            method: any(named: 'method'),
            trigger: any(named: 'trigger'),
            fallbackSignIn: any(named: 'fallbackSignIn'),
          ),
        );
      },
    );
  });

  group('Guest link trigger carry-through', () {
    blocTest<AuthBloc, AuthState>(
      'linkFailsThenRetrySucceeds_logsLinkedWithOriginalGateTrigger',
      // arrange
      build: () {
        var attempts = 0;
        when(() => mockLinkWithEmail(any())).thenAnswer((_) async {
          attempts++;
          return attempts == 1
              ? const Left(Failure.emailAlreadyInUse())
              : const Right(tUser);
        });
        when(() => mockGetCurrentUser(any())).thenReturn(tGuestUser);
        return authBloc;
      },
      // act
      act: (bloc) async {
        bloc.add(const AuthGuestGateShown(trigger: GuestGateTrigger.subscribe));
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const AuthEmailSignUpRequested(
            'a@b.com',
            'password',
            source: AuthSource.guestGate,
          ),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const AuthEmailSignUpRequested(
            'c@d.com',
            'password',
            source: AuthSource.guestGate,
          ),
        );
      },
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignUp),
        const AuthState.failure(Failure.emailAlreadyInUse()),
        const AuthState.authenticated(tGuestUser),
        const AuthState.loading(method: AuthLoadingMethod.emailSignUp),
      ],
      verify: (_) {
        verify(
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.email,
            trigger: GuestGateTrigger.subscribe,
            fallbackSignIn: false,
          ),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'linkSucceeds_clearsTriggerForSubsequentLink',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) async {
        bloc.add(
          const AuthGuestLinkStarted(trigger: GuestGateTrigger.settings),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(const AuthGoogleSignInRequested(source: AuthSource.guestGate));
        await Future<void>.delayed(Duration.zero);
        bloc.add(const AuthGoogleSignInRequested(source: AuthSource.guestGate));
      },
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.google)],
      verify: (_) {
        verifyInOrder([
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.google,
            trigger: GuestGateTrigger.settings,
            fallbackSignIn: false,
          ),
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.google,
            trigger: null,
            fallbackSignIn: false,
          ),
        ]);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'appleCredentialAlreadyInUseFallbackSucceeds_logsLinkedWithFallbackAndTrigger',
      // arrange
      build: () {
        when(
          () => mockLinkWithApple(any()),
        ).thenAnswer((_) async => const Left(Failure.credentialAlreadyInUse()));
        when(
          () => mockSignInWithApple(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) async {
        bloc.add(const AuthGuestGateShown(trigger: GuestGateTrigger.restore));
        await Future<void>.delayed(Duration.zero);
        bloc.add(const AuthAppleSignInRequested(source: AuthSource.guestGate));
      },
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.apple)],
      verify: (_) {
        verify(
          () => mockAuthTracker.logGuestAccountLinked(
            method: AuthMethod.apple,
            trigger: GuestGateTrigger.restore,
            fallbackSignIn: true,
          ),
        ).called(1);
        verify(() => mockAuthTracker.setAccountType(isGuest: false)).called(1);
        verifyNever(
          () => mockAuthTracker.logSignUpFailure(
            method: any(named: 'method'),
            source: any(named: 'source'),
            error: any(named: 'error'),
          ),
        );
      },
    );
  });

  group('AuthEmailSignUpRequested guest link', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    blocTest<AuthBloc, AuthState>(
      'emailSignUpRequested_guestLinkSuccess_emitsLoadingAndLogsSignUpSuccess',
      // arrange
      build: () {
        when(
          () => mockLinkWithEmail(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthEmailSignUpRequested(
          tEmail,
          tPassword,
          source: AuthSource.guestGate,
        ),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignUp),
      ],
      verify: (_) {
        verify(
          () => mockAuthTracker.logSignUpStarted(
            method: AuthMethod.email,
            source: AuthSource.guestGate,
          ),
        ).called(1);
        verify(
          () => mockAuthTracker.logSignUpSuccess(
            method: AuthMethod.email,
            source: AuthSource.guestGate,
          ),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emailSignUpRequested_guestLinkEmailAlreadyInUse_emitsLoadingAndFailure',
      // arrange
      build: () {
        when(
          () => mockLinkWithEmail(any()),
        ).thenAnswer((_) async => const Left(Failure.emailAlreadyInUse()));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthEmailSignUpRequested(
          tEmail,
          tPassword,
          source: AuthSource.guestGate,
        ),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignUp),
        const AuthState.failure(Failure.emailAlreadyInUse()),
      ],
      verify: (_) {
        verify(
          () => mockAuthTracker.logSignUpFailure(
            method: AuthMethod.email,
            source: AuthSource.guestGate,
            error: 'Email already in use',
          ),
        ).called(1);
        verifyNever(() => mockSignInWithEmail(any()));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emailSignUpRequested_guestLinkFailureWithSignedInGuest_emitsFailureThenReauthenticatesGuest',
      // arrange
      build: () {
        when(
          () => mockLinkWithEmail(any()),
        ).thenAnswer((_) async => const Left(Failure.emailAlreadyInUse()));
        when(() => mockGetCurrentUser(any())).thenReturn(tGuestUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthEmailSignUpRequested(
          tEmail,
          tPassword,
          source: AuthSource.guestGate,
        ),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignUp),
        const AuthState.failure(Failure.emailAlreadyInUse()),
        const AuthState.authenticated(tGuestUser),
      ],
    );
  });

  group('AuthEmailSignUpRequested guest link credential conflicts', () {
    blocTest<AuthBloc, AuthState>(
      'emailSignUpRequested_guestLinkCredentialAlreadyInUse_emitsFailureWithoutFallbackSignIn',
      // arrange
      build: () {
        when(
          () => mockLinkWithEmail(any()),
        ).thenAnswer((_) async => const Left(Failure.credentialAlreadyInUse()));
        when(() => mockGetCurrentUser(any())).thenReturn(tGuestUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthEmailSignUpRequested(
          'test@example.com',
          'password123',
          source: AuthSource.guestGate,
        ),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignUp),
        const AuthState.failure(Failure.credentialAlreadyInUse()),
        const AuthState.authenticated(tGuestUser),
      ],
      verify: (_) {
        verifyNever(() => mockSignInWithEmail(any()));
        verifyNever(
          () => mockAuthTracker.logGuestAccountLinked(
            method: any(named: 'method'),
            trigger: any(named: 'trigger'),
            fallbackSignIn: any(named: 'fallbackSignIn'),
          ),
        );
      },
    );
  });

  group('AuthGoogleSignInRequested guest link', () {
    blocTest<AuthBloc, AuthState>(
      'googleSignInRequested_guestLinkSuccess_emitsLoadingAndDoesNotSignIn',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthGoogleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.google)],
      verify: (_) {
        verify(
          () => mockAuthTracker.logSignUpSuccess(
            method: AuthMethod.google,
            source: AuthSource.guestGate,
          ),
        ).called(1);
        verifyNever(() => mockSignInWithGoogle(any()));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'googleSignInRequested_guestLinkCredentialAlreadyInUse_fallsBackToSignIn',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Left(Failure.credentialAlreadyInUse()));
        when(
          () => mockSignInWithGoogle(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthGoogleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.google)],
      verify: (_) {
        verify(() => mockSignInWithGoogle(any())).called(1);
        verify(
          () => mockAuthTracker.logLoginSuccess(
            method: AuthMethod.google,
            source: AuthSource.guestGate,
          ),
        ).called(1);
        verifyNever(
          () => mockAuthTracker.logSignUpFailure(
            method: any(named: 'method'),
            source: any(named: 'source'),
            error: any(named: 'error'),
          ),
        );
      },
    );

    blocTest<AuthBloc, AuthState>(
      'googleSignInRequested_guestLinkFallbackSignInFails_emitsLoadingAndFailure',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Left(Failure.credentialAlreadyInUse()));
        when(
          () => mockSignInWithGoogle(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthGoogleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.google),
        const AuthState.failure(tFailure),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'googleSignInRequested_guestLinkOtherFailure_emitsLoadingAndFailure',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthGoogleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.google),
        const AuthState.failure(tFailure),
      ],
      verify: (_) {
        verifyNever(() => mockSignInWithGoogle(any()));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'googleSignInRequested_guestLinkFallbackSignInFailsWithSignedInGuest_emitsFailureThenReauthenticatesGuest',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Left(Failure.credentialAlreadyInUse()));
        when(
          () => mockSignInWithGoogle(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        when(() => mockGetCurrentUser(any())).thenReturn(tGuestUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthGoogleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.google),
        const AuthState.failure(tFailure),
        const AuthState.authenticated(tGuestUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'googleSignInRequested_guestLinkFallbackSignInSucceeds_doesNotReemitAuthenticated',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Left(Failure.credentialAlreadyInUse()));
        when(
          () => mockSignInWithGoogle(any()),
        ).thenAnswer((_) async => const Right(tUser));
        when(() => mockGetCurrentUser(any())).thenReturn(tUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthGoogleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.google)],
    );

    blocTest<AuthBloc, AuthState>(
      'googleSignInRequested_guestLinkOtherFailureWithSignedInGuest_emitsFailureThenReauthenticatesGuest',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        when(() => mockGetCurrentUser(any())).thenReturn(tGuestUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthGoogleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.google),
        const AuthState.failure(tFailure),
        const AuthState.authenticated(tGuestUser),
      ],
    );
  });

  group('AuthAppleSignInRequested guest link', () {
    blocTest<AuthBloc, AuthState>(
      'appleSignInRequested_guestLinkSuccess_emitsLoadingAndDoesNotSignIn',
      // arrange
      build: () {
        when(
          () => mockLinkWithApple(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthAppleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.apple)],
      verify: (_) {
        verifyNever(() => mockSignInWithApple(any()));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'appleSignInRequested_guestLinkCredentialAlreadyInUse_fallsBackToSignIn',
      // arrange
      build: () {
        when(
          () => mockLinkWithApple(any()),
        ).thenAnswer((_) async => const Left(Failure.credentialAlreadyInUse()));
        when(
          () => mockSignInWithApple(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthAppleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.apple)],
      verify: (_) {
        verify(() => mockSignInWithApple(any())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'appleSignInRequested_guestLinkFallbackSignInFailsWithSignedInGuest_emitsFailureThenReauthenticatesGuest',
      // arrange
      build: () {
        when(
          () => mockLinkWithApple(any()),
        ).thenAnswer((_) async => const Left(Failure.credentialAlreadyInUse()));
        when(
          () => mockSignInWithApple(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        when(() => mockGetCurrentUser(any())).thenReturn(tGuestUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthAppleSignInRequested(source: AuthSource.guestGate),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.apple),
        const AuthState.failure(tFailure),
        const AuthState.authenticated(tGuestUser),
      ],
    );
  });

  group('Guest link routing', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    blocTest<AuthBloc, AuthState>(
      'googleSignInRequested_onboardingWithGuestSession_linksInsteadOfSignIn',
      // arrange
      build: () {
        when(
          () => mockLinkWithGoogle(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      seed: () => const AuthState.authenticated(tGuestUser),
      // act
      act: (bloc) => bloc.add(
        const AuthGoogleSignInRequested(source: AuthSource.onboarding),
      ),
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.google)],
      verify: (_) {
        verify(() => mockLinkWithGoogle(any())).called(1);
        verifyNever(() => mockSignInWithGoogle(any()));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'appleSignInRequested_onboardingWithGuestSession_linksInsteadOfSignIn',
      // arrange
      build: () {
        when(
          () => mockLinkWithApple(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      seed: () => const AuthState.authenticated(tGuestUser),
      // act
      act: (bloc) => bloc.add(
        const AuthAppleSignInRequested(source: AuthSource.onboarding),
      ),
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.apple)],
      verify: (_) {
        verify(() => mockLinkWithApple(any())).called(1);
        verifyNever(() => mockSignInWithApple(any()));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'googleSignInRequested_onboardingWithoutGuestSession_signsInWithoutLinking',
      // arrange
      build: () {
        when(
          () => mockSignInWithGoogle(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthGoogleSignInRequested(source: AuthSource.onboarding),
      ),
      // assert
      expect: () => [const AuthState.loading(method: AuthLoadingMethod.google)],
      verify: (_) {
        verify(() => mockSignInWithGoogle(any())).called(1);
        verifyNever(() => mockLinkWithGoogle(any()));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emailSignUpRequested_onboardingWithGuestSession_linksInsteadOfSignUp',
      // arrange
      build: () {
        when(
          () => mockLinkWithEmail(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      seed: () => const AuthState.authenticated(tGuestUser),
      // act
      act: (bloc) => bloc.add(
        const AuthEmailSignUpRequested(
          tEmail,
          tPassword,
          source: AuthSource.onboarding,
        ),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignUp),
      ],
      verify: (_) {
        verify(() => mockLinkWithEmail(any())).called(1);
        verifyNever(() => mockSignUpWithEmail(any()));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emailSignUpRequested_onboardingWithoutGuestSession_signsUpWithoutLinking',
      // arrange
      build: () {
        when(
          () => mockSignUpWithEmail(any()),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(
        const AuthEmailSignUpRequested(
          tEmail,
          tPassword,
          source: AuthSource.onboarding,
        ),
      ),
      // assert
      expect: () => [
        const AuthState.loading(method: AuthLoadingMethod.emailSignUp),
      ],
      verify: (_) {
        verify(() => mockSignUpWithEmail(any())).called(1);
        verifyNever(() => mockLinkWithEmail(any()));
      },
    );
  });
}
