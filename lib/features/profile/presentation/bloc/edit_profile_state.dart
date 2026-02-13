import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/profile/domain/enums/reauth_action.dart';

part 'edit_profile_state.freezed.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial({String? favoriteSector}) = _Initial;
  const factory EditProfileState.loading({String? favoriteSector}) = _Loading;
  const factory EditProfileState.success({String? favoriteSector}) = _Success;
  const factory EditProfileState.failure(
    Failure failure, {
    String? favoriteSector,
  }) = _Failure;
  const factory EditProfileState.deleted({String? favoriteSector}) = _Deleted;
  const factory EditProfileState.form({
    required String firstName,
    required String email,
    required String originalFirstName,
    required String originalEmail,
    String? favoriteSector,
    @Default(false) bool isSubmitting,
    Failure? saveFailure,
    @Default(false) bool isShowReauthModal,
    ReauthAction? pendingReauthAction,
    @Default(false) bool isReauthSubmitting,
    Failure? reauthFailure,
    @Default(0) int reauthAttempts,
    @Default([]) List<String> providers,
    @Default(false) bool isReauthPasswordVisible,
    @Default(false) bool isDeleting,
    @Default(false) bool isShowDeleteConfirmation,
  }) = _Form;

  const EditProfileState._();

  @override
  String? get favoriteSector => null;

  bool get hasGoogle => maybeMap(
    form: (f) => f.providers.contains('google.com'),
    orElse: () => false,
  );

  bool get hasApple => maybeMap(
    form: (f) => f.providers.contains('apple.com'),
    orElse: () => false,
  );

  bool get showPasswordAuth =>
      maybeMap(form: (f) => !f.hasGoogle && !f.hasApple, orElse: () => false);

  bool get hasPasswordProvider => maybeMap(
    form: (f) => f.providers.contains('password'),
    orElse: () => false,
  );

  bool get hasChanges => maybeMap(
    form: (f) =>
        f.firstName != f.originalFirstName || f.email != f.originalEmail,
    orElse: () => false,
  );

  bool get canSave => maybeMap(
    form: (f) => hasChanges && !f.isSubmitting && !f.isDeleting,
    orElse: () => false,
  );
}
