import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/error/function_app_error_mapper.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_request_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/interfaces/i_bizzie_chat_remote_datasource.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_bizzie_chat_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_response.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_session.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_sse_event.dart';

final _logger = BizzieLogger('BizzieChatRepositoryImpl');

@LazySingleton(as: IBizzieChatRepository)
class BizzieChatRepositoryImpl implements IBizzieChatRepository {
  final IBizzieChatRemoteDataSource _remoteDataSource;

  BizzieChatRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ChatResponse>> sendMessage({
    required String idempotencyKey,
    required String query,
    required String companyTicker,
    required String companyName,
    required String sessionId,
  }) async {
    try {
      final dto = await _remoteDataSource.sendMessage(
        BizzieChatRequestDto(
          idempotencyKey: idempotencyKey,
          query: query,
          companyTicker: companyTicker,
          companyName: companyName,
          sessionId: sessionId,
        ),
      );
      return Right(dto.toDomain());
    } on DioException catch (e, s) {
      return Left(FunctionAppErrorMapper.map(e, s, 'sendMessage'));
    } catch (e, s) {
      _logger.severe('sendMessage unexpected error', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, ChatSseEvent>> sendMessageStream({
    required String idempotencyKey,
    required String query,
    required String companyTicker,
    required String companyName,
    required String sessionId,
  }) async* {
    try {
      final streamRequest = BizzieChatRequestDto(
        idempotencyKey: idempotencyKey,
        query: query,
        companyTicker: companyTicker,
        companyName: companyName,
        sessionId: sessionId,
        stream: true,
      );

      await for (final eventDto
          in _remoteDataSource.sendMessageStream(streamRequest)) {
        final event = eventDto.toDomain();

        if (event is ChatErrorEvent) {
          _logger.warning('sendMessageStream: SSE error event — ${event.message}');
          yield Left(Failure.server(event.message));
          return;
        }

        yield Right(event);
      }
    } on DioException catch (e, s) {
      yield Left(FunctionAppErrorMapper.map(e, s, 'sendMessageStream'));
    } catch (e, s) {
      _logger.severe('sendMessageStream unexpected error', e, s);
      yield Left(Failure.server(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ChatSession>>> getSessionsStream(String uid) {
    return _remoteDataSource
        .getSessionsStream(uid)
        .map<Either<Failure, List<ChatSession>>>(
          (dtos) => Right(dtos.map((d) => d.toDomain()).toList()),
        )
        .onErrorReturnWith((e, s) {
          _logger.severe('getSessionsStream error for uid=$uid', e, s);
          return Left(Failure.server(e.toString()));
        });
  }

  @override
  Stream<Either<Failure, List<ChatMessage>>> getMessagesStream(
    String uid,
    String sessionId,
  ) {
    return _remoteDataSource
        .getMessagesStream(uid, sessionId)
        .map<Either<Failure, List<ChatMessage>>>(
          (dtos) => Right(dtos.map((d) => d.toDomain()).toList()),
        )
        .onErrorReturnWith((e, s) {
          _logger.severe(
            'getMessagesStream error for uid=$uid sessionId=$sessionId',
            e,
            s,
          );
          return Left(Failure.server(e.toString()));
        });
  }

}
