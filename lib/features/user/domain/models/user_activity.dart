import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_activity.freezed.dart';

@freezed
abstract class UserActivity with _$UserActivity {
  const factory UserActivity({required DateTime? lastViewedReports}) =
      _UserActivity;

  factory UserActivity.initial() => const UserActivity(lastViewedReports: null);
}
