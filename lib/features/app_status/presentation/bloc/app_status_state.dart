import 'package:bizzie/features/app_status/domain/models/app_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_status_state.freezed.dart';

@freezed
abstract class AppStatusState with _$AppStatusState {
  const factory AppStatusState.initial() = _Initial;
  const factory AppStatusState.checked(
    AppStatus status, {
    @Default(false) bool isRefreshing,
  }) = _Checked;
}
