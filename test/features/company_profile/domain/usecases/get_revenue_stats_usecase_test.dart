import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/revenue_stats.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_revenue_stats_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFinancialRepository extends Mock implements IFinancialRepository {}

void main() {
  late GetRevenueStatsUseCase useCase;
  late MockIFinancialRepository mockRepository;

  setUp(() {
    mockRepository = MockIFinancialRepository();
    useCase = GetRevenueStatsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  const tRevenueStats = RevenueStats(
    reportedCurrency: 'USD',
    annualRevenue: [],
    quarterlyRevenue: [],
  );

  group('GetRevenueStatsUseCase', () {
    test('call_success_returnsRevenueStats', () async {
      // arrange
      when(
        () => mockRepository.getRevenueStats(tTicker),
      ).thenAnswer((_) async => const Right(tRevenueStats));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Right(tRevenueStats));
      verify(() => mockRepository.getRevenueStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getRevenueStats(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getRevenueStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
