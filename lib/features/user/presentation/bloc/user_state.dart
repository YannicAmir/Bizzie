part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading({String? cachedSector}) = _Loading;
  const factory UserState.loaded(UserModel user) = _Loaded;
  const factory UserState.needsProfile() = _NeedsProfile;
  const factory UserState.failure(
    String message, {
    required String uid,
    String? cachedSector,
  }) = _Failure;
}
