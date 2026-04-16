// ignore_for_file: invalid_annotation_target
import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:bizzie/features/bizzie_chat/domain/enums/rating_type.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_rating.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_rating_dto.freezed.dart';
part 'chat_rating_dto.g.dart';

@freezed
abstract class ChatRatingDto with _$ChatRatingDto {
  const ChatRatingDto._();

  const factory ChatRatingDto({
    required String rating,
    required String question,
    @JsonKey(name: 'ai_response') required String aiResponse,
    @TimestampConverter() required DateTime time,
    @JsonKey(name: 'company_name') required String companyName,
    @JsonKey(name: 'company_ticker') required String companyTicker,
  }) = _ChatRatingDto;

  factory ChatRatingDto.fromJson(Map<String, dynamic> json) =>
      _$ChatRatingDtoFromJson(json);

  factory ChatRatingDto.fromDomain(ChatRating model) => ChatRatingDto(
        rating: model.rating.name,
        question: model.question,
        aiResponse: model.aiResponse,
        time: model.time,
        companyName: model.companyName,
        companyTicker: model.companyTicker,
      );

  ChatRating toDomain() => ChatRating(
        rating: RatingType.fromString(rating),
        question: question,
        aiResponse: aiResponse,
        time: time,
        companyName: companyName,
        companyTicker: companyTicker,
      );
}
