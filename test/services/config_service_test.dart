import 'package:bizzie/services/config_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

class MockRemoteConfigUpdate extends Mock implements RemoteConfigUpdate {}

void main() {
  late MockFirebaseRemoteConfig mockRemoteConfig;
  late ConfigService configService;

  setUp(() {
    mockRemoteConfig = MockFirebaseRemoteConfig();
    configService = ConfigService(mockRemoteConfig);
  });

  group('ConfigService', () {
    test('getString_validKey_returnsValue', () {
      // ARRANGE
      when(
        () => mockRemoteConfig.getString('test_key'),
      ).thenReturn('test_value');

      // ACT
      final result = configService.getString('test_key');

      // ASSERT
      expect(result, 'test_value');
      verify(() => mockRemoteConfig.getString('test_key')).called(1);
    });

    test('getBool_validKey_returnsValue', () {
      // ARRANGE
      when(() => mockRemoteConfig.getBool('test_bool')).thenReturn(true);

      // ACT
      final result = configService.getBool('test_bool');

      // ASSERT
      expect(result, true);
      verify(() => mockRemoteConfig.getBool('test_bool')).called(1);
    });

    test('getInt_validKey_returnsValue', () {
      // ARRANGE
      when(() => mockRemoteConfig.getInt('test_int')).thenReturn(42);

      // ACT
      final result = configService.getInt('test_int');

      // ASSERT
      expect(result, 42);
      verify(() => mockRemoteConfig.getInt('test_int')).called(1);
    });

    test('getDouble_validKey_returnsValue', () {
      // ARRANGE
      when(() => mockRemoteConfig.getDouble('test_double')).thenReturn(3.14);

      // ACT
      final result = configService.getDouble('test_double');

      // ASSERT
      expect(result, 3.14);
      verify(() => mockRemoteConfig.getDouble('test_double')).called(1);
    });

    test('geminiModelName_remoteConfigValue_returnsValue', () {
      // ARRANGE
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.geminiModelName),
      ).thenReturn('gemini-pro');

      // ACT
      final result = configService.geminiModelName;

      // ASSERT
      expect(result, 'gemini-pro');
    });

    test('privacyPolicyUrl_remoteConfigValue_returnsValue', () {
      // ARRANGE
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.privacyPolicyUrl),
      ).thenReturn('https://bizzie.app/privacy');

      // ACT
      final result = configService.privacyPolicyUrl;

      // ASSERT
      expect(result, 'https://bizzie.app/privacy');
    });

    test('termsOfServiceUrl_remoteConfigValue_returnsValue', () {
      // ARRANGE
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.termsOfServiceUrl),
      ).thenReturn('https://bizzie.app/terms');

      // ACT
      final result = configService.termsOfServiceUrl;

      // ASSERT
      expect(result, 'https://bizzie.app/terms');
    });

    test('maintenanceMode_remoteConfigValue_returnsCorrectBool', () {
      // ARRANGE
      when(
        () => mockRemoteConfig.getBool(RemoteConfigKeys.maintenanceMode),
      ).thenReturn(true);

      // ACT
      final result = configService.maintenanceMode;

      // ASSERT
      expect(result, true);
    });

    test('onConfigUpdated_stream_emitsWhenRemoteConfigUpdates', () {
      // ARRANGE
      final mockUpdate = MockRemoteConfigUpdate();
      final stream = Stream<RemoteConfigUpdate>.fromIterable([mockUpdate]);
      when(() => mockRemoteConfig.onConfigUpdated).thenAnswer((_) => stream);

      // ACT
      final result = configService.onConfigUpdated;

      // ASSERT
      expect(result, emitsInOrder([mockUpdate]));
    });

    test('stockMarketSectors_validJson_returnsList', () {
      // ARRANGE
      final sectors = ['Tech', 'Bio', 'Energy'];
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.stockMarketSectors),
      ).thenReturn('["Tech", "Bio", "Energy"]');

      // ACT
      final result = configService.stockMarketSectors;

      // ASSERT
      expect(result, sectors);
    });

    test('stockMarketSectors_invalidJson_returnsDefaults', () {
      // ARRANGE
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.stockMarketSectors),
      ).thenReturn('invalid-json');

      // ACT
      final result = configService.stockMarketSectors;

      // ASSERT
      expect(result, isNotEmpty);
      expect(result, contains('Energy'));
    });

    test('sectorDescriptions_validJson_returnsMap', () {
      // ARRANGE
      const json = '{"Energy": "Energy desc", "Tech": "Tech desc"}';
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.sectorDescriptions),
      ).thenReturn(json);

      // ACT
      final result = configService.sectorDescriptions;

      // ASSERT
      expect(result['Energy'], 'Energy desc');
      expect(result['Tech'], 'Tech desc');
    });

    test('sectorDescriptions_invalidJson_returnsDefaults', () {
      // ARRANGE
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.sectorDescriptions),
      ).thenReturn('invalid-json');

      // ACT
      final result = configService.sectorDescriptions;

      // ASSERT
      expect(result, isNotEmpty);
      expect(result.containsKey('Energy'), isTrue);
    });

    test('fmpConfig_validJson_returnsConfig', () {
      // ARRANGE
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.fmpConfig),
      ).thenReturn(
        '{"baseUrl": "https://test.com", "v3Url": "https://test.com/v3", "v4Url": "https://test.com/v4"}',
      );

      // ACT
      final result = configService.fmpConfig;

      // ASSERT
      expect(result.baseUrl, 'https://test.com');
      expect(result.v3Url, 'https://test.com/v3');
    });

    test('fmpConfig_invalidJson_returnsDefaults', () {
      // ARRANGE
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.fmpConfig),
      ).thenReturn('invalid-json');

      // ACT
      final result = configService.fmpConfig;

      // ASSERT
      expect(result.baseUrl, contains('financialmodelingprep'));
    });

    test('lastFetchTime_returnsRemoteConfigValue', () {
      // ARRANGE
      final time = DateTime(2025, 1, 1);
      when(() => mockRemoteConfig.lastFetchTime).thenReturn(time);

      // ACT
      final result = configService.lastFetchTime;

      // ASSERT
      expect(result, time);
      verify(() => mockRemoteConfig.lastFetchTime).called(1);
    });
  });
}
