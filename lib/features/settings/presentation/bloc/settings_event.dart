import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.started() = _Started;
  const factory SettingsEvent.toggledNotifications(bool enable) =
      _ToggledNotifications;
  const factory SettingsEvent.signedOut() = _SignedOut;
  const factory SettingsEvent.refreshSubscription() = _RefreshSubscription;
  const factory SettingsEvent.openUrl(String url) = _OpenUrl;
  const factory SettingsEvent.submitFeedback(String message) = _SubmitFeedback;
  const factory SettingsEvent.resetPassword() = _ResetPassword;
}
