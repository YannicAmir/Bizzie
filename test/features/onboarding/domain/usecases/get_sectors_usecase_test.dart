import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/usecases/get_sectors_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements IOnboardingRepository {}

void main() {
  late GetSectorsUseCase useCase;
  late MockOnboardingRepository mockRepository;

  setUp(() {
    mockRepository = MockOnboardingRepository();
    useCase = GetSectorsUseCase(mockRepository);
  });

  const tSectors = [Sector.informationTechnology];

  test('call_success_delegatesToRepository', () async {
    // Arrange
    when(
      () => mockRepository.getSectors(),
    ).thenAnswer((_) async => const Right(tSectors));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, const Right(tSectors));
    verify(() => mockRepository.getSectors()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('call_repositoryFailure_returnsLeftFailure', () async {
    // Arrange
    const tFailure = Failure.server('Server Error');
    when(
      () => mockRepository.getSectors(),
    ).thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.getSectors()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
