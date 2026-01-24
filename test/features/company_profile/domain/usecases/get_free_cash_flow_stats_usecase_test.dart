import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/free_cash_flow_stats.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_free_cash_flow_stats_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFinancialRepository extends Mock implements IFinancialRepository {}

void main() {
  late GetFreeCashFlowStatsUseCase useCase;
  late MockIFinancialRepository mockRepository;

  setUp(() {
    mockRepository = MockIFinancialRepository();
    useCase = GetFreeCashFlowStatsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  const tFcfStats = FreeCashFlowStats(
    reportedCurrency: 'USD',
    annualFcf: [],
    quarterlyFcf: [],
  );

  group('GetFreeCashFlowStatsUseCase', () {
    test('call_success_returnsFreeCashFlowStats', () async {
      // arrange
      when(
        () => mockRepository.getFreeCashFlowStats(tTicker),
      ).thenAnswer((_) async => const Right(tFcfStats));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Right(tFcfStats));
      verify(() => mockRepository.getFreeCashFlowStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getFreeCashFlowStats(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getFreeCashFlowStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
