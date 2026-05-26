// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bizzie_chat_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BizzieChatResponseDto _$BizzieChatResponseDtoFromJson(
  Map<String, dynamic> json,
) => _BizzieChatResponseDto(
  message: json['message'] as String,
  followUps: (json['followUps'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  source: json['source'] as String?,
  metadata: BizzieChatResponseMetadataDto.fromJson(
    json['metadata'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$BizzieChatResponseDtoToJson(
  _BizzieChatResponseDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'followUps': instance.followUps,
  'source': instance.source,
  'metadata': instance.metadata,
};

_BizzieChatResponseMetadataDto _$BizzieChatResponseMetadataDtoFromJson(
  Map<String, dynamic> json,
) => _BizzieChatResponseMetadataDto(
  sessionId: json['sessionId'] as String,
  routePath: json['routePath'] as String?,
);

Map<String, dynamic> _$BizzieChatResponseMetadataDtoToJson(
  _BizzieChatResponseMetadataDto instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'routePath': instance.routePath,
};
