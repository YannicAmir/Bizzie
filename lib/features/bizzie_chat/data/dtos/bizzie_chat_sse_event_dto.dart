import 'dart:convert';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_sse_event.dart';


sealed class BizzieChatSseEventDto {
  const BizzieChatSseEventDto();

  factory BizzieChatSseEventDto.fromRawLine(String dataLine) {
    final json = jsonDecode(dataLine) as Map<String, dynamic>;
    return switch (json['type'] as String?) {
      'token' => BizzieChatTokenEventDto(
          token: json['token'] as String? ?? '',
        ),
      'done' => BizzieChatDoneEventDto(
          followUps: (json['follow_ups'] as List<dynamic>?)
                  ?.whereType<String>()
                  .toList() ??
              [],
          source: json['source'] as String?,
          routePath: json['route_path'] as String?,
        ),
      'error' => BizzieChatErrorEventDto(
          message: json['message'] as String? ?? 'Unknown error',
        ),
      final unknown => BizzieChatErrorEventDto(
          message: 'Unrecognised SSE event type: $unknown',
        ),
    };
  }

  ChatSseEvent toDomain();
}

final class BizzieChatTokenEventDto extends BizzieChatSseEventDto {
  final String token;
  const BizzieChatTokenEventDto({required this.token});

  @override
  ChatSseEvent toDomain() => ChatSseEvent.token(token: token);
}

final class BizzieChatDoneEventDto extends BizzieChatSseEventDto {
  final List<String> followUps;
  final String? source;
  final String? routePath;

  const BizzieChatDoneEventDto({
    required this.followUps,
    this.source,
    this.routePath,
  });

  @override
  ChatSseEvent toDomain() => ChatSseEvent.done(
        followUps: followUps,
        source: source,
        routePath: routePath,
      );
}

final class BizzieChatErrorEventDto extends BizzieChatSseEventDto {
  final String message;
  const BizzieChatErrorEventDto({required this.message});

  @override
  ChatSseEvent toDomain() => ChatSseEvent.error(message: message);
}
