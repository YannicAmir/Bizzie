import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/full_financials.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_full_financials_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFinancialRepository extends Mock implements IFinancialRepository {}

void main() {
  late GetFullFinancialsUseCase useCase;
  late MockIFinancialRepository mockRepository;

  setUp(() {
    mockRepository = MockIFinancialRepository();
    useCase = GetFullFinancialsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tFullFinancials = FullFinancials(
    annualIncomeStatements: [],
    quarterlyIncomeStatements: [],
    annualBalanceSheets: [],
    quarterlyBalanceSheets: [],
    annualCashFlows: [],
    quarterlyCashFlows: [],
  );

  group('GetFullFinancialsUseCase', () {
    test('call_success_returnsFullFinancials', () async {
      // arrange
      when(
        () => mockRepository.getFullFinancials(tTicker),
      ).thenAnswer((_) async => Right(tFullFinancials));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tFullFinancials));
      verify(() => mockRepository.getFullFinancials(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getFullFinancials(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getFullFinancials(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
