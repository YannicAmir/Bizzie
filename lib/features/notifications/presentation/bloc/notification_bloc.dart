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

  StreamSubscription<NotificationMessage>? _messageSubscription;

  NotificationBloc(
    this._requestPermission,
    this._getFcmToken,
    this._listenToMessages,
    this._subscribeToTopic,
    this._unsubscribeFromTopic,
  ) : super(const NotificationState.initial()) {
    on<_SetupRequested>(_onSetupRequested);
    on<_SubscribeToTopicRequested>(_onSubscribeToTopicRequested);
    on<_UnsubscribeFromTopicRequested>(_onUnsubscribeFromTopicRequested);
    on<_MessageReceived>(_onMessageReceived);
  }

  Future<void> _onSetupRequested(
    _SetupRequested event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationState.loading());

    _logger.info('SetupRequested event received. calling requestPermission...');
    final permissionResult = await _requestPermission();

    await permissionResult.fold(
      (failure) async {
        emit(NotificationState.failure(failure.message));
      },
      (_) async {
        _logger.info('Permission request completed.');
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
    _SubscribeToTopicRequested event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await _subscribeToTopic(event.topic);
    result.fold(
      (failure) => emit(
        NotificationState.failure("Failed to subscribe: ${failure.message}"),
      ),
      (_) => null,
    );
  }

  Future<void> _onUnsubscribeFromTopicRequested(
    _UnsubscribeFromTopicRequested event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await _unsubscribeFromTopic(event.topic);
    result.fold(
      (failure) => emit(
        NotificationState.failure("Failed to unsubscribe: ${failure.message}"),
      ),
      (_) => null,
    );
  }

  void _onMessageReceived(
    _MessageReceived event,
    Emitter<NotificationState> emit,
  ) {
    emit(NotificationState.messageReceivedState(event.message));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
