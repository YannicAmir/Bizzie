import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.freezed.dart';

@freezed
sealed class UserEvent with _$UserEvent {
  const factory UserEvent.loadUser({
    required String uid,
    @Default(false) bool silent,
  }) = UserLoadRequested;
  const factory UserEvent.reset() = UserReset;
  const factory UserEvent.appForegrounded() = UserAppForegrounded;
}
