// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_event_status_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WatchlistEventStatusDto _$WatchlistEventStatusDtoFromJson(
  Map<String, dynamic> json,
) => _WatchlistEventStatusDto(
  badgeText: json['badgeText'] as String,
  badgeType: json['badgeType'] as String,
  eventDate: DateTime.parse(json['eventDate'] as String),
  lastUpdated: DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$WatchlistEventStatusDtoToJson(
  _WatchlistEventStatusDto instance,
) => <String, dynamic>{
  'badgeText': instance.badgeText,
  'badgeType': instance.badgeType,
  'eventDate': instance.eventDate.toIso8601String(),
  'lastUpdated': instance.lastUpdated.toIso8601String(),
};
