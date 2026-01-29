import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_price_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_historical_eod_prices_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIPriceRepository extends Mock implements IPriceRepository {}

void main() {
  late GetHistoricalEodPricesUseCase useCase;
  late MockIPriceRepository mockRepository;

  setUp(() {
    mockRepository = MockIPriceRepository();
    useCase = GetHistoricalEodPricesUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tEodPrices = <HistoricalPriceEod>[];

  group('GetHistoricalEodPricesUseCase', () {
    test('call_success_returnsHistoricalPriceEodList', () async {
      // arrange
      when(
        () => mockRepository.getHistoricalEodPrices(tTicker),
      ).thenAnswer((_) async => Right(tEodPrices));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tEodPrices));
      verify(() => mockRepository.getHistoricalEodPrices(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getHistoricalEodPrices(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getHistoricalEodPrices(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
