import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_price_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/price_history.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_price_history_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIPriceRepository extends Mock implements IPriceRepository {}

void main() {
  late GetPriceHistoryUseCase useCase;
  late MockIPriceRepository mockRepository;

  setUp(() {
    mockRepository = MockIPriceRepository();
    useCase = GetPriceHistoryUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tPriceHistory = PriceHistory(symbol: tTicker, history: []);

  group('GetPriceHistoryUseCase', () {
    test('call_success_returnsPriceHistory', () async {
      // arrange
      when(
        () => mockRepository.getPriceHistory(tTicker),
      ).thenAnswer((_) async => Right(tPriceHistory));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tPriceHistory));
      verify(() => mockRepository.getPriceHistory(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getPriceHistory(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getPriceHistory(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
