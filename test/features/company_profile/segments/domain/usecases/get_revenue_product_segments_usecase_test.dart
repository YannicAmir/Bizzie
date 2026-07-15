import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/segments/domain/interfaces/i_segments_repository.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_product_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/usecases/get_revenue_product_segments_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockISegmentsRepository extends Mock implements ISegmentsRepository {}

void main() {
  late GetRevenueProductSegmentsUseCase useCase;
  late MockISegmentsRepository mockRepository;

  setUp(() {
    mockRepository = MockISegmentsRepository();
    useCase = GetRevenueProductSegmentsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  const tProductSegments = RevenueProductSegments(
    symbol: tTicker,
    reportedCurrency: 'USD',
    annual: [],
    quarterly: [],
  );

  group('GetRevenueProductSegmentsUseCase', () {
    test('call_success_returnsProductSegments', () async {
      // arrange
      when(() => mockRepository.getProductSegments(tTicker)).thenAnswer(
        (_) async =>
            const Right((tProductSegments, CompanyProfileDataOrigin.cache)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      expect(
        result,
        const Right((tProductSegments, CompanyProfileDataOrigin.cache)),
      );
      verify(() => mockRepository.getProductSegments(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getProductSegments(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getProductSegments(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
