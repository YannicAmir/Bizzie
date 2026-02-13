// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserActivityDto _$UserActivityDtoFromJson(Map<String, dynamic> json) =>
    _UserActivityDto(
      lastViewedReports: const TimestampConverter().fromJson(
        json['lastViewedReports'],
      ),
    );

Map<String, dynamic> _$UserActivityDtoToJson(_UserActivityDto instance) =>
    <String, dynamic>{
      'lastViewedReports': _$JsonConverterToJson<Object?, DateTime>(
        instance.lastViewedReports,
        const TimestampConverter().toJson,
      ),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
