import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_session.dart';

part 'chat_session_dto.freezed.dart';
part 'chat_session_dto.g.dart';

@freezed
abstract class ChatSessionDto with _$ChatSessionDto {
  const ChatSessionDto._();

  const factory ChatSessionDto({
    required String id,
    required String title,
    required String ticker,
    required String companyName,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required int messageCount,
  }) = _ChatSessionDto;

  factory ChatSessionDto.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionDtoFromJson(json);

  ChatSession toDomain() => ChatSession(
        id: id,
        title: title,
        ticker: ticker,
        companyName: companyName,
        createdAt: createdAt,
        updatedAt: updatedAt,
        messageCount: messageCount,
      );
}
