import 'package:bizzie/core/constants/storage_constants.dart';
import 'package:bizzie/features/app_status/data/datasources/local_app_status_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late LocalAppStatusDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LocalAppStatusDataSource(mockSharedPreferences);
  });

  group('LocalAppStatusDataSource', () {
    const tVersion = '1.0.0';
    const tUrl = 'https://example.com';
    const tKeyCachedMinAppVersion = StorageConstants.cachedMinAppVersion;
    const tKeyCachedAppStoreLink = StorageConstants.cachedAppStoreLink;
    const tKeyCachedPlayStoreLink = StorageConstants.cachedPlayStoreLink;

    group('cacheMinAppVersion', () {
      test('cacheMinAppVersion_success_callsSharedPreferences', () async {
        // arrange
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        // act
        await dataSource.cacheMinAppVersion(tVersion);

        // assert
        verify(
          () => mockSharedPreferences.setString(
            tKeyCachedMinAppVersion,
            tVersion,
          ),
        );
      });
    });

    group('getCachedMinAppVersion', () {
      test('getCachedMinAppVersion_hasCache_returnsVersion', () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(tVersion);

        // act
        final result = dataSource.getCachedMinAppVersion();

        // assert
        verify(() => mockSharedPreferences.getString(tKeyCachedMinAppVersion));
        expect(result, tVersion);
      });

      test('getCachedMinAppVersion_noCache_returnsNull', () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);

        // act
        final result = dataSource.getCachedMinAppVersion();

        // assert
        verify(() => mockSharedPreferences.getString(tKeyCachedMinAppVersion));
        expect(result, null);
      });
    });

    group('cacheAppStoreLink', () {
      test('cacheAppStoreLink_success_callsSharedPreferences', () async {
        // arrange
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        // act
        await dataSource.cacheAppStoreLink(tUrl);

        // assert
        verify(
          () => mockSharedPreferences.setString(tKeyCachedAppStoreLink, tUrl),
        );
      });
    });

    group('getCachedAppStoreLink', () {
      test('getCachedAppStoreLink_hasCache_returnsUrl', () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(tUrl);

        // act
        final result = dataSource.getCachedAppStoreLink();

        // assert
        verify(() => mockSharedPreferences.getString(tKeyCachedAppStoreLink));
        expect(result, tUrl);
      });

      test('getCachedAppStoreLink_noCache_returnsNull', () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);

        // act
        final result = dataSource.getCachedAppStoreLink();

        // assert
        verify(() => mockSharedPreferences.getString(tKeyCachedAppStoreLink));
        expect(result, null);
      });
    });

    group('cachePlayStoreLink', () {
      test('cachePlayStoreLink_success_callsSharedPreferences', () async {
        // arrange
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        // act
        await dataSource.cachePlayStoreLink(tUrl);

        // assert
        verify(
          () => mockSharedPreferences.setString(tKeyCachedPlayStoreLink, tUrl),
        );
      });
    });

    group('getCachedPlayStoreLink', () {
      test('getCachedPlayStoreLink_hasCache_returnsUrl', () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(tUrl);

        // act
        final result = dataSource.getCachedPlayStoreLink();

        // assert
        verify(() => mockSharedPreferences.getString(tKeyCachedPlayStoreLink));
        expect(result, tUrl);
      });

      test('getCachedPlayStoreLink_noCache_returnsNull', () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);

        // act
        final result = dataSource.getCachedPlayStoreLink();

        // assert
        verify(() => mockSharedPreferences.getString(tKeyCachedPlayStoreLink));
        expect(result, null);
      });
    });
  });
}
