// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserActivityDto _$UserActivityDtoFromJson(Map<String, dynamic> json) =>
    _UserActivityDto(
      lastViewedReports: _$JsonConverterFromJson<Object, DateTime>(
        json['lastViewedReports'],
        const TimestampConverter().fromJson,
      ),
    );

Map<String, dynamic> _$UserActivityDtoToJson(_UserActivityDto instance) =>
    <String, dynamic>{
      'lastViewedReports': _$JsonConverterToJson<Object, DateTime>(
        instance.lastViewedReports,
        const TimestampConverter().toJson,
      ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
