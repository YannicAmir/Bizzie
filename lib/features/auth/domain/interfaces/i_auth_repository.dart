import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/user_model.dart';

abstract class IAuthRepository {
  Future<void> initialize();
  Stream<UserModel?> get authStateChanges;
  UserModel? get currentUser;
  Future<Either<Failure, UserModel>> signInWithEmail({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel>> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> updateEmail(String newEmail);
  Future<Either<Failure, void>> updatePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<Either<Failure, UserModel>> signInWithGoogle();
  Future<Either<Failure, UserModel>> signInWithApple();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> resetPassword({required String email});
  Future<Either<Failure, void>> deleteAccount();
  Future<Either<Failure, void>> reauthenticateWithPassword(String password);
  Future<Either<Failure, void>> reauthenticateWithGoogle();
  Future<Either<Failure, void>> reauthenticateWithApple();
}
