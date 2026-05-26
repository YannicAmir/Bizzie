import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_response.dart';

part 'bizzie_chat_response_dto.freezed.dart';
part 'bizzie_chat_response_dto.g.dart';

@freezed
abstract class BizzieChatResponseDto with _$BizzieChatResponseDto {
  const BizzieChatResponseDto._();

  const factory BizzieChatResponseDto({
    required String message,
    required List<String> followUps,
    String? source,
    required BizzieChatResponseMetadataDto metadata,
  }) = _BizzieChatResponseDto;

  factory BizzieChatResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BizzieChatResponseDtoFromJson(json);

  ChatResponse toDomain() => ChatResponse(
        message: message,
        followUps: followUps,
        source: source,
        sessionId: metadata.sessionId,
        routePath: metadata.routePath,
      );
}

@freezed
abstract class BizzieChatResponseMetadataDto
    with _$BizzieChatResponseMetadataDto {
  const BizzieChatResponseMetadataDto._();

  const factory BizzieChatResponseMetadataDto({
    required String sessionId,
    String? routePath,
  }) = _BizzieChatResponseMetadataDto;

  factory BizzieChatResponseMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$BizzieChatResponseMetadataDtoFromJson(json);
}
