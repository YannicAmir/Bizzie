import 'package:bizzie/features/auth/data/dtos/auth_user_dto.dart';

abstract class IAuthRemoteDataSource {
  Future<void> initialize();
  Stream<AuthUserDto?> get authStateChanges;
  AuthUserDto? get currentUser;
  Future<AuthUserDto> signInWithEmail({
    required String email,
    required String password,
  });
  Future<AuthUserDto> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<AuthUserDto> signInWithGoogle();
  Future<AuthUserDto> signInWithApple();
  Future<AuthUserDto> signInAnonymously();
  Future<AuthUserDto> linkWithEmail({
    required String email,
    required String password,
  });
  Future<AuthUserDto> linkWithGoogle();
  Future<AuthUserDto> linkWithApple();
  Future<void> signOut();
  Future<void> deleteAnonymousUserAndSignOut();
  Future<void> resetPassword({required String email});
  Future<void> deleteAccount();
  Future<void> reauthenticateWithApple();
  Future<void> reauthenticateWithPassword(String password);
  Future<void> reauthenticateWithGoogle();
  Future<void> updateUserEmail(String newEmail);
  Future<void> updateUserPassword({
    required String oldPassword,
    required String newPassword,
  });
}
