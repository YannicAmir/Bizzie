part of 'user_bloc.dart';

@freezed
sealed class UserEvent with _$UserEvent {
  const factory UserEvent.loadUser({
    required String uid,
    @Default(false) bool silent,
  }) = UserLoadRequested;
  const factory UserEvent.reset() = UserReset;
}
