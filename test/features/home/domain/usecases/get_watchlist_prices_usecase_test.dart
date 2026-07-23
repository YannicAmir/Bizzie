import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/domain/interfaces/i_watchlist_prices_repository.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/domain/usecases/get_watchlist_prices_usecase.dart';
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
  late GetWatchlistPricesUseCase sut;
  late MockWatchlistPricesRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistPricesRepository();
    sut = GetWatchlistPricesUseCase(mockRepository);
  });

  group('GetWatchlistPricesUseCase', () {
    test(
      'call_repositoryReturnsRight_returnsRightPrices',
      () async {
        // arrange
        when(
          () => mockRepository.getWatchlistPrices(tTickers),
        ).thenAnswer((_) async => const Right([tStockPrice]));

        // act
        final result = await sut(tTickers);

        // assert
        expect(result, const Right<Failure, List<WatchlistStockPrice>>([tStockPrice]));
        verify(() => mockRepository.getWatchlistPrices(tTickers)).called(1);
      },
    );

    test(
      'call_repositoryReturnsLeft_returnsLeftFailure',
      () async {
        // arrange
        when(
          () => mockRepository.getWatchlistPrices(tTickers),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await sut(tTickers);

        // assert
        expect(result, const Left<Failure, List<WatchlistStockPrice>>(tFailure));
      },
    );
  });
}
