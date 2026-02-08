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
}
