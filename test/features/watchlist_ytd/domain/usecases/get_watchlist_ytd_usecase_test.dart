import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/watchlist_ytd/domain/interfaces/i_watchlist_ytd_repository.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:bizzie/features/watchlist_ytd/domain/usecases/get_watchlist_ytd_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistYtdRepository extends Mock
    implements IWatchlistYtdRepository {}

const tTickers = ['FTNT', 'NVDA'];
const tFailure = Failure.server('error');

const tYtd = YtdPriceChange(
  ticker: 'FTNT',
  companyName: 'Fortinet, Inc.',
  year: 2026,
  baselineDate: '2025-12-31',
  baselineClose: 79.41,
  latestDate: '2026-07-21',
  latestClose: 158.1,
  ytdChange: 78.69,
  ytdChangePercent: 99.09,
);

void main() {
  late GetWatchlistYtdUseCase sut;
  late MockWatchlistYtdRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistYtdRepository();
    sut = GetWatchlistYtdUseCase(mockRepository);
  });

  group('GetWatchlistYtdUseCase', () {
    test('call_repositoryReturnsRight_returnsRightChanges', () async {
      // arrange
      when(
        () => mockRepository.getWatchlistYtd(tTickers),
      ).thenAnswer((_) async => const Right([tYtd]));

      // act
      final result = await sut(tTickers);

      // assert
      expect(result, const Right<Failure, List<YtdPriceChange>>([tYtd]));
      verify(() => mockRepository.getWatchlistYtd(tTickers)).called(1);
    });

    test('call_repositoryReturnsLeft_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockRepository.getWatchlistYtd(tTickers),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await sut(tTickers);

      // assert
      expect(result, const Left<Failure, List<YtdPriceChange>>(tFailure));
    });
  });
}
