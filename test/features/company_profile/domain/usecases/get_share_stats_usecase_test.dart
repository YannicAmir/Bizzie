import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_security_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/share_stats.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_share_stats_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockISecurityRepository extends Mock implements ISecurityRepository {}

void main() {
  late GetShareStatsUseCase useCase;
  late MockISecurityRepository mockRepository;

  setUp(() {
    mockRepository = MockISecurityRepository();
    useCase = GetShareStatsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  const tShareStats = ShareStats(
    currentSharesOutstanding: 16000000000.0,
    annualWeightedAverageShares: [],
    quarterlyWeightedAverageShares: [],
  );

  group('GetShareStatsUseCase', () {
    test('call_success_returnsShareStats', () async {
      // arrange
      when(
        () => mockRepository.getShareStats(tTicker),
      ).thenAnswer((_) async => const Right(tShareStats));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Right(tShareStats));
      verify(() => mockRepository.getShareStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getShareStats(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getShareStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
