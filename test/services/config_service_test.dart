import 'package:bizzie/services/config_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

void main() {
  late MockFirebaseRemoteConfig mockRemoteConfig;
  late ConfigService configService;

  setUp(() {
    mockRemoteConfig = MockFirebaseRemoteConfig();
    configService = ConfigService(mockRemoteConfig);
  });

  group('ConfigService', () {
    test('getString returns value from RemoteConfig', () {
      when(
        () => mockRemoteConfig.getString('test_key'),
      ).thenReturn('test_value');

      final result = configService.getString('test_key');

      expect(result, 'test_value');
      verify(() => mockRemoteConfig.getString('test_key')).called(1);
    });

    test('getBool returns value from RemoteConfig', () {
      when(() => mockRemoteConfig.getBool('test_bool')).thenReturn(true);

      final result = configService.getBool('test_bool');

      expect(result, true);
      verify(() => mockRemoteConfig.getBool('test_bool')).called(1);
    });

    test('getInt returns value from RemoteConfig', () {
      when(() => mockRemoteConfig.getInt('test_int')).thenReturn(42);

      final result = configService.getInt('test_int');

      expect(result, 42);
      verify(() => mockRemoteConfig.getInt('test_int')).called(1);
    });
  });
}
