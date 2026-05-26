import 'package:bizzie/features/bizzie_chat/data/dtos/chat_rating_dto.dart';

abstract class IChatRatingRemoteDataSource {
  Future<void> submitRating(ChatRatingDto dto);
}
