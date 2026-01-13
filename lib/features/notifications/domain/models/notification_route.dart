import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_route.freezed.dart';

@freezed
abstract class NotificationRoute with _$NotificationRoute {
  const factory NotificationRoute(String path, {Object? extra}) =
      _NotificationRoute;
}
