import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/dividend_info.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_dividend_info_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFinancialRepository extends Mock implements IFinancialRepository {}

void main() {
  late GetDividendInfoUseCase useCase;
  late MockIFinancialRepository mockRepository;

  setUp(() {
    mockRepository = MockIFinancialRepository();
    useCase = GetDividendInfoUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tDividendInfo = DividendInfo(symbol: tTicker, history: []);

  group('GetDividendInfoUseCase', () {
    test('call_success_returnsDividendInfo', () async {
      // arrange
      when(
        () => mockRepository.getDividendInfo(tTicker),
      ).thenAnswer((_) async => Right(tDividendInfo));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tDividendInfo));
      verify(() => mockRepository.getDividendInfo(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getDividendInfo(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getDividendInfo(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
