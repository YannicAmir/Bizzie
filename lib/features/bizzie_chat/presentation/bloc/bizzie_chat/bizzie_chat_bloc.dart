import 'dart:async';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/utils/id_utils.dart';
import 'package:bizzie/features/bizzie_chat/domain/enums/chat_message_role.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_sse_event.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/get_messages_params.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/send_message_params.dart';
import 'package:bizzie/features/bizzie_chat/domain/usecases/get_messages_stream_usecase.dart';
import 'package:bizzie/features/bizzie_chat/domain/usecases/send_message_stream_usecase.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat/bizzie_chat_event.dart';
import 'package:bizzie/features/bizzie_chat/presentation/bloc/bizzie_chat/bizzie_chat_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('BizzieChatBloc');

@injectable
class BizzieChatBloc extends Bloc<BizzieChatEvent, BizzieChatState> {
  final GetMessagesStreamUseCase _getMessagesStream;
  final SendMessageStreamUseCase _sendMessageStream;

  StreamSubscription? _messagesSubscription;
  StreamSubscription? _sseSubscription;

  BizzieChatBloc(this._getMessagesStream, this._sendMessageStream)
      : super(const BizzieChatState.initial()) {
    on<BizzieChatEvent>(
      (event, emit) async {
        await event.map(
          sessionStarted: (e) => _onSessionStarted(
            uid: e.uid,
            ticker: e.ticker,
            companyName: e.companyName,
            sessionId: e.sessionId,
            emit: emit,
          ),
          messageSent: (e) => _onMessageSent(query: e.query, emit: emit),
          reset: (_) async => _onReset(emit),
          messagesLoaded: (e) async =>
              _onMessagesLoaded(messages: e.messages, emit: emit),
          messagesLoadFailed: (e) async =>
              _onMessagesLoadFailed(failure: e.failure, emit: emit),
          sseTokenReceived: (e) async =>
              _onSseTokenReceived(token: e.token, emit: emit),
          sseDone: (e) =>
              _onSseDone(followUps: e.followUps, source: e.source, emit: emit),
          sseFailed: (e) async => _onSseFailed(message: e.message, emit: emit),
        );
      },
      transformer: sequential(),
    );
  }

  Future<void> _onSessionStarted({
    required String uid,
    required String ticker,
    required String companyName,
    required String? sessionId,
    required Emitter<BizzieChatState> emit,
  }) async {
    final resolvedId = sessionId ?? IdUtils.generateSessionId();
    final isExisting = sessionId != null;

    _logger.info(
      'Session started: id=$resolvedId, existing=$isExisting, ticker=$ticker',
    );

    if (isExisting) {
      emit(BizzieChatState.loading(
        sessionId: resolvedId,
        uid: uid,
        ticker: ticker,
        companyName: companyName,
      ));
      await _subscribeToMessages(uid: uid, sessionId: resolvedId);
    } else {
      emit(BizzieChatState.active(
        sessionId: resolvedId,
        uid: uid,
        ticker: ticker,
        companyName: companyName,
        messages: const [],
      ));
      _logger.info('New session — deferring messages subscription to first SSE done.');
    }
  }

  Future<void> _subscribeToMessages({
    required String uid,
    required String sessionId,
  }) async {
    await _messagesSubscription?.cancel();
    final messagesStream = await _getMessagesStream(
      GetMessagesParams(uid: uid, sessionId: sessionId),
    );
    _messagesSubscription = messagesStream.listen(
      (result) => result.fold(
        (failure) => add(BizzieChatEvent.messagesLoadFailed(failure)),
        (messages) => add(BizzieChatEvent.messagesLoaded(messages)),
      ),
      onError: (e) =>
          add(BizzieChatEvent.messagesLoadFailed(Failure.server(e.toString()))),
    );
  }

  void _onMessagesLoaded({
    required List<ChatMessage> messages,
    required Emitter<BizzieChatState> emit,
  }) {
    state.map(
      initial: (_) =>
          _logger.info('messagesLoaded in initial state — ignoring'),
      loading: (s) => emit(BizzieChatState.active(
        sessionId: s.sessionId,
        uid: s.uid,
        ticker: s.ticker,
        companyName: s.companyName,
        messages: messages,
      )),
      active: (s) => emit(s.copyWith(messages: messages)),
      failure: (_) =>
          _logger.info('messagesLoaded in failure state — ignoring'),
    );
  }

