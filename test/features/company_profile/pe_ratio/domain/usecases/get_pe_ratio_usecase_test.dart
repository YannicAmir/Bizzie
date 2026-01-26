import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/interfaces/i_pe_ratio_repository.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/models/pe_ratio.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/usecases/get_pe_ratio_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIPeRatioRepository extends Mock implements IPeRatioRepository {}

void main() {
  late GetPeRatioUseCase useCase;
  late MockIPeRatioRepository mockRepository;

  setUp(() {
    mockRepository = MockIPeRatioRepository();
    useCase = GetPeRatioUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tRatiosList = <PeRatio>[];

  group('GetPeRatioUseCase', () {
    test('call_success_returnsRatiosList', () async {
      // arrange
      when(
        () => mockRepository.getPeRatios(tTicker),
      ).thenAnswer((_) async => Right(tRatiosList));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tRatiosList));
      verify(() => mockRepository.getPeRatios(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getPeRatios(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getPeRatios(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
