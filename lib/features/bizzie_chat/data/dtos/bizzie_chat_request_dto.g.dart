// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bizzie_chat_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BizzieChatRequestDto _$BizzieChatRequestDtoFromJson(
  Map<String, dynamic> json,
) => _BizzieChatRequestDto(
  idempotencyKey: json['idempotencyKey'] as String,
  query: json['query'] as String,
  companyTicker: json['companyTicker'] as String,
  companyName: json['companyName'] as String,
  sessionId: json['sessionId'] as String,
  stream: json['stream'] as bool? ?? false,
);

Map<String, dynamic> _$BizzieChatRequestDtoToJson(
  _BizzieChatRequestDto instance,
) => <String, dynamic>{
  'idempotencyKey': instance.idempotencyKey,
  'query': instance.query,
  'companyTicker': instance.companyTicker,
  'companyName': instance.companyName,
  'sessionId': instance.sessionId,
  'stream': instance.stream,
};
