import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/data/datasources/remote_auth_data_source.dart';
import 'package:bizzie/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockRemoteAuthDataSource extends Mock implements RemoteAuthDataSource {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockUser extends Mock implements firebase_auth.User {}

void main() {
  late AuthRepositoryImpl repository;
  late MockRemoteAuthDataSource mockRemoteDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockRemoteDataSource = MockRemoteAuthDataSource();
    mockSharedPreferences = MockSharedPreferences();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      sharedPreferences: mockSharedPreferences,
    );
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUid = '123';
  final tFirebaseUser = MockUser();
  const tUserModel = UserModel(id: tUid, email: tEmail);
  const tFailure = ServerFailure('Exception');

  group('signInWithEmail', () {
    test('signInWithEmail_success_returnsRightUserModel', () async {
      // arrange
      when(() => tFirebaseUser.uid).thenReturn(tUid);
      when(() => tFirebaseUser.email).thenReturn(tEmail);
      when(
        () => mockRemoteDataSource.signInWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => tFirebaseUser);

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

      // act
      final result = await repository.deleteAccount();

      // assert
      expect(result, equals(const Right(null)));
      verify(() => mockRemoteDataSource.deleteAccount());
      verifyNoMoreInteractions(mockRemoteDataSource);
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
        when(() => mockSharedPreferences.clear()).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.signOut()).thenAnswer((_) async {});

        // act
        final result = await repository.signOut();

        // assert
        expect(result, equals(const Right(null)));
        verify(() => mockSharedPreferences.clear()).called(1);
        verify(() => mockRemoteDataSource.signOut()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}
