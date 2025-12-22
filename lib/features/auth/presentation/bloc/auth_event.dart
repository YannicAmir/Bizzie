import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/user_model.dart';

part 'auth_event.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.statusRequested() = AuthStatusRequested;
  const factory AuthEvent.logoutRequested() = AuthLogoutRequested;
  const factory AuthEvent.googleSignInRequested() = AuthGoogleSignInRequested;
  const factory AuthEvent.appleSignInRequested() = AuthAppleSignInRequested;
  const factory AuthEvent.resetPasswordRequested(String email) =
      AuthResetPasswordRequested;
  const factory AuthEvent.deleteAccountRequested() = AuthDeleteAccountRequested;
  const factory AuthEvent.emailSignInRequested(String email, String password) =
      AuthEmailSignInRequested;
  const factory AuthEvent.emailSignUpRequested(String email, String password) =
      AuthEmailSignUpRequested;
  const factory AuthEvent.statusChanged(UserModel? user) = AuthStatusChanged;
}
