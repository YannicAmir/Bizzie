import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/profile/domain/models/profile_display_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(
    ProfileDisplayData data, {
    @Default(false) bool shouldNavigateToSettings,
    @Default(false) bool shouldShowPaywall,
  }) = _Loaded;
  const factory ProfileState.failure(Failure failure) = _Failure;
}
