import 'dart:async';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/usecases/get_fcm_token.dart';
import 'package:bizzie/features/notifications/domain/usecases/listen_to_messages.dart';
import 'package:bizzie/features/notifications/domain/usecases/request_notification_permission.dart';
import 'package:bizzie/features/notifications/domain/usecases/subscribe_to_topic.dart';
import 'package:bizzie/features/notifications/domain/usecases/unsubscribe_from_topic.dart';
import 'package:bizzie/features/notifications/domain/usecases/clear_cached_token.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_error_type.dart';
import 'package:bizzie/features/notifications/presentation/analytics/notification_tracker.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/usecases/parse_notification_payload.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
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
  final RequestNotificationPermission _requestPermission;
  final GetFcmToken _getFcmToken;
  final ListenToMessages _listenToMessages;
  final SubscribeToTopic _subscribeToTopic;
  final UnsubscribeFromTopic _unsubscribeFromTopic;
  final ClearCachedToken _clearCachedToken;
  final NotificationTracker _tracker;
  final ParseNotificationPayload _parseNotificationPayload;
  final INotificationService _notificationService;

  StreamSubscription<NotificationMessage>? _messageSubscription;
  StreamSubscription<Map<String, dynamic>>? _payloadSubscription;

  NotificationBloc(
    this._requestPermission,
    this._getFcmToken,
    this._listenToMessages,
    this._subscribeToTopic,
    this._unsubscribeFromTopic,
    this._clearCachedToken,
    this._tracker,
    this._parseNotificationPayload,
    this._notificationService,
  ) : super(
          const NotificationState(
            status: NotificationStatus.initial(),
            isAppReady: false,
          ),
        ) {
    on<NotificationSetupRequested>(_onSetupRequested);
    on<NotificationSubscribeToTopicRequested>(_onSubscribeToTopicRequested);
    on<NotificationUnsubscribeFromTopicRequested>(
      _onUnsubscribeFromTopicRequested,
    );
    on<NotificationMessageReceived>(_onMessageReceived);
    on<NotificationInteractionReceived>(
      _onInteractionReceived,
      transformer: restartable(),
    );
    on<NotificationReset>(_onReset);
    on<NotificationAppReadyForNavigation>(_onAppReadyForNavigation);
  }

  Future<void> _onReset(
    NotificationReset event,
    Emitter<NotificationState> emit,
  ) async {
    await _messageSubscription?.cancel();
    _messageSubscription = null;
    await _payloadSubscription?.cancel();
    _payloadSubscription = null;
    await _clearCachedToken(NoParams());
    await _tracker.setUserNotificationsEnabled(false);
    emit(
      const NotificationState(
        status: NotificationStatus.initial(),
        isAppReady: false,
      ),
    );
  }

  Future<void> _onSetupRequested(
    NotificationSetupRequested event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: const NotificationStatus.loading()));

    final permissionResult = await _requestPermission();

    await permissionResult.fold(
      (failure) async {
        await _tracker.logError(
          type: NotificationErrorType.permissionException,
          message: failure.message,
        );
        emit(state.copyWith(status: NotificationStatus.failure(failure.message)));
      },
      (_) async {
        final tokenResult = await _getFcmToken();

        await tokenResult.fold(
          (failure) async {
            await _tracker.logError(
              type: NotificationErrorType.tokenSyncFailure,
              message: failure.message,
            );
            emit(
              state.copyWith(status: NotificationStatus.failure(failure.message)),
            );
          },
          (fcmToken) async {
            await _tracker.setUserNotificationsEnabled(true);
            emit(state.copyWith(status: NotificationStatus.success(fcmToken)));

            await _notificationService.setupInteractions();

            await _messageSubscription?.cancel();
            _messageSubscription = _listenToMessages().listen(
              (message) => add(NotificationEvent.messageReceived(message)),
            );

            await _payloadSubscription?.cancel();
            _payloadSubscription = _notificationService.payloadStream.listen(
              (payload) => add(NotificationEvent.interactionReceived(payload)),
            );
          },
        );
      },
    );
  }

  Future<void> _onSubscribeToTopicRequested(
    NotificationSubscribeToTopicRequested event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await _subscribeToTopic(event.topic);
    await result.fold(
      (failure) async {
        await _tracker.logError(
          type: NotificationErrorType.subscriptionFailure,
          message: failure.message,
        );
        emit(state.copyWith(status: NotificationStatus.failure(failure.message)));
      },
      (_) async => null,
    );
  }

  Future<void> _onUnsubscribeFromTopicRequested(
    NotificationUnsubscribeFromTopicRequested event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await _unsubscribeFromTopic(event.topic);
    await result.fold(
      (failure) async {
        await _tracker.logError(
          type: NotificationErrorType.unsubscriptionFailure,
          message: failure.message,
        );
        emit(state.copyWith(status: NotificationStatus.failure(failure.message)));
      },
      (_) async => null,
    );
  }

  void _onMessageReceived(
    NotificationMessageReceived event,
    Emitter<NotificationState> emit,
  ) {
    emit(state.copyWith(status: NotificationStatus.messageReceived(event.message)));
  }

  Future<void> _onInteractionReceived(
    NotificationInteractionReceived event,
    Emitter<NotificationState> emit,
  ) async {
    final intent = _parseNotificationPayload(event.payload);
    if (intent == null) {
      _logger.warning('Failed to parse intent from payload: ${event.payload}');
      return;
    }

    if (state.isAppReady) {
      _logger.info('App is ready, emitting navigation request for $intent');
      emit(
        state.copyWith(
          status: NotificationStatus.navigationRequested(
            intent,
            DateTime.now().millisecondsSinceEpoch,
          ),
        ),
      );
      // Reset status to success to avoid re-triggering on next state update
      emit(state.copyWith(status: const NotificationStatus.initial()));
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

      emit(
        state.copyWith(
          isAppReady: true,
          pendingIntent: null,
        ),
      );

      emit(
        state.copyWith(
          status: NotificationStatus.navigationRequested(
            pendingIntent,
            DateTime.now().millisecondsSinceEpoch,
          ),
        ),
      );
      // Reset status to initial to avoid re-triggering
      emit(state.copyWith(status: const NotificationStatus.initial()));
    } else {
      _logger.info('No buffered intent, setting isAppReady: true');
      emit(state.copyWith(isAppReady: true));
    }
  }

  @override
  Future<void> close() async {
    await _messageSubscription?.cancel();
    await _payloadSubscription?.cancel();
    return super.close();
  }
}
