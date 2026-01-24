import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/key_metrics.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_key_metrics_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFinancialRepository extends Mock implements IFinancialRepository {}

void main() {
  late GetKeyMetricsUseCase useCase;
  late MockIFinancialRepository mockRepository;

  setUp(() {
    mockRepository = MockIFinancialRepository();
    useCase = GetKeyMetricsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tKeyMetricsList = <KeyMetrics>[];

  group('GetKeyMetricsUseCase', () {
    test('call_success_returnsKeyMetricsList', () async {
      // arrange
      when(
        () => mockRepository.getKeyMetrics(tTicker),
      ).thenAnswer((_) async => Right(tKeyMetricsList));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tKeyMetricsList));
      verify(() => mockRepository.getKeyMetrics(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getKeyMetrics(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getKeyMetrics(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
