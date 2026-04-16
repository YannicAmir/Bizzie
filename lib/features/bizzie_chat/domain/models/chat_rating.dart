import 'package:bizzie/features/bizzie_chat/domain/enums/rating_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_rating.freezed.dart';

@freezed
abstract class ChatRating with _$ChatRating {
  const factory ChatRating({
    required RatingType rating,
    required String question,
    required String aiResponse,
    required DateTime time,
    required String companyName,
    required String companyTicker,
  }) = _ChatRating;
}
