import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/settings/domain/models/settings_display_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _Initial;
  const factory SettingsState.loading() = _Loading;
  const factory SettingsState.loaded(SettingsDisplayData data) = _Loaded;
  const factory SettingsState.failure(Failure failure) = _Failure;
}
