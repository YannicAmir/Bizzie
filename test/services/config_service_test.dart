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
      // arrange
      when(
        () => mockRemoteConfig.getString('test_key'),
      ).thenReturn('test_value');

      // act
      final result = configService.getString('test_key');

      // assert
      expect(result, 'test_value');
      verify(() => mockRemoteConfig.getString('test_key')).called(1);
    });

    test('getBool_validKey_returnsValue', () {
      // arrange
      when(() => mockRemoteConfig.getBool('test_bool')).thenReturn(true);

      // act
      final result = configService.getBool('test_bool');

      // assert
      expect(result, true);
      verify(() => mockRemoteConfig.getBool('test_bool')).called(1);
    });

    test('getInt_validKey_returnsValue', () {
      // arrange
      when(() => mockRemoteConfig.getInt('test_int')).thenReturn(42);

      // act
      final result = configService.getInt('test_int');

      // assert
      expect(result, 42);
      verify(() => mockRemoteConfig.getInt('test_int')).called(1);
    });

    test('getDouble_validKey_returnsValue', () {
      // arrange
      when(() => mockRemoteConfig.getDouble('test_double')).thenReturn(3.14);

      // act
      final result = configService.getDouble('test_double');

      // assert
      expect(result, 3.14);
      verify(() => mockRemoteConfig.getDouble('test_double')).called(1);
    });

    test('geminiModelName_remoteConfigValue_returnsValue', () {
      // arrange
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.geminiModelName),
      ).thenReturn('gemini-pro');

      // act
      final result = configService.geminiModelName;

      // assert
      expect(result, 'gemini-pro');
    });

    test('privacyPolicyUrl_remoteConfigValue_returnsValue', () {
      // arrange
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.privacyPolicyUrl),
      ).thenReturn('https://bizzie.app/privacy');

      // act
      final result = configService.privacyPolicyUrl;

      // assert
      expect(result, 'https://bizzie.app/privacy');
    });

    test('termsOfServiceUrl_remoteConfigValue_returnsValue', () {
      // arrange
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.termsOfServiceUrl),
      ).thenReturn('https://bizzie.app/terms');

      // act
      final result = configService.termsOfServiceUrl;

      // assert
      expect(result, 'https://bizzie.app/terms');
    });

    test('maintenanceMode_remoteConfigValue_returnsCorrectBool', () {
      // arrange
      when(
        () => mockRemoteConfig.getBool(RemoteConfigKeys.maintenanceMode),
      ).thenReturn(true);

      // act
      final result = configService.maintenanceMode;

      // assert
      expect(result, true);
    });

    test('onConfigUpdated_stream_emitsWhenRemoteConfigUpdates', () {
      // arrange
      final mockUpdate = MockRemoteConfigUpdate();
      final stream = Stream<RemoteConfigUpdate>.fromIterable([mockUpdate]);
      when(() => mockRemoteConfig.onConfigUpdated).thenAnswer((_) => stream);

      // act
      final result = configService.onConfigUpdated;

      // assert
      expect(result, emitsInOrder([mockUpdate]));
    });

    test('stockMarketSectors_validJson_returnsList', () {
      // arrange
      final sectors = ['Tech', 'Bio', 'Energy'];
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.stockMarketSectors),
      ).thenReturn('["Tech", "Bio", "Energy"]');

      // act
      final result = configService.stockMarketSectors;

      // assert
      expect(result, sectors);
    });

    test('stockMarketSectors_invalidJson_returnsDefaults', () {
      // arrange
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.stockMarketSectors),
      ).thenReturn('invalid-json');

      // act
      final result = configService.stockMarketSectors;

      // assert
      expect(result, isNotEmpty);
      expect(result, contains('Energy'));
    });

    test('sectorDescriptions_validJson_returnsMap', () {
      // arrange
      const json = '{"Energy": "Energy desc", "Tech": "Tech desc"}';
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.sectorDescriptions),
      ).thenReturn(json);

      // act
      final result = configService.sectorDescriptions;

      // assert
      expect(result['Energy'], 'Energy desc');
      expect(result['Tech'], 'Tech desc');
    });

    test('sectorDescriptions_invalidJson_returnsDefaults', () {
      // arrange
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.sectorDescriptions),
      ).thenReturn('invalid-json');

      // act
      final result = configService.sectorDescriptions;

      // assert
      expect(result, isNotEmpty);
      expect(result.containsKey('Energy'), isTrue);
    });

    test('fmpConfig_validJson_returnsConfig', () {
      // arrange
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.fmpConfig),
      ).thenReturn(
        '{"baseUrl": "https://test.com", "v3Url": "https://test.com/v3", "v4Url": "https://test.com/v4"}',
      );

      // act
      final result = configService.fmpConfig;

      // assert
      expect(result.baseUrl, 'https://test.com');
      expect(result.v3Url, 'https://test.com/v3');
    });

    test('fmpConfig_invalidJson_returnsDefaults', () {
      // arrange
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.fmpConfig),
      ).thenReturn('invalid-json');

      // act
      final result = configService.fmpConfig;

      // assert
      expect(result.baseUrl, contains('financialmodelingprep'));
    });

    test('lastFetchTime_returnsRemoteConfigValue', () {
      // arrange
      final time = DateTime(2025, 1, 1);
      when(() => mockRemoteConfig.lastFetchTime).thenReturn(time);

      // act
      final result = configService.lastFetchTime;

      // assert
      expect(result, time);
      verify(() => mockRemoteConfig.lastFetchTime).called(1);
    });
  });
}
