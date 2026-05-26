import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_bizzie_chat_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_session.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/get_sessions_params.dart';

@lazySingleton
class GetSessionsStreamUseCase
    implements UseCase<Stream<Either<Failure, List<ChatSession>>>, GetSessionsParams> {
  final IBizzieChatRepository _repository;

  GetSessionsStreamUseCase(this._repository);

  @override
  Future<Stream<Either<Failure, List<ChatSession>>>> call(
    GetSessionsParams params,
  ) async {
    return _repository.getSessionsStream(params);
  }
}
