import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/domain/interfaces/i_watchlist_prices_repository.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/domain/usecases/watch_watchlist_prices_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistPricesRepository extends Mock
    implements IWatchlistPricesRepository {}

const tTickers = ['AXP', 'NVDA'];
const tFailure = Failure.server('error');

const tStockPrice = WatchlistStockPrice(
  ticker: 'AXP',
  companyName: 'American Express Company',
  price: 298.42,
  previousClose: 294.75,
  change: 3.67,
  changePercent: 1.24,
  sessionDate: '2026-07-17',
  series: [WatchlistStockPricePoint(time: '09:30', close: 295.1)],
  closeFinalized: false,
);

void main() {
  late WatchWatchlistPricesUseCase sut;
  late MockWatchlistPricesRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistPricesRepository();
    sut = WatchWatchlistPricesUseCase(mockRepository);
  });

  group('WatchWatchlistPricesUseCase', () {
    test('call_repositoryEmitsRight_emitsRightPrices', () async {
      // arrange
      when(() => mockRepository.watchWatchlistPrices(tTickers)).thenAnswer(
        (_) => Stream.value(
          const Right<Failure, List<WatchlistStockPrice>>([tStockPrice]),
        ),
      );

      // act
      final stream = sut(tTickers);

      // assert
      await expectLater(
        stream,
        emitsInOrder([
          const Right<Failure, List<WatchlistStockPrice>>([tStockPrice]),
          emitsDone,
        ]),
      );
      verify(() => mockRepository.watchWatchlistPrices(tTickers)).called(1);
    });

    test('call_repositoryEmitsLeft_emitsLeftFailure', () async {
      // arrange
      when(() => mockRepository.watchWatchlistPrices(tTickers)).thenAnswer(
        (_) => Stream.value(
          const Left<Failure, List<WatchlistStockPrice>>(tFailure),
        ),
      );

      // act
      final stream = sut(tTickers);

      // assert
      await expectLater(
        stream,
        emitsInOrder([
          const Left<Failure, List<WatchlistStockPrice>>(tFailure),
          emitsDone,
        ]),
      );
    });
  });
}
