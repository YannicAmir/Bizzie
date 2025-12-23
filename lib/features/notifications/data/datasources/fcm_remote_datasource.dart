import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@injectable
class FcmRemoteDataSource {
  final FirebaseMessaging _firebaseMessaging;

  FcmRemoteDataSource() : _firebaseMessaging = FirebaseMessaging.instance;

  Future<NotificationSettings> requestPermission() async {
    BizzieLogger.info('FcmRemoteDataSource: Requesting permission...');
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    BizzieLogger.info(
      'FcmRemoteDataSource: Permission status: ${settings.authorizationStatus}',
    );
    return settings;
  }

  // Returns the FCM token for this device.
  // Note: This token is specific to the Firebase Project (Bizzie Dev, QA, or Prod)
  // that the app is currently running against (determined by flavor).
  Future<String?> getToken() => _firebaseMessaging.getToken();

  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  Future<void> subscribeToTopic(String topic) =>
      _firebaseMessaging.subscribeToTopic(topic);

  Future<void> unsubscribeFromTopic(String topic) =>
      _firebaseMessaging.unsubscribeFromTopic(topic);
}
