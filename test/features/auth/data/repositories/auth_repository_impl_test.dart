import 'package:bizzie/features/auth/data/datasources/remote_auth_data_source.dart';
import 'package:bizzie/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteAuthDataSource extends Mock implements RemoteAuthDataSource {}

class MockUser extends Mock implements firebase_auth.User {}

void main() {
  late AuthRepositoryImpl repository;
  late MockRemoteAuthDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteAuthDataSource();
    repository = AuthRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUid = '123';
  final tFirebaseUser = MockUser();
  const tUserModel = UserModel(id: tUid, email: tEmail);

  group('signInWithEmail', () {
    test('signInWithEmail_success_returnsUserModel', () async {
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
      expect(result, equals(tUserModel));
      verify(
        () => mockRemoteDataSource.signInWithEmail(
          email: tEmail,
          password: tPassword,
        ),
      );
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('signInWithEmail_failure_throwsException', () async {
      // arrange
      when(
        () => mockRemoteDataSource.signInWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception());

      // act
      final call = repository.signInWithEmail;

      // assert
      expect(() => call(email: tEmail, password: tPassword), throwsException);
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
    test('resetPassword_success_callsRemoteDataSource', () async {
      // arrange
      when(
        () => mockRemoteDataSource.resetPassword(email: any(named: 'email')),
      ).thenAnswer((_) async {});

      // act
      await repository.resetPassword(email: tEmail);

      // assert
      verify(() => mockRemoteDataSource.resetPassword(email: tEmail));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('resetPassword_failure_throwsException', () async {
      // arrange
      when(
        () => mockRemoteDataSource.resetPassword(email: any(named: 'email')),
      ).thenThrow(Exception());

      // act
      final call = repository.resetPassword;

      // assert
      expect(() => call(email: tEmail), throwsException);
      verify(() => mockRemoteDataSource.resetPassword(email: tEmail));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('deleteAccount', () {
    test('deleteAccount_success_callsRemoteDataSource', () async {
      // arrange
      when(() => mockRemoteDataSource.deleteAccount()).thenAnswer((_) async {});

      // act
      await repository.deleteAccount();

      // assert
      verify(() => mockRemoteDataSource.deleteAccount());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('deleteAccount_failure_throwsException', () async {
      // arrange
      when(() => mockRemoteDataSource.deleteAccount()).thenThrow(Exception());

      // act
      final call = repository.deleteAccount;

      // assert
      expect(() => call(), throwsException);
      verify(() => mockRemoteDataSource.deleteAccount());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
