import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/features/watchlist/data/datasources/watchlist_events_remote_datasource_impl.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_api_dtos.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  late WatchlistEventsRemoteDataSourceImpl dataSource;
  late MockFirestoreService mockFirestoreService;

  setUp(() {
    mockFirestoreService = MockFirestoreService();
    dataSource = WatchlistEventsRemoteDataSourceImpl(mockFirestoreService);
  });

  const tTickers = ['AAPL', 'TSLA'];
  final tEarningsDto = <WatchlistEarningsDto>[
    WatchlistEarningsDto(symbol: 'AAPL', date: DateTime(2025, 2, 15)),
  ];
  final tFilingsDto = <WatchlistFilingDto>[
    WatchlistFilingDto(
      symbol: 'TSLA',
      formType: '8-K',
      filingDate: DateTime(2025, 2, 14),
    ),
  ];

  group('WatchlistEventsRemoteDataSourceImpl', () {
    group('getUpcomingEarnings', () {
      test('getUpcomingEarnings_tickersEmpty_returnsEmptyList', () async {
        // act
        final result = await dataSource.getUpcomingEarnings([]);

        // assert
        expect(result, isEmpty);
        verifyZeroInteractions(mockFirestoreService);
      });

      test(
        'getUpcomingEarnings_success_callsFirestoreAndReturnsData',
        () async {
          // arrange
          when(
            () =>
                mockFirestoreService.getCollectionFuture<WatchlistEarningsDto>(
                  path: any(named: 'path'),
                  whereInField: any(named: 'whereInField'),
                  whereInValues: any(named: 'whereInValues'),
                  fromJson: any(named: 'fromJson'),
                  toJson: any(named: 'toJson'),
                ),
          ).thenAnswer((_) async => tEarningsDto);

          // act
          final result = await dataSource.getUpcomingEarnings(tTickers);

          // assert
          expect(result, tEarningsDto);
          verify(
            () =>
                mockFirestoreService.getCollectionFuture<WatchlistEarningsDto>(
                  path: any(named: 'path'),
                  whereInField: any(named: 'whereInField'),
                  whereInValues: tTickers,
                  fromJson: any(named: 'fromJson'),
                  toJson: any(named: 'toJson'),
                ),
          ).called(1);
        },
      );

      test('getUpcomingEarnings_failure_throwsServerException', () async {
        // arrange
        when(
          () => mockFirestoreService.getCollectionFuture<WatchlistEarningsDto>(
            path: any(named: 'path'),
            whereInField: any(named: 'whereInField'),
            whereInValues: any(named: 'whereInValues'),
            fromJson: any(named: 'fromJson'),
            toJson: any(named: 'toJson'),
          ),
        ).thenThrow(Exception('Firestore Error'));

        // act
        final call = dataSource.getUpcomingEarnings(tTickers);

        // assert
        expect(call, throwsA(isA<ServerException>()));
      });
    });

    group('getSecFilings', () {
      test('getSecFilings_success_callsFirestoreAndReturnsData', () async {
        // arrange
        when(
          () => mockFirestoreService.getCollectionFuture<WatchlistFilingDto>(
            path: any(named: 'path'),
            whereInField: any(named: 'whereInField'),
            whereInValues: any(named: 'whereInValues'),
            fromJson: any(named: 'fromJson'),
            toJson: any(named: 'toJson'),
          ),
        ).thenAnswer((_) async => tFilingsDto);

        // act
        final result = await dataSource.getSecFilings(tTickers);

        // assert
        expect(result, tFilingsDto);
      });
    });
  });
}
