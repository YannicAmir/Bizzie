part of 'app_status_bloc.dart';

@freezed
class AppStatusState with _$AppStatusState {
  const factory AppStatusState.initial() = _Initial;
  const factory AppStatusState.checked(
    AppStatus status, {
    @Default(false) bool isRefreshing,
  }) = _Checked;
}
