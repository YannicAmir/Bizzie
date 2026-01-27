import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistRepository extends Mock implements IWatchlistRepository {}

void main() {
  late GetWatchlistUseCase useCase;
  late MockWatchlistRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistRepository();
    useCase = GetWatchlistUseCase(mockRepository);
  });

  const tUid = 'testUid';
  const tCompanies = [Company(ticker: 'AAPL', name: 'Apple')];

  test('call_repositoryReturnsStream_delegatesSuccessfulStream', () async {
    // arrange
    when(
      () => mockRepository.getWatchlistStream(tUid),
    ).thenAnswer((_) => Stream.value(const Right(tCompanies)));

    // act
    final resultStream = await useCase(tUid);

    // assert
    expect(resultStream, emits(const Right(tCompanies)));
    verify(() => mockRepository.getWatchlistStream(tUid)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('call_repositoryStreamEmitsFailure_delegatesFailureStream', () async {
    // arrange
    final tFailure = Failure.server('Test Error');
    when(
      () => mockRepository.getWatchlistStream(tUid),
    ).thenAnswer((_) => Stream.value(Left(tFailure)));

    // act
    final resultStream = await useCase(tUid);

    // assert
    expect(resultStream, emits(Left(tFailure)));
    verify(() => mockRepository.getWatchlistStream(tUid)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
