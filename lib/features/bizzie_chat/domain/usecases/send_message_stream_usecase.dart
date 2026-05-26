import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_bizzie_chat_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_sse_event.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/send_message_params.dart';

@injectable
class SendMessageStreamUseCase
    implements
        UseCase<Stream<Either<Failure, ChatSseEvent>>, SendMessageParams> {
  final IBizzieChatRepository _repository;

  SendMessageStreamUseCase(this._repository);

  @override
  Future<Stream<Either<Failure, ChatSseEvent>>> call(
    SendMessageParams params,
  ) async {
    return _repository.sendMessageStream(
      idempotencyKey: params.idempotencyKey,
      query: params.query,
      companyTicker: params.companyTicker,
      companyName: params.companyName,
      sessionId: params.sessionId,
    );
  }
}
