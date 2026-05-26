import 'package:bizzie/features/bizzie_chat/domain/enums/chat_message_role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required ChatMessageRole role,
    required String content,
    required DateTime createdAt,
    List<String>? followUps,
    String? source,
    String? routePath,
  }) = _ChatMessage;
}
