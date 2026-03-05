import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/domain/interfaces/i_free_cash_flow_repository.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/domain/models/free_cash_flow_stats.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/domain/usecases/get_free_cash_flow_stats_usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFreeCashFlowRepository extends Mock
    implements IFreeCashFlowRepository {}

void main() {
  late GetFreeCashFlowStatsUseCase useCase;
  late MockIFreeCashFlowRepository mockRepository;

  setUp(() {
    mockRepository = MockIFreeCashFlowRepository();
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
      when(() => mockRepository.getFreeCashFlowStats(tTicker)).thenAnswer(
        (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.cache)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Right((tFcfStats, CompanyProfileDataOrigin.cache)));
      verify(() => mockRepository.getFreeCashFlowStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
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
