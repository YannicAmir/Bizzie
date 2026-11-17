import 'package:bizzie/features/app_status/domain/models/app_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_status_event.freezed.dart';

@freezed
sealed class AppStatusEvent with _$AppStatusEvent {
  const factory AppStatusEvent.started() = AppStatusStarted;
  const factory AppStatusEvent.refreshed() = AppStatusRefreshed;
  const factory AppStatusEvent.statusChanged(
    AppStatus status, {
    @Default(false) bool isManualRefresh,
  }) = AppStatusStatusChanged;
}