  void _onMessagesLoadFailed({
    required Failure failure,
    required Emitter<BizzieChatState> emit,
  }) {
    _logger.severe('Messages stream failure', failure);
    state.mapOrNull(
      loading: (_) => emit(BizzieChatState.failure(failure)),
      active: (_) => _logger.info(
        'messagesLoadFailed in active state — keeping active; '
        'failure: ${failure.errorMessage}',
      ),
    );
  }

  Future<void> _onMessageSent({
    required String query,
    required Emitter<BizzieChatState> emit,
  }) async {
    final activeState = state.mapOrNull(active: (s) => s);
    if (activeState == null || activeState.isStreaming) {
      _logger.info('messageSent ignored: not active or already streaming');
      return;
    }

    _logger.info('Sending message in session=${activeState.sessionId}');

    final optimisticMessage = ChatMessage(
      id: 'pending_${DateTime.now().millisecondsSinceEpoch}',
      role: ChatMessageRole.user,
      content: query,
      createdAt: DateTime.now(),
    );
    emit(activeState.copyWith(
      messages: [...activeState.messages, optimisticMessage],
      isStreaming: true,
      streamingContent: null,
      followUps: const [],
      sseError: null,
    ));

    await _sseSubscription?.cancel();

    final params = SendMessageParams(
      idempotencyKey: IdUtils.generateSessionId(),
      query: query,
      companyTicker: activeState.ticker,
      companyName: activeState.companyName,
      sessionId: activeState.sessionId,
    );

    final sseStream = await _sendMessageStream(params);
    _sseSubscription = sseStream.listen(
      (result) => result.fold(
        (failure) => add(BizzieChatEvent.sseFailed(failure.errorMessage)),
        (sseEvent) => sseEvent.map(
          token: (e) => add(BizzieChatEvent.sseTokenReceived(e.token)),
          done: (e) => add(
            BizzieChatEvent.sseDone(followUps: e.followUps, source: e.source),
          ),
          error: (e) => add(BizzieChatEvent.sseFailed(e.message)),
        ),
      ),
      onError: (e) => add(BizzieChatEvent.sseFailed(e.toString())),
    );
  }

  void _onSseTokenReceived({
    required String token,
    required Emitter<BizzieChatState> emit,
  }) {
    final activeState = state.mapOrNull(active: (s) => s);
    if (activeState == null) return;
    emit(activeState.copyWith(
      streamingContent: (activeState.streamingContent ?? '') + token,
    ));
  }

  Future<void> _onSseDone({
    required List<String> followUps,
    required String? source,
    required Emitter<BizzieChatState> emit,
  }) async {
    _logger.info('SSE stream done. followUps=${followUps.length}');
    _sseSubscription?.cancel();
    _sseSubscription = null;
    final activeState = state.mapOrNull(active: (s) => s);
    if (activeState == null) return;

    if (activeState.streamingContent == null) {
      _logger.warning('sseDone fired with no streaming content — backend returned empty response');
      emit(activeState.copyWith(
        isStreaming: false,
        sseError: 'Something went wrong generating a response. Please try again.',
      ));
      return;
    }

    emit(activeState.copyWith(
      isStreaming: false,
      followUps: followUps,
    ));

    if (_messagesSubscription == null) {
      _logger.info('First SSE done — subscribing to messages stream.');
      await _subscribeToMessages(
        uid: activeState.uid,
        sessionId: activeState.sessionId,
      );
    }
  }

  void _onSseFailed({
    required String message,
    required Emitter<BizzieChatState> emit,
  }) {
    _logger.severe('SSE stream error: $message');
    _sseSubscription?.cancel();
    _sseSubscription = null;
    final activeState = state.mapOrNull(active: (s) => s);
    if (activeState == null) return;
    emit(activeState.copyWith(
      isStreaming: false,
      streamingContent: null,
      sseError: message,
    ));
  }

  void _onReset(Emitter<BizzieChatState> emit) {
    _messagesSubscription?.cancel();
    _messagesSubscription = null;
    _sseSubscription?.cancel();
    _sseSubscription = null;
    emit(const BizzieChatState.initial());
  }

  @override
  Future<void> close() async {
    await _messagesSubscription?.cancel();
    await _sseSubscription?.cancel();
    return super.close();
  }
}
