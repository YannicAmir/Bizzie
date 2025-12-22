import 'package:firebase_auth/firebase_auth.dart' as firebase;
import '../../domain/interfaces/i_auth_repository.dart';
import '../../domain/models/user_model.dart';
import '../datasources/remote_auth_data_source.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final RemoteAuthDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<UserModel?> get authStateChanges {
    return remoteDataSource.authStateChanges.map((firebaseUser) {
      if (firebaseUser == null) return null;
      return _mapFirebaseUserToUserModel(firebaseUser);
    });
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
