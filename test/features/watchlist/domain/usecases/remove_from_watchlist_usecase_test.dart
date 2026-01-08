import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:bizzie/features/watchlist/domain/usecases/remove_from_watchlist_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistRepository extends Mock implements IWatchlistRepository {}

void main() {
  late RemoveFromWatchlistUseCase useCase;
  late MockWatchlistRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistRepository();
    useCase = RemoveFromWatchlistUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  const tUid = 'testUid';
  const tParams = RemoveFromWatchlistParams(ticker: tTicker, uid: tUid);

  test('call_successfulCall_delegatesToRepository', () async {
    // arrange
    when(
      () => mockRepository.removeFromWatchlist(tTicker, tUid),
    ).thenAnswer((_) async => const Right(null));

    // act
    final result = await useCase(tParams);

    // assert
    expect(result, const Right(null));
    verify(() => mockRepository.removeFromWatchlist(tTicker, tUid)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('call_repositoryFailure_returnsLeftFailure', () async {
    // arrange
    final tFailure = ServerFailure('Test Error');
    when(
      () => mockRepository.removeFromWatchlist(tTicker, tUid),
    ).thenAnswer((_) async => Left(tFailure));

    // act
    final result = await useCase(tParams);

    // assert
    expect(result, Left(tFailure));
    verify(() => mockRepository.removeFromWatchlist(tTicker, tUid)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
