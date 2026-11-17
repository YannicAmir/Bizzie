import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/enums/guest_gate_trigger.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';

part 'auth_event.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.statusRequested() = AuthStatusRequested;
  const factory AuthEvent.logoutRequested() = AuthLogoutRequested;
  const factory AuthEvent.googleSignInRequested({required AuthSource source}) =
      AuthGoogleSignInRequested;
  const factory AuthEvent.appleSignInRequested({required AuthSource source}) =
      AuthAppleSignInRequested;
  const factory AuthEvent.resetPasswordRequested(
    String email, {
    required AuthSource source,
  }) = AuthResetPasswordRequested;
  const factory AuthEvent.deleteAccountRequested() = AuthDeleteAccountRequested;
  const factory AuthEvent.emailSignInRequested(
    String email,
    String password, {
    required AuthSource source,
  }) = AuthEmailSignInRequested;
  const factory AuthEvent.emailSignUpRequested(
    String email,
    String password, {
    required AuthSource source,
  }) = AuthEmailSignUpRequested;
  const factory AuthEvent.legalLinkOpened(String url) = AuthLegalLinkOpened;
  const factory AuthEvent.guestGateShown({required GuestGateTrigger trigger}) =
      AuthGuestGateShown;
  const factory AuthEvent.guestGateDismissed() = AuthGuestGateDismissed;
  const factory AuthEvent.guestLinkStarted({
    required GuestGateTrigger trigger,
  }) = AuthGuestLinkStarted;
}
