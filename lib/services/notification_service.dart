import 'dart:async';
import 'dart:io';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/notifications/domain/models/notification_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/notifications/data/datasources/local_notification_datasource.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
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

  final _routeController = StreamController<NotificationRoute>.broadcast();

  NotificationService(
    this._notificationRepository,
    this._localNotificationDataSource,
    this._deviceInfo,
    this._firebaseMessaging,
    this._localStorageService,
    this._userRepository,
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
          payload: message.data.toString(),
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
      _logger.severe('Failed to fetch FCM token: ${failure.message}');
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
        (failure) => _logger.severe('Failed to update FCM token', failure),
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
      _logger.severe('Failed to subscribe to topic $topic: ${failure.message}');
      throw Exception(failure.message);
    }, (_) => _logger.info('Successfully subscribed to topic: $topic'));
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    _logger.info('Unsubscribing from topic: $topic');
    final result = await _notificationRepository.unsubscribeFromTopic(topic);
    result.fold((failure) {
      _logger.severe(
        'Failed to unsubscribe from topic $topic: ${failure.message}',
      );
      throw Exception(failure.message);
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
  Stream<NotificationRoute> get routeStream => _routeController.stream;

  @override
  Future<void> setupInteractions() async {
    _logger.info('Setting up notification interactions');

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _logger.info('App opened from background state by notification');
      _handleMessage(message);
    });
  }

  @override
  Future<NotificationRoute?> getInitialRoute() async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _logger.info('App opened from terminated state by notification');
      return _parseMessage(initialMessage);
    }
    return null;
  }

  NotificationRoute? _parseMessage(RemoteMessage message) {
    final type = message.data['type'];
    _logger.info('Parsing notification type: $type');

    if (type == 'sec_filing' || type == 'earnings_notification') {
      return const NotificationRoute(AppRoutes.reports);
    } else if (type == 'subscription_drip') {
      return NotificationRoute(
        '${AppRoutes.discountedPaywall}?source=${PaywallSource.notification.name}',
      );
    }
    return null;
  }

  void _handleMessage(RemoteMessage message) {
    final route = _parseMessage(message);
    if (route != null) {
      _routeController.add(route);
    }
  }

  void _handlePayload(String payload) {
    if (payload.contains('sec_filing') ||
        payload.contains('earnings_notification')) {
      _routeController.add(const NotificationRoute(AppRoutes.reports));
    } else if (payload.contains('subscription_drip')) {
      _routeController.add(
        NotificationRoute(
          '${AppRoutes.discountedPaywall}?source=${PaywallSource.notification.name}',
        ),
      );
    }
  }

  @override
  Future<bool> isSystemAuthorized() async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }
}
