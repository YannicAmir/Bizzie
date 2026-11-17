import 'package:bizzie/features/settings/domain/enums/guest_logout_choice.dart';
import 'package:bizzie/features/settings/domain/enums/settings_link_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.freezed.dart';

@freezed
sealed class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.started() = Started;
  const factory SettingsEvent.toggledNotifications({required bool enable}) =
      ToggledNotifications;
  const factory SettingsEvent.signedOut() = SignedOut;
  const factory SettingsEvent.guestLogoutPromptResolved(
    GuestLogoutChoice choice,
  ) = GuestLogoutPromptResolved;
  const factory SettingsEvent.openUrl(String url, SettingsLinkType type) =
      OpenUrl;
  const factory SettingsEvent.openedSettings() = OpenedSettings;
  const factory SettingsEvent.permissionPromptProcessed() =
      PermissionPromptProcessed;
  const factory SettingsEvent.editProfileClicked() = EditProfileClicked;
  const factory SettingsEvent.feedbackClicked() = FeedbackClicked;
  const factory SettingsEvent.membershipClicked({required bool isSubscribed}) =
      MembershipClicked;
}
