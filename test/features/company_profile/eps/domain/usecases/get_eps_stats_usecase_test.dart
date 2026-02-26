import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/eps/domain/interfaces/i_eps_repository.dart';
import 'package:bizzie/features/company_profile/eps/domain/models/eps_stats.dart';
import 'package:bizzie/features/company_profile/eps/domain/usecases/get_eps_stats_usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIEpsRepository extends Mock implements IEpsRepository {}

void main() {
  late GetEpsStatsUseCase useCase;
  late MockIEpsRepository mockRepository;

  setUp(() {
    mockRepository = MockIEpsRepository();
    useCase = GetEpsStatsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  const tEpsStats = EpsStats(
    reportedCurrency: 'USD',
    annualEps: [],
    quarterlyEps: [],
  );

  group('GetEpsStatsUseCase', () {
    test('call_success_returnsEpsStats', () async {
      // Arrange
      when(() => mockRepository.getEpsStats(tTicker)).thenAnswer(
        (_) async => const Right((tEpsStats, CompanyProfileDataOrigin.cache)),
      );

      // Act
      final result = await useCase(tTicker);

      // Assert
      expect(result, const Right((tEpsStats, CompanyProfileDataOrigin.cache)));
      verify(() => mockRepository.getEpsStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // Arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getEpsStats(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(tTicker);

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getEpsStats(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
