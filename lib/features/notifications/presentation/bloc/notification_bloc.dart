import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/domain/models/notification_intent.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/usecases/get_fcm_token_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/listen_to_messages_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/listen_to_notification_interactions_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/request_notification_permission_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/setup_notification_interactions_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/clear_cached_token_usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/check_notification_permission_usecase.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_error_type.dart';
import 'package:bizzie/features/notifications/presentation/analytics/notification_tracker.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/parse_notification_payload_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'notification_event.dart';
import 'notification_state.dart';
import 'notification_status.dart';

export 'notification_event.dart';
export 'notification_state.dart';
export 'notification_status.dart';

final _logger = BizzieLogger('NotificationBloc');

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final RequestNotificationPermissionUseCase _requestPermission;
  final GetFcmTokenUseCase _getFcmToken;
  final ListenToMessagesUseCase _listenToMessages;
  final ClearCachedTokenUseCase _clearCachedToken;
  final NotificationTracker _tracker;
  final ParseNotificationPayloadUseCase _parseNotificationPayload;
  final CheckNotificationPermissionUseCase _checkNotificationPermission;
  final SetupNotificationInteractionsUseCase _setupInteractions;
  final ListenToNotificationInteractionsUseCase _listenToInteractions;

  NotificationBloc(
    this._requestPermission,
    this._getFcmToken,
    this._listenToMessages,
    this._clearCachedToken,
    this._tracker,
    this._parseNotificationPayload,
    this._checkNotificationPermission,
    this._setupInteractions,
    this._listenToInteractions,
  ) : super(const NotificationState()) {
    on<NotificationEvent>(
      (event, emit) => event.maybeMap<Future<void>>(
        setupRequested: (e) => _onSetupRequested(e, emit),
        syncRequested: (e) => _onSyncRequested(e, emit),
        reset: (e) => _onReset(e, emit),
        orElse: () async {},
      ),
      transformer: _restartableSession(),
    );
    on<NotificationInteractionReceived>(
      _onInteractionReceived,
      transformer: restartable(),
    );
    on<NotificationAppReadyForNavigation>(_onAppReadyForNavigation);
  }

  EventTransformer<NotificationEvent> _restartableSession() {
    return (events, mapper) =>
        restartable<NotificationEvent>()(events.where(_isSessionEvent), mapper);
  }

  bool _isSessionEvent(NotificationEvent event) =>
      event is NotificationSetupRequested ||
      event is NotificationSyncRequested ||
      event is NotificationReset;

  Future<void> _onReset(
    NotificationReset event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await _clearCachedToken(NoParams());
    result.fold(
      (failure) => _logger.warning(
        'Failed to clear cached token: ${failure.errorMessage}',
      ),
      (_) => null,
    );
    await _tracker.setUserNotificationsEnabled(false);
    emit(const NotificationState());
  }

  Future<void> _onSetupRequested(
    NotificationSetupRequested event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: const NotificationStatus.loading()));

    final permissionResult = await _requestPermission(NoParams());

    await permissionResult.fold(
      (failure) => _emitFailure(
        NotificationErrorType.permissionException,
        failure,
        emit,
      ),
      (_) => _syncTokenAndListen(emit),
    );
  }

  Future<void> _onSyncRequested(
    NotificationSyncRequested event,
    Emitter<NotificationState> emit,
  ) async {
    final permissionResult = await _checkNotificationPermission(NoParams());

    await permissionResult.fold(
      (failure) => _emitFailure(
        NotificationErrorType.permissionException,
        failure,
        emit,
      ),
      (isGranted) async {
        if (!isGranted) {
          _logger.info('Notification permission not granted; skipping sync');
          return;
        }
        await _syncTokenAndListen(emit);
      },
    );
  }

  Future<void> _syncTokenAndListen(Emitter<NotificationState> emit) async {
    if (emit.isDone) return;
    final tokenResult = await _getFcmToken(NoParams());
    if (emit.isDone) return;

    await tokenResult.fold(
      (failure) =>
          _emitFailure(NotificationErrorType.tokenSyncFailure, failure, emit),
      (fcmToken) async {
        await _tracker.setUserNotificationsEnabled(true);
        emit(state.copyWith(status: NotificationStatus.success(fcmToken)));
        await _listenToNotifications(emit);
      },
    );
  }

  Future<void> _listenToNotifications(Emitter<NotificationState> emit) async {
    final setupResult = await _setupInteractions(NoParams());
    setupResult.fold(
      (failure) => _logger.warning(
        'Failed to set up notification interactions: ${failure.errorMessage}',
      ),
      (_) => null,
    );

    await Future.wait([
      emit.onEach<NotificationMessage>(
        _listenToMessages(NoParams()),
        onData: (message) => emit(
          state.copyWith(status: NotificationStatus.messageReceived(message)),
        ),
        onError: (error, stackTrace) => _logger.severe(
          'Notification message stream error',
          error,
          stackTrace,
        ),
      ),
      emit.onEach<Map<String, dynamic>>(
        _listenToInteractions(NoParams()),
        onData: (payload) => _handleInteraction(payload, emit),
        onError: (error, stackTrace) => _logger.severe(
          'Notification interaction stream error',
          error,
          stackTrace,
        ),
      ),
    ]);
  }

  void _onInteractionReceived(
    NotificationInteractionReceived event,
    Emitter<NotificationState> emit,
  ) {
    _handleInteraction(event.payload, emit);
  }

  void _handleInteraction(
    Map<String, dynamic> payload,
    Emitter<NotificationState> emit,
  ) {
    final intent = _parseNotificationPayload(payload);
    if (intent == null) {
      _logger.warning('Failed to parse intent from payload: $payload');
      return;
    }

    if (state.isAppReady) {
      _logger.info('App is ready, emitting navigation request for $intent');
      _emitNavigation(intent, emit);
    } else {
      _logger.info('App not ready, buffering intent: $intent');
      emit(state.copyWith(pendingIntent: intent));
    }
  }

  void _onAppReadyForNavigation(
    NotificationAppReadyForNavigation event,
    Emitter<NotificationState> emit,
  ) {
    _logger.info('App ready for navigation signal received');

    final pendingIntent = state.pendingIntent;
    if (pendingIntent != null) {
      _logger.info('Processing buffered intent: $pendingIntent');
      emit(state.copyWith(isAppReady: true, pendingIntent: null));
      _emitNavigation(pendingIntent, emit);
    } else {
      _logger.info('No buffered intent, setting isAppReady: true');
      emit(state.copyWith(isAppReady: true));
    }
  }

  void _emitNavigation(
    NotificationIntent intent,
    Emitter<NotificationState> emit,
  ) {
    emit(
      state.copyWith(
        status: NotificationStatus.navigationRequested(
          intent,
          DateTime.now().millisecondsSinceEpoch,
        ),
      ),
    );
    // Reset status to initial to avoid re-triggering
    emit(state.copyWith(status: const NotificationStatus.initial()));
  }

  Future<void> _emitFailure(
    NotificationErrorType type,
    Failure failure,
    Emitter<NotificationState> emit,
  ) async {
    await _tracker.logError(type: type, message: failure.errorMessage);
    emit(
      state.copyWith(status: NotificationStatus.failure(failure.errorMessage)),
    );
  }
}
