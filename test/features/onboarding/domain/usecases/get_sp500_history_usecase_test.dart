import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/usecases/get_sp500_history_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements IOnboardingRepository {}

void main() {
  late GetSp500HistoryUseCase useCase;
  late MockOnboardingRepository mockRepository;

  setUp(() {
    mockRepository = MockOnboardingRepository();
    useCase = GetSp500HistoryUseCase(mockRepository);
  });

  final tHistory = [
    HistoricalPrice(
      symbol: 'SP500',
      date: '2025-01-01',
      price: 100.0,
      volume: 1000,
    ),
  ];

  test('call_success_delegatesToRepository', () async {
    // Arrange
    when(
      () => mockRepository.getSp500History(),
    ).thenAnswer((_) async => Right(tHistory));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, Right(tHistory));
    verify(() => mockRepository.getSp500History()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('call_repositoryFailure_returnsLeftFailure', () async {
    // Arrange
    const tFailure = ServerFailure('Server Error');
    when(
      () => mockRepository.getSp500History(),
    ).thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.getSp500History()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
