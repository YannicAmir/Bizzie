// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedbackDto _$FeedbackDtoFromJson(Map<String, dynamic> json) => _FeedbackDto(
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  message: json['message'] as String,
  timestamp: const TimestampConverter().fromJson(json['timestamp']),
  userEmail: json['userEmail'] as String?,
  fcmToken: json['fcmToken'] as String?,
  isSubscribed: json['isSubscribed'] as bool,
  notificationsEnabled: json['notificationsEnabled'] as bool,
);

Map<String, dynamic> _$FeedbackDtoToJson(_FeedbackDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'message': instance.message,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
      'userEmail': instance.userEmail,
      'fcmToken': instance.fcmToken,
      'isSubscribed': instance.isSubscribed,
      'notificationsEnabled': instance.notificationsEnabled,
    };
