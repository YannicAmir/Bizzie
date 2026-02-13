import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_event.freezed.dart';

@freezed
class ChangePasswordEvent with _$ChangePasswordEvent {
  const factory ChangePasswordEvent.started() = Started;
  const factory ChangePasswordEvent.oldPasswordChanged(String password) =
      OldPasswordChanged;
  const factory ChangePasswordEvent.newPasswordChanged(String password) =
      NewPasswordChanged;
  const factory ChangePasswordEvent.confirmPasswordChanged(String password) =
      ConfirmPasswordChanged;
  const factory ChangePasswordEvent.saveRequested() = SaveRequested;
}
