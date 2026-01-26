import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/fcps/domain/interfaces/i_fcps_repository.dart';
import 'package:bizzie/features/company_profile/fcps/domain/models/fcps_stats.dart';
import 'package:bizzie/features/company_profile/fcps/domain/usecases/get_fcps_stats_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFcpsRepository extends Mock implements IFcpsRepository {}

void main() {
  late GetFcpsStatsUseCase useCase;
  late MockIFcpsRepository mockRepository;

  setUp(() {
    mockRepository = MockIFcpsRepository();
    useCase = GetFcpsStatsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  const tFcpsStats = FcpsStats(
    reportedCurrency: 'USD',
    annualFcps: [],
    quarterlyFcps: [],
  );

  group('GetFcpsStatsUseCase', () {
    test('call_success_returnsFcpsStats', () async {
      // arrange
      when(
        () => mockRepository.getFcpsStats(tTicker),
      ).thenAnswer((_) async => const Right(tFcpsStats));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Right(tFcpsStats));
      verify(() => mockRepository.getFcpsStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getFcpsStats(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getFcpsStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
