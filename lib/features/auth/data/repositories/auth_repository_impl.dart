import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/interfaces/i_auth_repository.dart';
import '../../domain/models/user_model.dart';
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
      return Right(_mapFirebaseUserToUserModel(firebaseUser));
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('SignInWithEmail failed', e);
      return Left(Failure.server(e.message ?? 'Authentication failed'));
    } catch (e) {
      _logger.severe('SignInWithEmail unknown error', e);
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
      return Right(_mapFirebaseUserToUserModel(firebaseUser));
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('SignUpWithEmail failed', e);
      return Left(Failure.server(e.message ?? 'Registration failed'));
    } catch (e) {
      _logger.severe('SignUpWithEmail unknown error', e);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      final firebaseUser = await remoteDataSource.signInWithGoogle();
      return Right(_mapFirebaseUserToUserModel(firebaseUser));
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('SignInWithGoogle failed', e);
      return Left(Failure.server(e.message ?? 'Google Sign-In failed'));
    } catch (e) {
      _logger.severe('SignInWithGoogle unknown error', e);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithApple() async {
    try {
      final firebaseUser = await remoteDataSource.signInWithApple();
      return Right(_mapFirebaseUserToUserModel(firebaseUser));
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('SignInWithApple failed', e);
      return Left(Failure.server(e.message ?? 'Apple Sign-In failed'));
    } catch (e) {
      _logger.severe('SignInWithApple unknown error', e);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await sharedPreferences.clear();

      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      _logger.severe('SignOut failed', e);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await remoteDataSource.resetPassword(email: email);
      return const Right(null);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('ResetPassword failed', e);
      return Left(Failure.server(e.message ?? 'Password reset failed'));
    } catch (e) {
      _logger.severe('ResetPassword unknown error', e);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      return const Right(null);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('DeleteAccount failed', e);
      return Left(Failure.server(e.message ?? 'Account deletion failed'));
    } catch (e) {
      _logger.severe('DeleteAccount unknown error', e);
      return Left(Failure.server(e.toString()));
    }
  }

  UserModel _mapFirebaseUserToUserModel(firebase.User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}
