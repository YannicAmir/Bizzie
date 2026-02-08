import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/error/failures.dart';

part 'edit_profile_state.freezed.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial() = _Initial;
  const factory EditProfileState.loading({String? favoriteSector}) = _Loading;
  const factory EditProfileState.success() = _Success;
  const factory EditProfileState.failure(
    Failure failure, {
    String? favoriteSector,
  }) = _Failure;
  const factory EditProfileState.form({
    required String firstName,
    required String email,
    required String originalFirstName,
    required String originalEmail,
    String? favoriteSector,
    @Default(false) bool isSubmitting,
    Failure? saveFailure,
  }) = _Form;
}
