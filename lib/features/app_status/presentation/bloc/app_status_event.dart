part of 'app_status_bloc.dart';

@freezed
class AppStatusEvent with _$AppStatusEvent {
  const factory AppStatusEvent.started() = _Started;
  const factory AppStatusEvent.refreshed() = _Refreshed;
  const factory AppStatusEvent.statusChanged(AppStatus status) = _StatusChanged;
}
