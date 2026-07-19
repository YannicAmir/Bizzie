import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/data/dtos/watchlist_stock_price_dto.dart';
import 'package:bizzie/features/home/data/interfaces/i_watchlist_prices_remote_datasource.dart';
import 'package:bizzie/features/home/data/repositories/watchlist_prices_repository_impl.dart';
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

void main() {
  late WatchlistPricesRepositoryImpl sut;
  late MockWatchlistPricesRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockWatchlistPricesRemoteDataSource();
    sut = WatchlistPricesRepositoryImpl(mockRemoteDataSource);
  });

  group('WatchlistPricesRepositoryImpl', () {
    group('getWatchlistPrices', () {
      test(
        'getWatchlistPrices_datasourceReturnsDtos_returnsRightDomainModels',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistPrices(tTickers),
          ).thenAnswer((_) async => [tDto]);

          // act
          final result = await sut.getWatchlistPrices(tTickers);

          // assert
          expect(result.isRight(), isTrue);
          expect(result.getOrElse(() => []), [tDto.toDomain()]);
        },
      );

      test(
        'getWatchlistPrices_emptyTickers_returnsRightEmptyList',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistPrices([]),
          ).thenAnswer((_) async => []);

          // act
          final result = await sut.getWatchlistPrices([]);

          // assert
          expect(result.isRight(), isTrue);
          expect(result.getOrElse(() => [tDto.toDomain()]), isEmpty);
        },
      );

      test(
        'getWatchlistPrices_datasourceThrows_returnsLeftServerFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistPrices(tTickers),
          ).thenThrow(Exception('firestore down'));

          // act
          final result = await sut.getWatchlistPrices(tTickers);

          // assert
          expect(result.isLeft(), isTrue);
          result.fold(
            (failure) => expect(failure, isA<Failure>()),
            (_) => fail('Expected Left'),
          );
        },
      );
    });
  });
}
