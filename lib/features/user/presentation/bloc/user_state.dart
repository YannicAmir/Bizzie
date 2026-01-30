part of 'user_bloc.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState.initial() = UserInitial;
  const factory UserState.loading({String? cachedSector}) = UserLoading;
  const factory UserState.loaded(UserModel user) = UserLoaded;
  const factory UserState.needsProfile() = UserNeedsProfile;
  const factory UserState.failure(
    Failure failure, {
    required String uid,
    String? cachedSector,
  }) = UserFailure;
}
