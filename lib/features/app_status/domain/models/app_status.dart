import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_status.freezed.dart';

@freezed
class AppStatus with _$AppStatus {
  const factory AppStatus.normal() = _Normal;
  const factory AppStatus.forceUpgrade({
    required String minVersion,
    required String storeUrl,
  }) = _ForceUpgrade;

  const factory AppStatus.noInternet() = _NoInternet;
  const factory AppStatus.maintenance() = _Maintenance;
}
