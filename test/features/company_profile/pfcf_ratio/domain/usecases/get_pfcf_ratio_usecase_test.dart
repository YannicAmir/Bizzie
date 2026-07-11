import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/interfaces/i_pfcf_ratio_repository.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/models/pfcf_ratio.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/services/pfcf_ratio_stats_service.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/usecases/get_pfcf_ratio_usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIPfcfRatioRepository extends Mock implements IPfcfRatioRepository {}

void main() {
  late GetPfcfRatioUseCase useCase;
  late MockIPfcfRatioRepository mockRepository;

  setUp(() {
    mockRepository = MockIPfcfRatioRepository();
    useCase = GetPfcfRatioUseCase(mockRepository, PfcfRatioStatsService());
  });

  const tTicker = 'AAPL';
  const tRatios = [
    PfcfRatio(
      symbol: tTicker,
      date: '2018-10-01',
      period: 'FY',
      priceToFreeCashFlowRatio: 15.0,
    ),
    PfcfRatio(
      symbol: tTicker,
      date: '2023-09-30',
      period: 'FY',
      priceToFreeCashFlowRatio: 25.0,
    ),
  ];

  group('GetPfcfRatioUseCase', () {
    test('call_success_returnsComputedStatsWithOrigin', () async {
      // arrange
      when(() => mockRepository.getPfcfRatios(tTicker)).thenAnswer(
        (_) async => const Right((tRatios, CompanyProfileDataOrigin.cache)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      final stats = result.fold((_) => null, (tuple) => tuple.$1);
      final origin = result.fold((_) => null, (tuple) => tuple.$2);
      expect(stats, isNotNull);
      expect(stats!.dataPoints.length, 2);
      expect(stats.currentValue, 25.0);
      expect(origin, CompanyProfileDataOrigin.cache);
      verify(() => mockRepository.getPfcfRatios(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_emptyRatios_returnsEmptyStats', () async {
      // arrange
      when(() => mockRepository.getPfcfRatios(tTicker)).thenAnswer(
        (_) async =>
            const Right((<PfcfRatio>[], CompanyProfileDataOrigin.cache)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      final stats = result.fold((_) => null, (tuple) => tuple.$1);
      expect(stats, isNotNull);
      expect(stats!.dataPoints, isEmpty);
      expect(stats.currentValue, 0);
      verify(() => mockRepository.getPfcfRatios(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getPfcfRatios(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getPfcfRatios(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
