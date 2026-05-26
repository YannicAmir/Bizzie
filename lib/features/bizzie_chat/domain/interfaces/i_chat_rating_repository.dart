import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_rating.dart';
import 'package:dartz/dartz.dart';

abstract class IChatRatingRepository {
  Future<Either<Failure, void>> submitRating(ChatRating rating);
}
