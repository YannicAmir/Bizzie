import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:bizzie/features/bizzie_chat/domain/enums/chat_message_role.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';

part 'chat_message_dto.freezed.dart';
part 'chat_message_dto.g.dart';

@freezed
abstract class ChatMessageDto with _$ChatMessageDto {
  const ChatMessageDto._();

  const factory ChatMessageDto({
    required String id,
    required String role,
    required String content,
    @TimestampConverter() required DateTime createdAt,
    List<String>? followUps,
    String? source,
    String? routePath,
  }) = _ChatMessageDto;

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDtoFromJson(json);

  ChatMessage toDomain() => ChatMessage(
        id: id,
        role: ChatMessageRole.fromString(role),
        content: content,
        createdAt: createdAt,
        followUps: followUps,
        source: source,
        routePath: routePath,
      );
}
