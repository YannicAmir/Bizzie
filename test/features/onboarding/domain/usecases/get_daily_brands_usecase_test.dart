import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/usecases/get_daily_brands_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements IOnboardingRepository {}

void main() {
  late GetDailyBrandsUseCase useCase;
  late MockOnboardingRepository mockRepository;

  setUp(() {
    mockRepository = MockOnboardingRepository();
    useCase = GetDailyBrandsUseCase(mockRepository);
  });

  const tSector = Sector.informationTechnology;
  final tGlobalBrands = [
    Brand(
      name: 'Global',
      company: 'Global Inc',
      ticker: 'GLB',
      sector: 'All Sectors',
      description: 'Desc',
    ),
  ];
  final tSectorBrands = [
    Brand(
      name: 'Sector',
      company: 'Sector Inc',
      ticker: 'SEC',
      sector: 'Information Technology',
      description: 'Desc',
    ),
  ];

  test('call_success_delegatesToRepository', () async {
    // Arrange
    when(
      () => mockRepository.getDailyBrands(any()),
    ).thenAnswer((_) async => Right((tGlobalBrands, tSectorBrands)));

    // Act
    final result = await useCase(const GetDailyBrandsParams(sector: tSector));

    // Assert
    expect(result, Right((tGlobalBrands, tSectorBrands)));
    verify(() => mockRepository.getDailyBrands(tSector)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('call_repositoryFailure_returnsLeftFailure', () async {
    // Arrange
    const tFailure = ServerFailure('Server Error');
    when(
      () => mockRepository.getDailyBrands(any()),
    ).thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(const GetDailyBrandsParams(sector: tSector));

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.getDailyBrands(tSector)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
