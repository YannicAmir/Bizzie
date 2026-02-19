import 'dart:async';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/usecases/get_fcm_token.dart';
import 'package:bizzie/features/notifications/domain/usecases/listen_to_messages.dart';
import 'package:bizzie/features/notifications/domain/usecases/request_notification_permission.dart';
import 'package:bizzie/features/notifications/domain/usecases/subscribe_to_topic.dart';
import 'package:bizzie/features/notifications/domain/usecases/unsubscribe_from_topic.dart';
import 'package:bizzie/features/notifications/domain/usecases/clear_cached_token.dart';
import 'package:bizzie/features/notifications/presentation/analytics/notification_tracker.dart';
import 'package:bizzie/core/usecase/usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';
part 'notification_bloc.freezed.dart';

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

  StreamSubscription<NotificationMessage>? _messageSubscription;

  NotificationBloc(
    this._requestPermission,
    this._getFcmToken,
    this._listenToMessages,
    this._subscribeToTopic,
    this._unsubscribeFromTopic,
    this._clearCachedToken,
    this._tracker,
  ) : super(const NotificationState.initial()) {
    on<NotificationSetupRequested>(_onSetupRequested);
    on<NotificationSubscribeToTopicRequested>(_onSubscribeToTopicRequested);
    on<NotificationUnsubscribeFromTopicRequested>(
      _onUnsubscribeFromTopicRequested,
    );
    on<NotificationMessageReceived>(_onMessageReceived);
    on<NotificationReset>(_onReset);
  }

  Future<void> _onReset(
    NotificationReset event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.info('Resetting NotificationBloc - canceling subscription');
    _messageSubscription?.cancel();
    _messageSubscription = null;
    await _clearCachedToken(NoParams());
    await _tracker.setUserNotificationsEnabled(false);
    emit(const NotificationState.initial());
  }

  Future<void> _onSetupRequested(
    NotificationSetupRequested event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationState.loading());

    _logger.info('SetupRequested event received. calling requestPermission...');
    final permissionResult = await _requestPermission();

    await permissionResult.fold(
      (failure) async {
        await _tracker.logPermissionResult(granted: false);
        await _tracker.setUserNotificationsEnabled(false);
        emit(NotificationState.failure(failure.message));
      },
      (_) async {
        _logger.info('Permission request completed.');
        await _tracker.logPermissionResult(granted: true);
        await _tracker.setUserNotificationsEnabled(true);

        final tokenResult = await _getFcmToken();

        tokenResult.fold(
          (failure) {
            emit(NotificationState.failure(failure.message));
          },
          (token) {
            _logger.info('FCM Token: $token');

            _messageSubscription = _listenToMessages().listen((message) {
              add(NotificationEvent.messageReceived(message));
            });

            emit(NotificationState.success(token));
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
      (failure) async => emit(
        NotificationState.failure("Failed to subscribe: ${failure.message}"),
      ),
      (_) async {
        await _tracker.logTopicSubscribed(topic: event.topic);
      },
    );
  }

  Future<void> _onUnsubscribeFromTopicRequested(
    NotificationUnsubscribeFromTopicRequested event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await _unsubscribeFromTopic(event.topic);
    await result.fold(
      (failure) async => emit(
        NotificationState.failure("Failed to unsubscribe: ${failure.message}"),
      ),
      (_) async {
        await _tracker.logTopicUnsubscribed(topic: event.topic);
      },
    );
  }

  void _onMessageReceived(
    NotificationMessageReceived event,
    Emitter<NotificationState> emit,
  ) {
    _logger.info('MessageReceived event: ${event.message.title}');

    final type = event.message.data?['type'] as String?;
    _tracker.logMessageReceived(type: type);

    emit(NotificationState.messageReceivedState(event.message));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
