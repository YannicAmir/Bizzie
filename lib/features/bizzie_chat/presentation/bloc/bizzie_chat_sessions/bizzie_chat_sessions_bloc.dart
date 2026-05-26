import 'dart:async';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/get_sessions_params.dart';
import 'package:bizzie/features/bizzie_chat/domain/usecases/get_sessions_stream_usecase.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat_sessions/bizzie_chat_sessions_event.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat_sessions/bizzie_chat_sessions_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('BizzieChatSessionsBloc');

@injectable
class BizzieChatSessionsBloc
    extends Bloc<BizzieChatSessionsEvent, BizzieChatSessionsState> {
  final GetSessionsStreamUseCase _getSessionsStream;

  BizzieChatSessionsBloc(this._getSessionsStream)
      : super(const BizzieChatSessionsState.initial()) {
    on<BizzieChatSessionsEvent>(
      (event, emit) async {
        await event.map(
          started: (e) => _onStarted(uid: e.uid, ticker: e.ticker, emit: emit),
          reset: (_) async => _onReset(emit),
        );
      },
      transformer: restartable(),
    );
  }

  Future<void> _onStarted({
    required String uid,
    required String ticker,
    required Emitter<BizzieChatSessionsState> emit,
  }) async {
    if (uid.isEmpty) {
      _logger.info('BizzieChatSessionsBloc started with empty uid — skipping.');
      return;
    }
    emit(const BizzieChatSessionsState.loading());
    _logger.info(
      'Subscribing to sessions stream for uid=$uid, ticker=$ticker',
    );
    final stream = await _getSessionsStream(
      GetSessionsParams(uid: uid, ticker: ticker),
    );
    await emit.forEach(
      stream,
      onData: (result) => result.fold(
        (failure) {
          _logger.info('Sessions stream failure: ${failure.errorMessage}');
          return BizzieChatSessionsState.failure(failure);
        },
        (sessions) {
          _logger.info(
            'Sessions updated: ${sessions.length} sessions for $ticker',
          );
          return BizzieChatSessionsState.loaded(
            sessions: sessions,
            ticker: ticker,
          );
        },
      ),
      onError: (e, _) {
        _logger.info('Sessions stream error: $e');
        return BizzieChatSessionsState.failure(Failure.server(e.toString()));
      },
    );
  }

  void _onReset(Emitter<BizzieChatSessionsState> emit) {
    _logger.info('BizzieChatSessionsBloc reset');
    emit(const BizzieChatSessionsState.initial());
  }
}
