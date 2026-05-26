import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_response.freezed.dart';

@freezed
abstract class ChatResponse with _$ChatResponse {
  const factory ChatResponse({
    required String message,
    required List<String> followUps,
    String? source,
    required String sessionId,
    String? routePath,
  }) = _ChatResponse;
}
