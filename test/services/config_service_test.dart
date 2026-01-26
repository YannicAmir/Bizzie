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

    test('geminiModelName_returnsValue', () {
      // arrange
      when(
        () => mockRemoteConfig.getString(RemoteConfigKeys.geminiModelName),
      ).thenReturn('gemini-pro');

      // act
      final result = configService.geminiModelName;

      // assert
      expect(result, 'gemini-pro');
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
  });
}
