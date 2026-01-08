import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/interfaces/i_auth_repository.dart';
import '../../domain/models/user_model.dart';
import '../datasources/remote_auth_data_source.dart';

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
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final firebaseUser = await remoteDataSource.signInWithEmail(
      email: email,
      password: password,
    );
    return _mapFirebaseUserToUserModel(firebaseUser);
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final firebaseUser = await remoteDataSource.signUpWithEmail(
      email: email,
      password: password,
    );
    return _mapFirebaseUserToUserModel(firebaseUser);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final firebaseUser = await remoteDataSource.signInWithGoogle();
    return _mapFirebaseUserToUserModel(firebaseUser);
  }

  @override
  Future<UserModel> signInWithApple() async {
    final firebaseUser = await remoteDataSource.signInWithApple();
    return _mapFirebaseUserToUserModel(firebaseUser);
  }

  @override
  Future<void> signOut() async {
    await sharedPreferences.clear();
    return remoteDataSource.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    return remoteDataSource.resetPassword(email: email);
  }

  @override
  Future<void> deleteAccount() async {
    return remoteDataSource.deleteAccount();
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
