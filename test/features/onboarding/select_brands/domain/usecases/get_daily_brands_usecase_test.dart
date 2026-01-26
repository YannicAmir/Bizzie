import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/interfaces/i_select_brands_repository.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand_listing.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/usecases/get_daily_brands_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockISelectBrandsRepository extends Mock
    implements ISelectBrandsRepository {}

void main() {
  late GetDailyBrandsUseCase useCase;
  late MockISelectBrandsRepository mockRepository;

  setUp(() {
    mockRepository = MockISelectBrandsRepository();
    useCase = GetDailyBrandsUseCase(mockRepository);
  });

  final tBrandListing = BrandListing(globalBrands: [], sectorBrands: []);

  group('GetDailyBrandsUseCase', () {
    test('execute_validParams_returnsBrandsFromRepository', () async {
      // arrange
      when(
        () => mockRepository.getDailyBrands(any()),
      ).thenAnswer((_) async => Right(tBrandListing));

      // act
      final result = await useCase(const GetDailyBrandsParams(sector: null));

      // assert
      expect(result, Right(tBrandListing));
      verify(() => mockRepository.getDailyBrands(null)).called(1);
    });

    test('execute_repositoryFailure_returnsFailure', () async {
      // arrange
      const tFailure = ServerFailure('error');
      when(
        () => mockRepository.getDailyBrands(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(const GetDailyBrandsParams(sector: null));

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getDailyBrands(null)).called(1);
    });
  });
}
