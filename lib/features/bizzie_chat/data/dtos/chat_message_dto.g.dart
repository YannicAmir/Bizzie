// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessageDto _$ChatMessageDtoFromJson(Map<String, dynamic> json) =>
    _ChatMessageDto(
      id: json['id'] as String,
      role: json['role'] as String,
      content: json['content'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      followUps: (json['followUps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      source: json['source'] as String?,
      routePath: json['routePath'] as String?,
    );

Map<String, dynamic> _$ChatMessageDtoToJson(_ChatMessageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'content': instance.content,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'followUps': instance.followUps,
      'source': instance.source,
      'routePath': instance.routePath,
    };
