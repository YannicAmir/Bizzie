import 'package:bizzie/features/user/domain/models/user_activity.dart';

import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_activity_dto.freezed.dart';
part 'user_activity_dto.g.dart';

@freezed
abstract class UserActivityDto with _$UserActivityDto {
  const UserActivityDto._();
  const factory UserActivityDto({
    @TimestampConverter() DateTime? lastViewedReports,
  }) = _UserActivityDto;

  factory UserActivityDto.fromJson(Map<String, dynamic> json) =>
      _$UserActivityDtoFromJson(json);

  UserActivity toDomain() => UserActivity(lastViewedReports: lastViewedReports);
}
