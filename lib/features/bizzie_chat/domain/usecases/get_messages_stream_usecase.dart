import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_bizzie_chat_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/get_messages_params.dart';

@lazySingleton
class GetMessagesStreamUseCase
    implements
        UseCase<Stream<Either<Failure, List<ChatMessage>>>, GetMessagesParams> {
  final IBizzieChatRepository _repository;

  GetMessagesStreamUseCase(this._repository);

  @override
  Future<Stream<Either<Failure, List<ChatMessage>>>> call(
    GetMessagesParams params,
  ) async {
    return _repository.getMessagesStream(params.uid, params.sessionId);
  }
}
