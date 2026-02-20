import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = Started;
  const factory ProfileEvent.settingsClicked() = SettingsClicked;
  const factory ProfileEvent.premiumCardClicked() = PremiumCardClicked;
  const factory ProfileEvent.navigationProcessed() = NavigationProcessed;
}
