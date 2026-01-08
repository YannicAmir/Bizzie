import 'package:bizzie/services/notification_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}

class MockAndroidDeviceInfo extends Mock implements AndroidDeviceInfo {}

class MockIosDeviceInfo extends Mock implements IosDeviceInfo {}

void main() {
  late NotificationService service;
  late MockFirebaseMessaging mockFirebaseMessaging;
  late MockDeviceInfoPlugin mockDeviceInfo;

  setUp(() {
    mockFirebaseMessaging = MockFirebaseMessaging();
    mockDeviceInfo = MockDeviceInfoPlugin();
    service = NotificationService(mockFirebaseMessaging, mockDeviceInfo);
  });

  group('NotificationService', () {
    test('getFcmToken_returnsToken_whenSuccessful', () async {
      when(
        () => mockFirebaseMessaging.getToken(),
      ).thenAnswer((_) async => 'token');

      final result = await service.getFcmToken();

      expect(result, 'token');
      verify(() => mockFirebaseMessaging.getToken()).called(1);
    });

    test('getFcmToken_returnsNull_whenExceptionOccurs', () async {
      when(
        () => mockFirebaseMessaging.getToken(),
      ).thenThrow(Exception('Error'));

      final result = await service.getFcmToken();

      expect(result, isNull);
    });

    test('subscribeToTopic_callsSubscribe', () async {
      when(
        () => mockFirebaseMessaging.subscribeToTopic(any()),
      ).thenAnswer((_) async {});

      await service.subscribeToTopic('test_topic');

      verify(
        () => mockFirebaseMessaging.subscribeToTopic('test_topic'),
      ).called(1);
    });

    test('unsubscribeFromTopic_callsUnsubscribe', () async {
      when(
        () => mockFirebaseMessaging.unsubscribeFromTopic(any()),
      ).thenAnswer((_) async {});

      await service.unsubscribeFromTopic('test_topic');

      verify(
        () => mockFirebaseMessaging.unsubscribeFromTopic('test_topic'),
      ).called(1);
    });
  });
}
