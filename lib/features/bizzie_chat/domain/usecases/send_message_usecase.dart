import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_bizzie_chat_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_response.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/send_message_params.dart';

@injectable
class SendMessageUseCase
    implements UseCase<Either<Failure, ChatResponse>, SendMessageParams> {
  final IBizzieChatRepository _repository;

  SendMessageUseCase(this._repository);

  @override
  Future<Either<Failure, ChatResponse>> call(SendMessageParams params) {
    return _repository.sendMessage(
      idempotencyKey: params.idempotencyKey,
      query: params.query,
      companyTicker: params.companyTicker,
      companyName: params.companyName,
      sessionId: params.sessionId,
    );
  }
}
