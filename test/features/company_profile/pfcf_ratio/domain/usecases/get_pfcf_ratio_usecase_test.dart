import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/interfaces/i_pfcf_ratio_repository.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/models/pfcf_ratio.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/usecases/get_pfcf_ratio_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIPfcfRatioRepository extends Mock implements IPfcfRatioRepository {}

void main() {
  late GetPfcfRatioUseCase useCase;
  late MockIPfcfRatioRepository mockRepository;

  setUp(() {
    mockRepository = MockIPfcfRatioRepository();
    useCase = GetPfcfRatioUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tRatiosList = <PfcfRatio>[];

  group('GetPfcfRatioUseCase', () {
    test('call_success_returnsRatiosList', () async {
      // arrange
      when(
        () => mockRepository.getPfcfRatios(tTicker),
      ).thenAnswer((_) async => Right(tRatiosList));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tRatiosList));
      verify(() => mockRepository.getPfcfRatios(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getPfcfRatios(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getPfcfRatios(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
