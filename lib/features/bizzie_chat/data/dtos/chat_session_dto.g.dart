// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatSessionDto _$ChatSessionDtoFromJson(Map<String, dynamic> json) =>
    _ChatSessionDto(
      id: json['id'] as String,
      title: json['title'] as String,
      ticker: json['ticker'] as String,
      companyName: json['companyName'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      messageCount: (json['messageCount'] as num).toInt(),
    );

Map<String, dynamic> _$ChatSessionDtoToJson(_ChatSessionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'ticker': instance.ticker,
      'companyName': instance.companyName,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'messageCount': instance.messageCount,
    };
