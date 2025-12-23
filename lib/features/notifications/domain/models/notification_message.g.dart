// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationMessage _$NotificationMessageFromJson(Map<String, dynamic> json) =>
    _NotificationMessage(
      title: json['title'] as String,
      body: json['body'] as String,
      data: json['data'] as Map<String, dynamic>?,
      sentTime: json['sentTime'] == null
          ? null
          : DateTime.parse(json['sentTime'] as String),
    );

Map<String, dynamic> _$NotificationMessageToJson(
  _NotificationMessage instance,
) => <String, dynamic>{
  'title': instance.title,
  'body': instance.body,
  'data': instance.data,
  'sentTime': instance.sentTime?.toIso8601String(),
};
