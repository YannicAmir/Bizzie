part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.started() = _Started;
  const factory UserEvent.loadUser(String uid, {@Default(false) bool silent}) =
      _LoadUser;
  const factory UserEvent.clear() = _Clear;
}
