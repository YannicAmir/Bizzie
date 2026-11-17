import 'package:bizzie/features/auth/data/datasources/remote_auth_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUser extends Mock implements User {}

const tUid = 'uid_123';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockUser mockUser;
  late RemoteAuthDataSourceImpl sut;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockUser = MockUser();
    sut = RemoteAuthDataSourceImpl(mockFirebaseAuth, mockGoogleSignIn);

    when(() => mockUser.uid).thenReturn(tUid);
    when(() => mockGoogleSignIn.signOut()).thenAnswer((_) async {});
    when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});
  });

  group('RemoteAuthDataSourceImpl', () {
    group('signOut', () {
      test('signOut_anonymousUser_signsOutWithoutDeleting', () async {
        // arrange
        when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(() => mockUser.isAnonymous).thenReturn(true);

        // act
        await sut.signOut();

        // assert
        verifyNever(() => mockUser.delete());
        verify(() => mockFirebaseAuth.signOut()).called(1);
      });

      test('signOut_registeredUser_signsOutWithoutDeleting', () async {
        // arrange
        when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(() => mockUser.isAnonymous).thenReturn(false);

        // act
        await sut.signOut();

        // assert
        verifyNever(() => mockUser.delete());
        verify(() => mockFirebaseAuth.signOut()).called(1);
      });

      test('signOut_noCurrentUser_signsOutWithoutDeleting', () async {
        // arrange
        when(() => mockFirebaseAuth.currentUser).thenReturn(null);

        // act
        await sut.signOut();

        // assert
        verifyNever(() => mockUser.delete());
        verify(() => mockFirebaseAuth.signOut()).called(1);
      });

      test('signOut_firebaseSignOutThrows_rethrows', () async {
        // arrange
        when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(() => mockUser.isAnonymous).thenReturn(false);
        when(
          () => mockFirebaseAuth.signOut(),
        ).thenThrow(FirebaseAuthException(code: 'unknown'));

        // act
        final call = sut.signOut();

        // assert
        await expectLater(call, throwsA(isA<FirebaseAuthException>()));
      });
    });

    group('deleteAnonymousUserAndSignOut', () {
      test(
        'deleteAnonymousUserAndSignOut_anonymousUser_deletesUserThenSignsOut',
        () async {
          // arrange
          when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
          when(() => mockUser.isAnonymous).thenReturn(true);
          when(() => mockUser.delete()).thenAnswer((_) async {});

          // act
          await sut.deleteAnonymousUserAndSignOut();

          // assert
          verifyInOrder([
            () => mockUser.delete(),
            () => mockFirebaseAuth.signOut(),
          ]);
        },
      );

      test(
        'deleteAnonymousUserAndSignOut_anonymousDeleteThrows_stillSignsOut',
        () async {
          // arrange
          when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
          when(() => mockUser.isAnonymous).thenReturn(true);
          when(
            () => mockUser.delete(),
          ).thenThrow(FirebaseAuthException(code: 'network-request-failed'));

          // act
          await sut.deleteAnonymousUserAndSignOut();

          // assert
          verify(() => mockUser.delete()).called(1);
          verify(() => mockFirebaseAuth.signOut()).called(1);
        },
      );

      test(
        'deleteAnonymousUserAndSignOut_registeredUser_signsOutWithoutDeleting',
        () async {
          // arrange
          when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
          when(() => mockUser.isAnonymous).thenReturn(false);

          // act
          await sut.deleteAnonymousUserAndSignOut();

          // assert
          verifyNever(() => mockUser.delete());
          verify(() => mockFirebaseAuth.signOut()).called(1);
        },
      );

      test(
        'deleteAnonymousUserAndSignOut_noCurrentUser_signsOutWithoutDeleting',
        () async {
          // arrange
          when(() => mockFirebaseAuth.currentUser).thenReturn(null);

          // act
          await sut.deleteAnonymousUserAndSignOut();

          // assert
          verifyNever(() => mockUser.delete());
          verify(() => mockFirebaseAuth.signOut()).called(1);
        },
      );

      test(
        'deleteAnonymousUserAndSignOut_firebaseSignOutThrows_rethrows',
        () async {
          // arrange
          when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
          when(() => mockUser.isAnonymous).thenReturn(true);
          when(() => mockUser.delete()).thenAnswer((_) async {});
          when(
            () => mockFirebaseAuth.signOut(),
          ).thenThrow(FirebaseAuthException(code: 'unknown'));

          // act
          final call = sut.deleteAnonymousUserAndSignOut();

          // assert
          await expectLater(call, throwsA(isA<FirebaseAuthException>()));
        },
      );
    });
  });
}
