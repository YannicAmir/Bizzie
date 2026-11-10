import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/features/home/data/datasources/watchlist_prices_remote_datasource.dart';
import 'package:bizzie/features/home/data/dtos/watchlist_stock_price_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

const tTickers = ['AXP', 'NVDA'];
const tDto = WatchlistStockPriceDto(
  ticker: 'AXP',
  companyName: 'American Express Company',
  price: 298.42,
  sessionDate: '2026-07-17',
);
const tUpdatedDto = WatchlistStockPriceDto(
  ticker: 'AXP',
  companyName: 'American Express Company',
  price: 299.10,
  sessionDate: '2026-07-17',
);
final tException = Exception('firestore failed');
final tPermissionDenied = FirebaseException(
  plugin: 'cloud_firestore',
  code: 'permission-denied',
);

void main() {
  late MockFirestoreService mockFirestoreService;
  late WatchlistPricesRemoteDataSource sut;

  void stubChunkedStream(Stream<List<WatchlistStockPriceDto>> stream) {
    when(
      () => mockFirestoreService
          .getCollectionStreamChunked<WatchlistStockPriceDto>(
            path: any(named: 'path'),
            whereInField: any(named: 'whereInField'),
            values: any(named: 'values'),
            fromJson: any(named: 'fromJson'),
          ),
    ).thenAnswer((_) => stream);
  }

  setUp(() {
    mockFirestoreService = MockFirestoreService();
    sut = WatchlistPricesRemoteDataSource(mockFirestoreService);
  });

  group('WatchlistPricesRemoteDataSource', () {
    group('getWatchlistPricesStream', () {
      test(
        'getWatchlistPricesStream_snapshotsUpdate_emitsEachSnapshot',
        () async {
          // arrange
          stubChunkedStream(
            Stream.fromIterable([
              [tDto],
              [tUpdatedDto],
            ]),
          );

          // act
          final stream = sut.getWatchlistPricesStream(tTickers);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              [tDto],
              [tUpdatedDto],
              emitsDone,
            ]),
          );
        },
      );

      test('getWatchlistPricesStream_called_queriesStockPricesByTicker', () {
        // arrange
        stubChunkedStream(Stream.value([tDto]));

        // act
        sut.getWatchlistPricesStream(tTickers);

        // assert
        verify(
          () => mockFirestoreService
              .getCollectionStreamChunked<WatchlistStockPriceDto>(
                path: FirestoreConstants.stockPrices,
                whereInField: FirestoreConstants.ticker,
                values: tTickers,
                fromJson: any(named: 'fromJson'),
              ),
        ).called(1);
      });

      test('getWatchlistPricesStream_streamErrors_rethrowsError', () async {
        // arrange
        stubChunkedStream(Stream.error(tException));

        // act
        final stream = sut.getWatchlistPricesStream(tTickers);

        // assert
        await expectLater(stream, emitsError(tException));
      });

      test(
        'getWatchlistPricesStream_permissionDenied_throwsPermissionDeniedException',
        () async {
          // arrange
          stubChunkedStream(Stream.error(tPermissionDenied));

          // act
          final stream = sut.getWatchlistPricesStream(tTickers);

          // assert
          await expectLater(
            stream,
            emitsError(isA<PermissionDeniedException>()),
          );
        },
      );
    });
  });
}
