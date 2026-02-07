import 'dart:convert';
import 'package:bizzie/features/market/data/datasources/market_local_datasource.dart';
import 'package:bizzie/features/market/data/dtos/market_data_snapshot.dart';
import 'package:bizzie/features/market/data/dtos/sector_pe_dto.dart';
import 'package:bizzie/features/market/data/dtos/sector_performance_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MarketLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUpAll(() {
    registerFallbackValue(
      MarketDataSnapshot(
        date: '2026-02-07',
        peList: [],
        performanceList: [],
        cacheTimestamp: 0,
      ),
    );
  });

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = MarketLocalDataSourceImpl(mockSharedPreferences);
  });

  const tSectorPeDto = SectorPeDto(
    date: '2026-02-07',
    sector: 'Technology',
    exchange: 'NASDAQ',
    pe: 25.5,
  );

  const tSectorPerformanceDto = SectorPerformanceDto(
    date: '2026-02-07',
    sector: 'Technology',
    exchange: 'NASDAQ',
    averageChange: 1.5,
  );

  final tMarketDataSnapshot = MarketDataSnapshot(
    date: '2026-02-07',
    peList: [tSectorPeDto],
    performanceList: [tSectorPerformanceDto],
    cacheTimestamp: 123456789,
  );

  const kMarketDataKey = 'market_data_snapshot';

  group('getLastKnownMarketData', () {
    test('getLastKnownMarketData_success_returnsDecodedSnapshot', () async {
      // arrange
      final jsonString = jsonEncode(tMarketDataSnapshot.toJson());
      when(
        () => mockSharedPreferences.getString(kMarketDataKey),
      ).thenReturn(jsonString);

      // act
      final result = await dataSource.getLastKnownMarketData();

      // assert
      expect(result, equals(tMarketDataSnapshot));
      verify(() => mockSharedPreferences.getString(kMarketDataKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('getLastKnownMarketData_empty_returnsNull', () async {
      // arrange
      when(
        () => mockSharedPreferences.getString(kMarketDataKey),
      ).thenReturn(null);

      // act
      final result = await dataSource.getLastKnownMarketData();

      // assert
      expect(result, isNull);
      verify(() => mockSharedPreferences.getString(kMarketDataKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('getLastKnownMarketData_invalidJson_returnsNull', () async {
      // arrange
      when(
        () => mockSharedPreferences.getString(kMarketDataKey),
      ).thenReturn('invalid_json');

      // act
      final result = await dataSource.getLastKnownMarketData();

      // assert
      expect(result, isNull);
      verify(() => mockSharedPreferences.getString(kMarketDataKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('getLastKnownMarketData_exception_returnsNull', () async {
      // arrange
      when(
        () => mockSharedPreferences.getString(kMarketDataKey),
      ).thenThrow(Exception('Storage error'));

      // act
      final result = await dataSource.getLastKnownMarketData();

      // assert
      expect(result, isNull);
      verify(() => mockSharedPreferences.getString(kMarketDataKey)).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });

  group('cacheMarketData', () {
    test('cacheMarketData_success_callsSetStringWithEncodedJson', () async {
      // arrange
      final jsonString = jsonEncode(tMarketDataSnapshot.toJson());
      when(
        () => mockSharedPreferences.setString(kMarketDataKey, any()),
      ).thenAnswer((_) async => true);

      // act
      await dataSource.cacheMarketData(tMarketDataSnapshot);

      // assert
      verify(
        () => mockSharedPreferences.setString(kMarketDataKey, jsonString),
      ).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('cacheMarketData_exception_handlesErrorGracefully', () async {
      // arrange
      when(
        () => mockSharedPreferences.setString(kMarketDataKey, any()),
      ).thenThrow(Exception('Write error'));

      // act
      final call = dataSource.cacheMarketData(tMarketDataSnapshot);

      // assert
      expect(call, completes);
      verify(
        () => mockSharedPreferences.setString(kMarketDataKey, any()),
      ).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}
