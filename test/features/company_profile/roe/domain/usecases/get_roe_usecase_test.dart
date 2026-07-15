import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/roe/domain/interfaces/i_roe_repository.dart';
import 'package:bizzie/features/company_profile/roe/domain/models/roe.dart';
import 'package:bizzie/features/company_profile/roe/domain/services/roe_stats_service.dart';
import 'package:bizzie/features/company_profile/roe/domain/usecases/get_roe_usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIRoeRepository extends Mock implements IRoeRepository {}

void main() {
  late GetRoeUseCase useCase;
  late MockIRoeRepository mockRepository;

  setUp(() {
    mockRepository = MockIRoeRepository();
    useCase = GetRoeUseCase(mockRepository, RoeStatsService());
  });

  const tTicker = 'AAPL';
  const tRoeList = [
    Roe(symbol: tTicker, date: '2018-10-01', period: 'FY', returnOnEquity: 0.35),
    Roe(symbol: tTicker, date: '2023-09-30', period: 'FY', returnOnEquity: 0.45),
  ];

  group('GetRoeUseCase', () {
    test('call_success_returnsComputedStatsWithOrigin', () async {
      // arrange
      when(() => mockRepository.getRoeMetrics(tTicker)).thenAnswer(
        (_) async => const Right((tRoeList, CompanyProfileDataOrigin.cache)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      final stats = result.fold((_) => null, (tuple) => tuple.$1);
      final origin = result.fold((_) => null, (tuple) => tuple.$2);
      expect(stats, isNotNull);
      expect(stats!.dataPoints.length, 2);
      expect(stats.currentValue, 0.45);
      expect(origin, CompanyProfileDataOrigin.cache);
      verify(() => mockRepository.getRoeMetrics(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_emptyMetrics_returnsEmptyStats', () async {
      // arrange
      when(() => mockRepository.getRoeMetrics(tTicker)).thenAnswer(
        (_) async => const Right((<Roe>[], CompanyProfileDataOrigin.cache)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      final stats = result.fold((_) => null, (tuple) => tuple.$1);
      expect(stats, isNotNull);
      expect(stats!.dataPoints, isEmpty);
      expect(stats.currentValue, 0);
      verify(() => mockRepository.getRoeMetrics(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getRoeMetrics(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getRoeMetrics(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
