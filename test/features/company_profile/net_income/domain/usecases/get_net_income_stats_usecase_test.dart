import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/net_income/domain/interfaces/i_net_income_repository.dart';
import 'package:bizzie/features/company_profile/net_income/domain/models/net_income_stats.dart';
import 'package:bizzie/features/company_profile/net_income/domain/usecases/get_net_income_stats_usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockINetIncomeRepository extends Mock implements INetIncomeRepository {}

void main() {
  late GetNetIncomeStatsUseCase useCase;
  late MockINetIncomeRepository mockRepository;

  setUp(() {
    mockRepository = MockINetIncomeRepository();
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
      when(() => mockRepository.getNetIncomeStats(tTicker)).thenAnswer(
        (_) async =>
            const Right((tNetIncomeStats, CompanyProfileDataOrigin.cache)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      expect(
        result,
        const Right((tNetIncomeStats, CompanyProfileDataOrigin.cache)),
      );
      verify(() => mockRepository.getNetIncomeStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
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
