import 'dart:convert';
import 'package:bizzie/core/constants/storage_constants.dart';

import 'package:bizzie/features/watchlist/data/datasources/watchlist_events_local_datasource_impl.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_event_status_dto.dart';
import 'package:bizzie/features/watchlist/domain/enums/watchlist_badge_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late WatchlistEventsLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    dataSource = WatchlistEventsLocalDataSourceImpl(mockPrefs);
  });

  final tStatusDto = WatchlistEventStatusDto(
    badgeText: 'Earnings',
    badgeType: WatchlistBadgeType.neutral.name,
    eventDate: DateTime(2025, 2, 15),
    lastUpdated: DateTime(2025, 2, 15),
  );

  final tEvents = {'AAPL': tStatusDto};
  final tJsonString = jsonEncode({'AAPL': tStatusDto.toJson()});

  group('WatchlistEventsLocalDataSourceImpl', () {
    test('getCachedEvents_noData_returnsEmptyMap', () async {
      // arrange
      when(() => mockPrefs.getString(any())).thenReturn(null);

      // act
      final result = await dataSource.getCachedEvents();

      // assert
      expect(result, isEmpty);
      verify(
        () => mockPrefs.getString(StorageConstants.watchlistEventsCache),
      ).called(1);
    });

    test('getCachedEvents_validData_returnsDecodedMap', () async {
      // arrange
      when(() => mockPrefs.getString(any())).thenReturn(tJsonString);

      // act
      final result = await dataSource.getCachedEvents();

      // assert
      expect(result.length, 1);
      expect(result['AAPL']!.badgeText, 'Earnings');
    });

    test('getCachedEvents_corruptedData_removesAndReturnsEmptyMap', () async {
      // arrange
      when(() => mockPrefs.getString(any())).thenReturn('invalid json');
      when(() => mockPrefs.remove(any())).thenAnswer((_) async => true);

      // act
      final result = await dataSource.getCachedEvents();

      // assert
      expect(result, isEmpty);
      verify(
        () => mockPrefs.remove(StorageConstants.watchlistEventsCache),
      ).called(1);
    });

    test('cacheEvents_success_storesJsonString', () async {
      // arrange
      when(
        () => mockPrefs.setString(any(), any()),
      ).thenAnswer((_) async => true);

      // act
      await dataSource.cacheEvents(tEvents);

      // assert
      verify(
        () => mockPrefs.setString(StorageConstants.watchlistEventsCache, any()),
      ).called(1);
    });
  });
}
