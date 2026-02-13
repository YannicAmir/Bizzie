import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/error/failures.dart';

part 'change_password_state.freezed.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.initial() = _Initial;
  const factory ChangePasswordState.loading() = _Loading;
  const factory ChangePasswordState.success() = _Success;
  const factory ChangePasswordState.form({
    @Default('') String oldPassword,
    @Default('') String newPassword,
    @Default('') String confirmPassword,
    @Default(false) bool isSubmitting,
    Failure? failure,
  }) = _Form;
}
