import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:bizzie/features/watchlist/domain/models/add_to_watchlist_params.dart';
import 'package:bizzie/features/watchlist/domain/usecases/add_to_watchlist_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistRepository extends Mock implements IWatchlistRepository {}

void main() {
  late AddToWatchlistUseCase useCase;
  late MockWatchlistRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistRepository();
    useCase = AddToWatchlistUseCase(mockRepository);
  });

  const tCompany = Company(ticker: 'AAPL', name: 'Apple');
  const tUid = 'testUi';
  const tParams = AddToWatchlistParams(company: tCompany, uid: tUid);

  test('execute_successfulCall_delegatesToRepository', () async {
    // arrange
    when(
      () => mockRepository.addToWatchlist(tCompany, tUid),
    ).thenAnswer((_) async => const Right(null));

    // act
    final result = await useCase(tParams);

    // assert
    expect(result, const Right(null));
    verify(() => mockRepository.addToWatchlist(tCompany, tUid)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('execute_repositoryFailure_returnsFailure', () async {
    // arrange
    final tFailure = Failure.server('Test Error');
    when(
      () => mockRepository.addToWatchlist(tCompany, tUid),
    ).thenAnswer((_) async => Left(tFailure));

    // act
    final result = await useCase(tParams);

    // assert
    expect(result, Left(tFailure));
    verify(() => mockRepository.addToWatchlist(tCompany, tUid)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
