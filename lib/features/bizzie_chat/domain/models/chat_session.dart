import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_session.freezed.dart';

@freezed
abstract class ChatSession with _$ChatSession {
  const factory ChatSession({
    required String id,
    required String title,
    required String ticker,
    required String companyName,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int messageCount,
  }) = _ChatSession;
}
