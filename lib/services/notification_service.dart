import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_app_state.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_trigger_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/notifications/data/datasources/local_notification_datasource.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
import 'package:bizzie/features/notifications/presentation/analytics/notification_tracker.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('NotificationService');

@LazySingleton(as: INotificationService)
class NotificationService implements INotificationService {
  final INotificationRepository _notificationRepository;
  final LocalNotificationDataSource _localNotificationDataSource;
  final DeviceInfoPlugin _deviceInfo;
  final FirebaseMessaging _firebaseMessaging;
  final ILocalStorageService _localStorageService;
  final IUserRepository _userRepository;
  final NotificationTracker _tracker;

  bool _isInteractionsSetup = false;
  final _payloadController = BehaviorSubject<Map<String, dynamic>>();

  NotificationService(
    this._notificationRepository,
    this._localNotificationDataSource,
    this._deviceInfo,
    this._firebaseMessaging,
    this._localStorageService,
    this._userRepository,
    this._tracker,
  );

  @PostConstruct(preResolve: true)
  Future<void> initialize() async {
    await _initialize();
  }

  Future<void> _initialize() async {
    await _localNotificationDataSource.init(
      onNotificationTap: (payload) {
        if (payload != null) {
          _logger.info('Local notification tapped with payload: $payload');
          _handlePayload(payload);
        }
      },
    );

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: true,
    );

    await setupInteractions();

    await syncFcmToken();

    _firebaseMessaging.onTokenRefresh.listen((token) {
      _logger.info('FCM token refreshed');
      syncFcmToken();
    });

    _notificationRepository.onMessage.listen((message) {
      _logger.info(
        'Foreground message received: ${message.title} - ${message.body}',
      );
      if (message.title.isNotEmpty || message.body.isNotEmpty) {
        _logger.info('Showing local notification for foreground message');
        _localNotificationDataSource.showNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: message.title,
          body: message.body,
          payload: jsonEncode(message.data),
        );
      } else {
        _logger.warning(
          'Received foreground message with empty title and body',
        );
      }
    });
  }

  @override
  Future<String?> getFcmToken() async {
    final result = await _notificationRepository.getFcmToken();
    return result.fold((failure) {
      _logger.severe('Failed to fetch FCM token: ${failure.errorMessage}');
      return null;
    }, (token) => token);
  }

  @override
  Future<void> syncFcmToken({bool force = false}) async {
    _logger.info('Syncing FCM token (force: $force)');

    final token = await getFcmToken();
    if (token == null) {
      _logger.warning('Failed to get FCM token, aborting sync');
      return;
    }

    final deviceId = await getDeviceUuid();
    final lastSyncedToken = _localStorageService.getString(
      'last_synced_fcm_token',
    );

    if (force || token != lastSyncedToken) {
      _logger.info('Token changed or force sync. Updating backend.');
      final result = await _userRepository.updateFcmToken(deviceId, token);

      result.fold(
        (failure) {
          _logger.severe('Failed to update FCM token', failure);
          unawaited(_tracker.logSyncFailure(message: failure.errorMessage));
        },
        (_) {
          _logger.info('FCM token updated successfully. Updating cache.');
          _localStorageService.setString('last_synced_fcm_token', token);
        },
      );
    } else {
      _logger.info('Token matches last synced token. Skipping update.');
    }
  }

  @override
  Future<void> clearCachedToken() async {
    _logger.info('Clearing cached FCM token');
    await _localStorageService.remove('last_synced_fcm_token');
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    _logger.info('Subscribing to topic: $topic');
    final result = await _notificationRepository.subscribeToTopic(topic);
    result.fold((failure) {
      _logger.severe('Failed to subscribe to topic $topic: ${failure.errorMessage}');
      throw Exception(failure.errorMessage);
    }, (_) => _logger.info('Successfully subscribed to topic: $topic'));
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    _logger.info('Unsubscribing from topic: $topic');
    final result = await _notificationRepository.unsubscribeFromTopic(topic);
    result.fold((failure) {
      _logger.severe(
        'Failed to unsubscribe from topic $topic: ${failure.errorMessage}',
      );
      throw Exception(failure.errorMessage);
    }, (_) => _logger.info('Successfully unsubscribed from topic: $topic'));
  }

  @override
  Future<String> getDeviceUuid() async {
    if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown_ios_device';
    } else if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.id;
    } else {
      return 'unknown_platform_device';
    }
  }

  @override
  Stream<Map<String, dynamic>> get payloadStream => _payloadController.stream;

  @override
  Future<void> setupInteractions() async {
    if (_isInteractionsSetup) {
      _logger.info('Notification interactions already set up. Skipping.');
      return;
    }

    _isInteractionsSetup = true;
    _logger.info('Setting up notification interactions');

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _logger.info('App opened from background state by notification');
      _handleMessage(message, appState: NotificationAppState.background);
    });
  }

  @override
  Future<Map<String, dynamic>?> getInitialPayload() async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _logger.info('App opened from terminated state by notification');

      unawaited(
        _tracker.logNotificationOpened(
          notificationType: initialMessage.data['type'] as String?,
          triggerSource: NotificationTriggerSource.remote,
          appState: NotificationAppState.terminated,
          route: null,
          ticker: initialMessage.data['ticker'] as String?,
        ),
      );

      return initialMessage.data;
    }
    return null;
  }

  void _handleMessage(
    RemoteMessage message, {
    NotificationAppState appState = NotificationAppState.background,
  }) {
    unawaited(
      _tracker.logNotificationOpened(
        notificationType: message.data['type'] as String?,
        triggerSource: NotificationTriggerSource.remote,
        appState: appState,
        route: null,
        ticker: message.data['ticker'] as String?,
      ),
    );

    _payloadController.add(message.data);
  }

  void _handlePayload(String payload) {
    _logger.info('Handling notification payload: $payload');
    String? type;
    String? ticker;
    Map<String, dynamic> data = {};

    try {
      if (payload.startsWith('{') && payload.endsWith('}')) {
        try {
          data = Map<String, dynamic>.from(jsonDecode(payload) as Map);
          _logger.info('Successfully decoded payload as JSON');
        } catch (e) {
          _logger.warning(
            'Failed to decode payload as JSON, attempting legacy parse: $e',
          );
          data = _parseLegacyPayload(payload);
        }
      } else {
        data = _parseLegacyPayload(payload);
      }

      type = data['type'] as String?;
      ticker = data['ticker'] as String?;
    } catch (e) {
      _logger.severe('Critical error in _handlePayload: $e');
    }

    unawaited(
      _tracker.logNotificationOpened(
        notificationType: type,
        triggerSource: NotificationTriggerSource.local,
        appState: NotificationAppState.foreground,
        route: null,
        ticker: ticker,
      ),
    );

    if (data.isNotEmpty) {
      _logger.info('Adding payload to stream: $data');
      _payloadController.add(data);
    } else {
      _logger.warning('No payload generated');
    }
  }

  Map<String, dynamic> _parseLegacyPayload(String payload) {
    final Map<String, dynamic> data = {};
    _logger.info('Parsing legacy payload: $payload');

    final clean = payload.replaceAll(RegExp(r'^\{|\}$'), '');
    final parts = clean.split(',');

    for (final part in parts) {
      final kv = part.split(':');
      if (kv.length >= 2) {
        final key = kv[0].trim();
        final value = kv.sublist(1).join(':').trim();
        data[key] = value;
      }
    }

    _logger.info('Legacy parse result: $data');
    return data;
  }

  @override
  Future<bool> isSystemAuthorized() async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }
}
