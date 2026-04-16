import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/chat_rating_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/interfaces/i_chat_rating_remote_datasource.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_chat_rating_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_rating.dart';

final _logger = BizzieLogger('ChatRatingRepositoryImpl');

@LazySingleton(as: IChatRatingRepository)
class ChatRatingRepositoryImpl implements IChatRatingRepository {
  final IChatRatingRemoteDataSource _remoteDataSource;

  ChatRatingRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> submitRating(ChatRating rating) async {
    try {
      await _remoteDataSource.submitRating(ChatRatingDto.fromDomain(rating));
      return const Right(null);
    } catch (e, s) {
      _logger.severe('submitRating unexpected error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }
}
