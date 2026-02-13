import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/interfaces/i_auth_repository.dart';
import '../../domain/models/user_model.dart';
import 'package:bizzie/core/utils/retry_util.dart';
import '../datasources/remote_auth_data_source.dart';

final _logger = BizzieLogger('AuthRepositoryImpl');

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final RemoteAuthDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, void>> updateEmail(String newEmail) async {
    try {
      await remoteDataSource.updateUserEmail(newEmail);
      _logger.info('Verification email sent to $newEmail');
      return const Right(null);
    } on UserNotSignedInException {
      return const Left(Failure.userNotFound());
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('UpdateEmail failed: ${e.code}', e);
      if (e.code == 'requires-recent-login') {
        return const Left(Failure.reauthentication());
      }
      return Left(Failure.server(e.message ?? 'Update email failed'));
    } catch (e, s) {
      _logger.severe('UpdateEmail unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.updateUserPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      _logger.info('UpdatePassword successful');
      return const Right(null);
    } on UserNotSignedInException {
      return const Left(Failure.userNotFound());
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('UpdatePassword failed: ${e.code}', e);
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return const Left(Failure.reauthentication());
      }
      return Left(Failure.server(e.message ?? 'Update password failed'));
    } catch (e, s) {
      _logger.severe('UpdatePassword unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<void> initialize() async {
    try {
      await remoteDataSource.initialize();
    } catch (e, s) {
      _logger.severe('Auth initialization failed', e, s);
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return remoteDataSource.authStateChanges.map((firebaseUser) {
      if (firebaseUser == null) return null;
      return _mapFirebaseUserToUserModel(firebaseUser);
    });
  }

  @override
  UserModel? get currentUser {
    final firebaseUser = remoteDataSource.currentUser;
    if (firebaseUser == null) return null;
    return _mapFirebaseUserToUserModel(firebaseUser);
  }

  @override
  Future<Either<Failure, UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final firebaseUser = await remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      final user = _mapFirebaseUserToUserModel(firebaseUser);
      _logger.info('SignInWithEmail successful for user: ${user.id}');
      return Right(user);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('SignInWithEmail failed: ${e.code}', e);
      return Left(Failure.server(e.message ?? 'Authentication failed'));
    } catch (e, s) {
      _logger.severe('SignInWithEmail unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final firebaseUser = await remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
      );
      final user = _mapFirebaseUserToUserModel(firebaseUser);
      _logger.info('SignUpWithEmail successful for user: ${user.id}');
      return Right(user);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('SignUpWithEmail failed: ${e.code}', e);
      return Left(Failure.server(e.message ?? 'Registration failed'));
    } catch (e, s) {
      _logger.severe('SignUpWithEmail unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      final firebaseUser = await remoteDataSource.signInWithGoogle();
      final user = _mapFirebaseUserToUserModel(firebaseUser);
      _logger.info('SignInWithGoogle successful for user: ${user.id}');
      return Right(user);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('SignInWithGoogle failed: ${e.code}', e);
      return Left(Failure.server(e.message ?? 'Google Sign-In failed'));
    } catch (e, s) {
      _logger.severe('SignInWithGoogle unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithApple() async {
    try {
      final firebaseUser = await remoteDataSource.signInWithApple();
      final user = _mapFirebaseUserToUserModel(firebaseUser);
      _logger.info('SignInWithApple successful for user: ${user.id}');
      return Right(user);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('SignInWithApple failed: ${e.code}', e);
      return Left(Failure.server(e.message ?? 'Apple Sign-In failed'));
    } catch (e, s) {
      _logger.severe('SignInWithApple unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      _logger.info('Starting SignOut process');
      await sharedPreferences.clear();
      await remoteDataSource.signOut();
      _logger.info('SignOut successful');
      return const Right(null);
    } catch (e, s) {
      _logger.severe('SignOut failed', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await remoteDataSource.resetPassword(email: email);
      _logger.info('ResetPassword email sent successfully to: $email');
      return const Right(null);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('ResetPassword failed: ${e.code}', e);
      return Left(Failure.server(e.message ?? 'Password reset failed'));
    } catch (e, s) {
      _logger.severe('ResetPassword unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      await sharedPreferences.clear();
      _logger.info('DeleteAccount successful and preferences cleared');
      return const Right(null);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('DeleteAccount failed: ${e.code}', e);
      if (e.code == 'requires-recent-login') {
        return const Left(Failure.reauthentication());
      }
      return Left(Failure.server(e.message ?? 'Account deletion failed'));
    } catch (e, s) {
      _logger.severe('DeleteAccount unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reauthenticateWithPassword(
    String password,
  ) async {
    try {
      await RetryUtil.retry(
        task: () => remoteDataSource.reauthenticateWithPassword(password),
      );
      _logger.info('ReauthenticateWithPassword successful');
      return const Right(null);
    } on UserNotSignedInException {
      return const Left(Failure.userNotFound());
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('ReauthenticateWithPassword failed: ${e.code}', e);
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return const Left(Failure.reauthentication());
      }
      return Left(Failure.server(e.message ?? 'Re-authentication failed'));
    } catch (e, s) {
      _logger.severe('ReauthenticateWithPassword unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reauthenticateWithGoogle() async {
    try {
      await RetryUtil.retry(
        task: () => remoteDataSource.reauthenticateWithGoogle(),
      );
      _logger.info('ReauthenticateWithGoogle successful');
      return const Right(null);
    } on UserNotSignedInException {
      return const Left(Failure.userNotFound());
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('ReauthenticateWithGoogle failed: ${e.code}', e);
      return Left(Failure.server(e.message ?? 'Re-authentication failed'));
    } catch (e, s) {
      _logger.severe('ReauthenticateWithGoogle unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reauthenticateWithApple() async {
    try {
      await RetryUtil.retry(
        task: () => remoteDataSource.reauthenticateWithApple(),
      );
      _logger.info('ReauthenticateWithApple successful');
      return const Right(null);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('ReauthenticateWithApple failed: ${e.code}', e);
      return Left(
        Failure.server(e.message ?? 'Apple Re-authentication failed'),
      );
    } catch (e, s) {
      _logger.severe('ReauthenticateWithApple unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  UserModel _mapFirebaseUserToUserModel(firebase.User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      providers: user.providerData.map((e) => e.providerId).toList(),
    );
  }
}
