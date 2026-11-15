import 'dart:async';

import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/interfaces/i_auth_repository.dart';
import '../../domain/models/user_model.dart';
import 'package:bizzie/core/utils/retry_util.dart';
import '../dtos/auth_user_dto.dart';
import '../interfaces/i_auth_local_datasource.dart';
import '../interfaces/i_auth_remote_datasource.dart';

final _logger = BizzieLogger('AuthRepositoryImpl');

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;
  final IAuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, void>> updateEmail(String newEmail) async {
    try {
      await _remoteDataSource.updateUserEmail(newEmail);
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
      await _remoteDataSource.updateUserPassword(
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
  Future<Either<Failure, void>> initialize() async {
    try {
      await _remoteDataSource.initialize();
      return const Right(null);
    } catch (e, s) {
      _logger.severe('Auth initialization failed', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, UserModel?>> get authStateChanges {
    return _remoteDataSource.authStateChanges.transform(
      StreamTransformer<AuthUserDto?, Either<Failure, UserModel?>>.fromHandlers(
        handleData: (dto, sink) => sink.add(Right(dto?.toDomain())),
        handleError: (error, stack, sink) {
          _logger.severe('Auth state stream error', error, stack);
          sink.add(Left(Failure.server(error.toString())));
        },
      ),
    );
  }

  @override
  UserModel? get currentUser => _remoteDataSource.currentUser?.toDomain();

  @override
  Future<Either<Failure, UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userDto = await _remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      final user = userDto.toDomain();
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
      final userDto = await _remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
      );
      final user = userDto.toDomain();
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
      final userDto = await _remoteDataSource.signInWithGoogle();
      final user = userDto.toDomain();
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
      final userDto = await _remoteDataSource.signInWithApple();
      final user = userDto.toDomain();
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
  Future<Either<Failure, UserModel>> signInAnonymously() async {
    try {
      final userDto = await _remoteDataSource.signInAnonymously();
      final user = userDto.toDomain();
      _logger.info('SignInAnonymously successful for user: ${user.id}');
      return Right(user);
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('SignInAnonymously failed: ${e.code}', e);
      return Left(Failure.server(e.message ?? 'Anonymous sign-in failed'));
    } catch (e, s) {
      _logger.severe('SignInAnonymously unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> linkWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userDto = await _remoteDataSource.linkWithEmail(
        email: email,
        password: password,
      );
      final user = userDto.toDomain();
      _logger.info('LinkWithEmail successful for user: ${user.id}');
      return Right(user);
    } on UserNotSignedInException {
      return const Left(Failure.userNotFound());
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('LinkWithEmail failed: ${e.code}', e);
      return Left(_mapLinkFailure(e, 'Email link failed'));
    } catch (e, s) {
      _logger.severe('LinkWithEmail unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> linkWithGoogle() async {
    try {
      final userDto = await _remoteDataSource.linkWithGoogle();
      final user = userDto.toDomain();
      _logger.info('LinkWithGoogle successful for user: ${user.id}');
      return Right(user);
    } on UserNotSignedInException {
      return const Left(Failure.userNotFound());
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('LinkWithGoogle failed: ${e.code}', e);
      return Left(_mapLinkFailure(e, 'Google link failed'));
    } catch (e, s) {
      _logger.severe('LinkWithGoogle unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> linkWithApple() async {
    try {
      final userDto = await _remoteDataSource.linkWithApple();
      final user = userDto.toDomain();
      _logger.info('LinkWithApple successful for user: ${user.id}');
      return Right(user);
    } on UserNotSignedInException {
      return const Left(Failure.userNotFound());
    } on firebase.FirebaseAuthException catch (e) {
      _logger.warning('LinkWithApple failed: ${e.code}', e);
      return Left(_mapLinkFailure(e, 'Apple link failed'));
    } catch (e, s) {
      _logger.severe('LinkWithApple unknown error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  Failure _mapLinkFailure(
    firebase.FirebaseAuthException e,
    String fallbackMessage,
  ) {
    return switch (e.code) {
      'credential-already-in-use' => const Failure.credentialAlreadyInUse(),
      'email-already-in-use' => const Failure.emailAlreadyInUse(),
      'provider-already-linked' => const Failure.providerAlreadyLinked(),
      _ => Failure.server(e.message ?? fallbackMessage),
    };
  }

  @override
  Future<Either<Failure, void>> signOut() =>
      _clearPreferencesThenSignOut(_remoteDataSource.signOut);

  @override
  Future<Either<Failure, void>> deleteAnonymousUserAndSignOut() =>
      _clearPreferencesThenSignOut(
        _remoteDataSource.deleteAnonymousUserAndSignOut,
      );

  Future<Either<Failure, void>> _clearPreferencesThenSignOut(
    Future<void> Function() remoteSignOut,
  ) async {
    try {
      _logger.info('Starting SignOut process');
      await _localDataSource.clearAll();
      await remoteSignOut();
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
      await _remoteDataSource.resetPassword(email: email);
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
      await _remoteDataSource.deleteAccount();
      await _localDataSource.clearAll();
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
        task: () => _remoteDataSource.reauthenticateWithPassword(password),
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
        task: () => _remoteDataSource.reauthenticateWithGoogle(),
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
        task: () => _remoteDataSource.reauthenticateWithApple(),
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
}
