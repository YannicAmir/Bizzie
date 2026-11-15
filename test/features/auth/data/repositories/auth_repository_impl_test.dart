import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/data/dtos/auth_user_dto.dart';
import 'package:bizzie/features/auth/data/interfaces/i_auth_local_datasource.dart';
import 'package:bizzie/features/auth/data/interfaces/i_auth_remote_datasource.dart';
import 'package:bizzie/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class MockIAuthRemoteDataSource extends Mock implements IAuthRemoteDataSource {}

class MockIAuthLocalDataSource extends Mock implements IAuthLocalDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockIAuthRemoteDataSource mockRemoteDataSource;
  late MockIAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockIAuthRemoteDataSource();
    mockLocalDataSource = MockIAuthLocalDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUid = '123';
  const tUserDto = AuthUserDto(uid: tUid, email: tEmail);
  const tUserModel = UserModel(id: tUid, email: tEmail);
  const tFailure = Failure.server('Exception');
  const tGoogleSignInFailure = Failure.server(
    "We couldn't sign you in with Google. Please try again.",
  );
  const tAppleSignInFailure = Failure.server(
    "We couldn't sign you in with Apple. Please try again.",
  );
  const tGoogleCancelled = GoogleSignInException(
    code: GoogleSignInExceptionCode.canceled,
  );
  const tGoogleInterrupted = GoogleSignInException(
    code: GoogleSignInExceptionCode.interrupted,
  );
  final tAppleCancelled = SignInWithAppleAuthorizationException(
    code: AuthorizationErrorCode.canceled,
    message: 'cancelled',
  );
  final tAppleFailed = SignInWithAppleAuthorizationException(
    code: AuthorizationErrorCode.failed,
    message: 'failed',
  );

  group('signInWithEmail', () {
    test('signInWithEmail_success_returnsRightUserModel', () async {
      // arrange
      when(
        () => mockRemoteDataSource.signInWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => tUserDto);

      // act
      final result = await repository.signInWithEmail(
        email: tEmail,
        password: tPassword,
      );

      // assert
      expect(result, equals(const Right(tUserModel)));
      verify(
        () => mockRemoteDataSource.signInWithEmail(
          email: tEmail,
          password: tPassword,
        ),
      );
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('signInWithEmail_failure_returnsLeftServerFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.signInWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception());

      // act
      final result = await repository.signInWithEmail(
        email: tEmail,
        password: tPassword,
      );

      // assert
      expect(result, equals(const Left(tFailure)));
      verify(
        () => mockRemoteDataSource.signInWithEmail(
          email: tEmail,
          password: tPassword,
        ),
      );
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('resetPassword', () {
    test('resetPassword_success_returnsRightVoid', () async {
      // arrange
      when(
        () => mockRemoteDataSource.resetPassword(email: any(named: 'email')),
      ).thenAnswer((_) async {});

      // act
      final result = await repository.resetPassword(email: tEmail);

      // assert
      expect(result, equals(const Right(null)));
      verify(() => mockRemoteDataSource.resetPassword(email: tEmail));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('resetPassword_failure_returnsLeftServerFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.resetPassword(email: any(named: 'email')),
      ).thenThrow(Exception());

      // act
      final result = await repository.resetPassword(email: tEmail);

      // assert
      expect(result, equals(const Left(tFailure)));
      verify(() => mockRemoteDataSource.resetPassword(email: tEmail));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('deleteAccount', () {
    test('deleteAccount_success_returnsRightVoid', () async {
      // arrange
      when(() => mockRemoteDataSource.deleteAccount()).thenAnswer((_) async {});
      when(() => mockLocalDataSource.clearAll()).thenAnswer((_) async {});

      // act
      final result = await repository.deleteAccount();

      // assert
      expect(result, equals(const Right(null)));
      verify(() => mockRemoteDataSource.deleteAccount());
      verify(() => mockLocalDataSource.clearAll());
    });

    test('deleteAccount_failure_returnsLeftServerFailure', () async {
      // arrange
      when(() => mockRemoteDataSource.deleteAccount()).thenThrow(Exception());

      // act
      final result = await repository.deleteAccount();

      // assert
      expect(result, equals(const Left(tFailure)));
      verify(() => mockRemoteDataSource.deleteAccount());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('signOut', () {
    test(
      'signOut_success_callsClearAndRemoteSignOut_returnsRightVoid',
      () async {
        // arrange
        when(() => mockLocalDataSource.clearAll()).thenAnswer((_) async {});
        when(() => mockRemoteDataSource.signOut()).thenAnswer((_) async {});

        // act
        final result = await repository.signOut();

        // assert
        expect(result, equals(const Right(null)));
        verify(() => mockLocalDataSource.clearAll()).called(1);
        verify(() => mockRemoteDataSource.signOut()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test('signOut_remoteThrows_returnsLeftServerFailure', () async {
      // arrange
      when(() => mockLocalDataSource.clearAll()).thenAnswer((_) async {});
      when(() => mockRemoteDataSource.signOut()).thenThrow(Exception());

      // act
      final result = await repository.signOut();

      // assert
      expect(result, equals(const Left(tFailure)));
      verifyNever(() => mockRemoteDataSource.deleteAnonymousUserAndSignOut());
    });
  });

  group('deleteAnonymousUserAndSignOut', () {
    test(
      'deleteAnonymousUserAndSignOut_success_clearsThenCallsRemoteDelete_returnsRightVoid',
      () async {
        // arrange
        when(() => mockLocalDataSource.clearAll()).thenAnswer((_) async {});
        when(
          () => mockRemoteDataSource.deleteAnonymousUserAndSignOut(),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.deleteAnonymousUserAndSignOut();

        // assert
        expect(result, equals(const Right(null)));
        verifyInOrder([
          () => mockLocalDataSource.clearAll(),
          () => mockRemoteDataSource.deleteAnonymousUserAndSignOut(),
        ]);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'deleteAnonymousUserAndSignOut_remoteThrows_returnsLeftServerFailure',
      () async {
        // arrange
        when(() => mockLocalDataSource.clearAll()).thenAnswer((_) async {});
        when(
          () => mockRemoteDataSource.deleteAnonymousUserAndSignOut(),
        ).thenThrow(Exception());

        // act
        final result = await repository.deleteAnonymousUserAndSignOut();

        // assert
        expect(result, equals(const Left(tFailure)));
      },
    );
  });

  group('signInWithGoogle', () {
    test('signInWithGoogle_success_returnsRightUserModel', () async {
      // arrange
      when(
        () => mockRemoteDataSource.signInWithGoogle(),
      ).thenAnswer((_) async => tUserDto);

      // act
      final result = await repository.signInWithGoogle();

      // assert
      expect(result, equals(const Right(tUserModel)));
    });

    test('signInWithGoogle_userCancels_returnsLeftCancelFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.signInWithGoogle(),
      ).thenThrow(tGoogleCancelled);

      // act
      final result = await repository.signInWithGoogle();

      // assert
      expect(result, equals(const Left(Failure.cancel())));
    });

    test(
      'signInWithGoogle_providerError_returnsLeftFriendlyServerFailure',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.signInWithGoogle(),
        ).thenThrow(tGoogleInterrupted);

        // act
        final result = await repository.signInWithGoogle();

        // assert
        expect(result, equals(const Left(tGoogleSignInFailure)));
      },
    );
  });

  group('signInWithApple', () {
    test('signInWithApple_success_returnsRightUserModel', () async {
      // arrange
      when(
        () => mockRemoteDataSource.signInWithApple(),
      ).thenAnswer((_) async => tUserDto);

      // act
      final result = await repository.signInWithApple();

      // assert
      expect(result, equals(const Right(tUserModel)));
    });

    test('signInWithApple_userCancels_returnsLeftCancelFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.signInWithApple(),
      ).thenThrow(tAppleCancelled);

      // act
      final result = await repository.signInWithApple();

      // assert
      expect(result, equals(const Left(Failure.cancel())));
    });

    test(
      'signInWithApple_providerError_returnsLeftFriendlyServerFailure',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.signInWithApple(),
        ).thenThrow(tAppleFailed);

        // act
        final result = await repository.signInWithApple();

        // assert
        expect(result, equals(const Left(tAppleSignInFailure)));
      },
    );
  });

  group('linkWithGoogle', () {
    test('linkWithGoogle_success_returnsRightUserModel', () async {
      // arrange
      when(
        () => mockRemoteDataSource.linkWithGoogle(),
      ).thenAnswer((_) async => tUserDto);

      // act
      final result = await repository.linkWithGoogle();

      // assert
      expect(result, equals(const Right(tUserModel)));
    });

    test('linkWithGoogle_userCancels_returnsLeftCancelFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.linkWithGoogle(),
      ).thenThrow(tGoogleCancelled);

      // act
      final result = await repository.linkWithGoogle();

      // assert
      expect(result, equals(const Left(Failure.cancel())));
    });

    test(
      'linkWithGoogle_providerError_returnsLeftFriendlyServerFailure',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.linkWithGoogle(),
        ).thenThrow(tGoogleInterrupted);

        // act
        final result = await repository.linkWithGoogle();

        // assert
        expect(result, equals(const Left(tGoogleSignInFailure)));
      },
    );
  });

  group('linkWithApple', () {
    test('linkWithApple_success_returnsRightUserModel', () async {
      // arrange
      when(
        () => mockRemoteDataSource.linkWithApple(),
      ).thenAnswer((_) async => tUserDto);

      // act
      final result = await repository.linkWithApple();

      // assert
      expect(result, equals(const Right(tUserModel)));
    });

    test('linkWithApple_userCancels_returnsLeftCancelFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.linkWithApple(),
      ).thenThrow(tAppleCancelled);

      // act
      final result = await repository.linkWithApple();

      // assert
      expect(result, equals(const Left(Failure.cancel())));
    });

    test(
      'linkWithApple_providerError_returnsLeftFriendlyServerFailure',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.linkWithApple(),
        ).thenThrow(tAppleFailed);

        // act
        final result = await repository.linkWithApple();

        // assert
        expect(result, equals(const Left(tAppleSignInFailure)));
      },
    );
  });
}
