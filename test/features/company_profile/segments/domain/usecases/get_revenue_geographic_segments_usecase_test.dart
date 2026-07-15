import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/segments/domain/interfaces/i_segments_repository.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_geographic_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/usecases/get_revenue_geographic_segments_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockISegmentsRepository extends Mock implements ISegmentsRepository {}

void main() {
  late GetRevenueGeographicSegmentsUseCase useCase;
  late MockISegmentsRepository mockRepository;

  setUp(() {
    mockRepository = MockISegmentsRepository();
    useCase = GetRevenueGeographicSegmentsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  const tGeographicSegments = RevenueGeographicSegments(
    symbol: tTicker,
    reportedCurrency: 'USD',
    annual: [],
    quarterly: [],
  );

  group('GetRevenueGeographicSegmentsUseCase', () {
    test('call_success_returnsGeographicSegments', () async {
      // arrange
      when(() => mockRepository.getGeographicSegments(tTicker)).thenAnswer(
        (_) async =>
            const Right((tGeographicSegments, CompanyProfileDataOrigin.api)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      expect(
        result,
        const Right((tGeographicSegments, CompanyProfileDataOrigin.api)),
      );
      verify(() => mockRepository.getGeographicSegments(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getGeographicSegments(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getGeographicSegments(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
