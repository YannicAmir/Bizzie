import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/net_income_stats.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_net_income_stats_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFinancialRepository extends Mock implements IFinancialRepository {}

void main() {
  late GetNetIncomeStatsUseCase useCase;
  late MockIFinancialRepository mockRepository;

  setUp(() {
    mockRepository = MockIFinancialRepository();
    useCase = GetNetIncomeStatsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  const tNetIncomeStats = NetIncomeStats(
    reportedCurrency: 'USD',
    annualNetIncome: [],
    quarterlyNetIncome: [],
  );

  group('GetNetIncomeStatsUseCase', () {
    test('call_success_returnsNetIncomeStats', () async {
      // arrange
      when(
        () => mockRepository.getNetIncomeStats(tTicker),
      ).thenAnswer((_) async => const Right(tNetIncomeStats));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Right(tNetIncomeStats));
      verify(() => mockRepository.getNetIncomeStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getNetIncomeStats(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getNetIncomeStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
