import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_event.freezed.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.started() = Started;
  const factory EditProfileEvent.firstNameChanged(String firstName) =
      FirstNameChanged;
  const factory EditProfileEvent.emailChanged(String email) = EmailChanged;
  const factory EditProfileEvent.saveRequested() = SaveRequested;
  const factory EditProfileEvent.deleteAccountRequested() =
      DeleteAccountRequested;
  const factory EditProfileEvent.reauthenticateWithPassword(String password) =
      ReauthenticateWithPassword;
  const factory EditProfileEvent.reauthenticateWithGoogle() =
      ReauthenticateWithGoogle;
  const factory EditProfileEvent.reauthenticateWithApple() =
      ReauthenticateWithApple;
  const factory EditProfileEvent.reauthModalDismissed() = ReauthModalDismissed;
  const factory EditProfileEvent.deleteAccountConfirmed() =
      DeleteAccountConfirmed;
  const factory EditProfileEvent.deleteConfirmationDismissed() =
      DeleteConfirmationDismissed;
  const factory EditProfileEvent.showDeleteConfirmation() =
      ShowDeleteConfirmation;
  const factory EditProfileEvent.toggleReauthPasswordVisibility() =
      ToggleReauthPasswordVisibility;
}
