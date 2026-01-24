import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/company_ratios.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_ratios_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFinancialRepository extends Mock implements IFinancialRepository {}

void main() {
  late GetRatiosUseCase useCase;
  late MockIFinancialRepository mockRepository;

  setUp(() {
    mockRepository = MockIFinancialRepository();
    useCase = GetRatiosUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tRatiosList = <CompanyRatios>[];

  group('GetRatiosUseCase', () {
    test('call_success_returnsRatiosList', () async {
      // arrange
      when(
        () => mockRepository.getRatios(tTicker),
      ).thenAnswer((_) async => Right(tRatiosList));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tRatiosList));
      verify(() => mockRepository.getRatios(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getRatios(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getRatios(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
