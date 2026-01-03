import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/delete_account.dart';
import 'package:bizzie/features/auth/domain/usecases/reset_password.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_apple.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_out.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockSignInWithGoogle extends Mock implements SignInWithGoogle {}

class MockSignInWithApple extends Mock implements SignInWithApple {}

class MockSignInWithEmail extends Mock implements SignInWithEmail {}

class MockSignUpWithEmail extends Mock implements SignUpWithEmail {}

class MockSignOut extends Mock implements SignOut {}

class MockResetPassword extends Mock implements ResetPassword {}

class MockDeleteAccount extends Mock implements DeleteAccount {}

void main() {
  late AuthBloc authBloc;
  late MockAuthRepository mockAuthRepository;
  late MockSignInWithGoogle mockSignInWithGoogle;
  late MockSignInWithApple mockSignInWithApple;
  late MockSignInWithEmail mockSignInWithEmail;
  late MockSignUpWithEmail mockSignUpWithEmail;
  late MockSignOut mockSignOut;
  late MockResetPassword mockResetPassword;
  late MockDeleteAccount mockDeleteAccount;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockSignInWithGoogle = MockSignInWithGoogle();
    mockSignInWithApple = MockSignInWithApple();
    mockSignInWithEmail = MockSignInWithEmail();
    mockSignUpWithEmail = MockSignUpWithEmail();
    mockSignOut = MockSignOut();
    mockResetPassword = MockResetPassword();
    mockDeleteAccount = MockDeleteAccount();

    when(
      () => mockAuthRepository.authStateChanges,
    ).thenAnswer((_) => Stream.value(null));
    when(() => mockAuthRepository.currentUser).thenReturn(null);

    authBloc = AuthBloc(
      authRepository: mockAuthRepository,
      signInWithGoogle: mockSignInWithGoogle,
      signInWithApple: mockSignInWithApple,
      signInWithEmail: mockSignInWithEmail,
      signUpWithEmail: mockSignUpWithEmail,
      signOut: mockSignOut,
      resetPassword: mockResetPassword,
      deleteAccount: mockDeleteAccount,
    );
  });

  registerFallbackValue(NoParams());
  registerFallbackValue(SignInWithEmailParams(email: 'test', password: 'test'));

  const tUser = UserModel(id: '1', email: 'test@example.com');

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
        ).thenThrow(Exception('Sign in failed'));
        return authBloc;
      },
      // act
      act: (bloc) =>
          bloc.add(const AuthEmailSignInRequested(tEmail, tPassword)),
      // assert
      expect: () => [
        const AuthState.loading(),
        const AuthState.failure('Exception: Sign in failed'),
      ],
    );
  });

  group('AuthSignOutRequested', () {
    blocTest<AuthBloc, AuthState>(
      'authLogoutRequested_success_emitsLoadingAndCallsUseCase',
      // arrange
      build: () {
        when(() => mockSignOut(any())).thenAnswer((_) async {});
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthLogoutRequested()),
      // assert
      expect: () => [const AuthState.loading()],
      verify: (_) {
        verify(() => mockSignOut(any())).called(1);
      },
    );
  });

  group('AuthGoogleSignInRequested', () {
    blocTest<AuthBloc, AuthState>(
      'authGoogleSignInRequested_success_callsUseCaseAndEmitsLoading',
      // arrange
      build: () {
        when(() => mockSignInWithGoogle(any())).thenAnswer((_) async => tUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthGoogleSignInRequested()),
      // assert
      expect: () => [const AuthState.loading()],
      verify: (_) {
        verify(() => mockSignInWithGoogle(any())).called(1);
      },
    );
  });

  group('AuthAppleSignInRequested', () {
    blocTest<AuthBloc, AuthState>(
      'authAppleSignInRequested_success_callsUseCaseAndEmitsLoading',
      // arrange
      build: () {
        when(() => mockSignInWithApple(any())).thenAnswer((_) async => tUser);
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthAppleSignInRequested()),
      // assert
      expect: () => [const AuthState.loading()],
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
      act: (bloc) => bloc.add(const AuthResetPasswordRequested(tEmail)),
      // assert
      expect: () => [],
      verify: (_) {
        verify(() => mockResetPassword(tEmail)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'authResetPasswordRequested_failure_emitsFailure',
      // arrange
      build: () {
        when(
          () => mockResetPassword(any()),
        ).thenThrow(Exception('Reset failed'));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthResetPasswordRequested(tEmail)),
      // assert
      expect: () => [const AuthState.failure('Exception: Reset failed')],
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
      },
    );

    blocTest<AuthBloc, AuthState>(
      'authDeleteAccountRequested_failure_emitsLoadingAndFailure',
      // arrange
      build: () {
        when(
          () => mockDeleteAccount(any()),
        ).thenThrow(Exception('Delete failed'));
        return authBloc;
      },
      // act
      act: (bloc) => bloc.add(const AuthDeleteAccountRequested()),
      // assert
      expect: () => [
        const AuthState.loading(),
        const AuthState.failure('Exception: Delete failed'),
      ],
    );
  });
}
