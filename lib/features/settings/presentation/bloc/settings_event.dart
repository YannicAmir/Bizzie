import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.started() = Started;
  const factory SettingsEvent.toggledNotifications(bool enable) =
      ToggledNotifications;
  const factory SettingsEvent.signedOut() = SignedOut;
  const factory SettingsEvent.refreshSubscription() = RefreshSubscription;
  const factory SettingsEvent.openUrl(String url) = OpenUrl;
  const factory SettingsEvent.resetPassword() = ResetPassword;
  const factory SettingsEvent.openedSettings() = OpenedSettings;
  const factory SettingsEvent.editProfileClicked() = EditProfileClicked;
  const factory SettingsEvent.feedbackClicked() = FeedbackClicked;
  const factory SettingsEvent.membershipClicked(bool isSubscribed) =
      MembershipClicked;
}
