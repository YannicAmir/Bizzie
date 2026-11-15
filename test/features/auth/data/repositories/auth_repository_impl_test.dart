import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/data/dtos/auth_user_dto.dart';
import 'package:bizzie/features/auth/data/interfaces/i_auth_local_datasource.dart';
import 'package:bizzie/features/auth/data/interfaces/i_auth_remote_datasource.dart';
import 'package:bizzie/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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
}
