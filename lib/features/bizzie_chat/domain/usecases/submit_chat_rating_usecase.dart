import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_chat_rating_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_rating.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubmitChatRatingUseCase
    implements UseCase<Either<Failure, void>, ChatRating> {
  final IChatRatingRepository _repository;

  SubmitChatRatingUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(ChatRating params) {
    return _repository.submitRating(params);
  }
}
