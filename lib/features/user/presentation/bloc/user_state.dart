import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

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
