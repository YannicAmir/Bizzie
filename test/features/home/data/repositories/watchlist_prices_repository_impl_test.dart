import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/data/dtos/watchlist_stock_price_dto.dart';
import 'package:bizzie/features/home/data/interfaces/i_watchlist_prices_remote_datasource.dart';
import 'package:bizzie/features/home/data/repositories/watchlist_prices_repository_impl.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistPricesRemoteDataSource extends Mock
    implements IWatchlistPricesRemoteDataSource {}

const tTickers = ['AXP', 'NVDA'];

const tDto = WatchlistStockPriceDto(
  ticker: 'AXP',
  companyName: 'American Express Company',
  price: 298.42,
  previousClose: 294.75,
  change: 3.67,
  changePercent: 1.24,
  sessionDate: '2026-07-17',
  series: [StockPricePointDto(t: '09:30', c: 295.1)],
  closeFinalized: false,
);

const tUpdatedDto = WatchlistStockPriceDto(
  ticker: 'AXP',
  companyName: 'American Express Company',
  price: 299.10,
  previousClose: 294.75,
  change: 4.35,
  changePercent: 1.48,
  sessionDate: '2026-07-17',
  series: [StockPricePointDto(t: '09:30', c: 295.1)],
  closeFinalized: false,
);

Matcher isRightPrices(List<WatchlistStockPrice> expected) =>
    predicate<Either<Failure, List<WatchlistStockPrice>>>(
      (result) => result.fold(
        (_) => false,
        (prices) =>
            const ListEquality<WatchlistStockPrice>().equals(prices, expected),
      ),
      'Right($expected)',
    );

void main() {
  late WatchlistPricesRepositoryImpl sut;
  late MockWatchlistPricesRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockWatchlistPricesRemoteDataSource();
    sut = WatchlistPricesRepositoryImpl(mockRemoteDataSource);
  });

  group('WatchlistPricesRepositoryImpl', () {
    group('watchWatchlistPrices', () {
      test(
        'watchWatchlistPrices_datasourceEmitsDtos_emitsRightDomainModels',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistPricesStream(tTickers),
          ).thenAnswer((_) => Stream.value([tDto]));

          // act
          final stream = sut.watchWatchlistPrices(tTickers);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              isRightPrices([tDto.toDomain()]),
              emitsDone,
            ]),
          );
        },
      );

      test(
        'watchWatchlistPrices_datasourceEmitsUpdates_emitsEachMappedSnapshot',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistPricesStream(tTickers),
          ).thenAnswer(
            (_) => Stream.fromIterable([
              [tDto],
              [tUpdatedDto],
            ]),
          );

          // act
          final stream = sut.watchWatchlistPrices(tTickers);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              isRightPrices([tDto.toDomain()]),
              isRightPrices([tUpdatedDto.toDomain()]),
              emitsDone,
            ]),
          );
        },
      );

      test('watchWatchlistPrices_emptyTickers_emitsRightEmptyList', () async {
        // arrange
        when(
          () => mockRemoteDataSource.getWatchlistPricesStream([]),
        ).thenAnswer((_) => Stream.value([]));

        // act
        final stream = sut.watchWatchlistPrices([]);

        // assert
        await expectLater(stream, emitsInOrder([isRightPrices([]), emitsDone]));
      });

      test(
        'watchWatchlistPrices_datasourceStreamErrors_emitsLeftServerFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistPricesStream(tTickers),
          ).thenAnswer((_) => Stream.error(Exception('firestore down')));

          // act
          final stream = sut.watchWatchlistPrices(tTickers);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              const Left<Failure, List<WatchlistStockPrice>>(
                Failure.server('Exception: firestore down'),
              ),
              emitsDone,
            ]),
          );
        },
      );

      test(
        'watchWatchlistPrices_datasourcePermissionDenied_emitsLeftPermissionFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistPricesStream(tTickers),
          ).thenAnswer((_) => Stream.error(PermissionDeniedException()));

          // act
          final stream = sut.watchWatchlistPrices(tTickers);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              const Left<Failure, List<WatchlistStockPrice>>(
                Failure.permission(),
              ),
              emitsDone,
            ]),
          );
        },
      );
    });
  });
}
