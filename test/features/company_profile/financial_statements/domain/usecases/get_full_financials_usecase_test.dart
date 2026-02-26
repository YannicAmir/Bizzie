import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/interfaces/i_financial_statements_repository.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/full_financials.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/usecases/get_full_financials_usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIFinancialStatementsRepository extends Mock
    implements IFinancialStatementsRepository {}

void main() {
  late GetFullFinancialsUseCase useCase;
  late MockIFinancialStatementsRepository mockRepository;

  setUp(() {
    mockRepository = MockIFinancialStatementsRepository();
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
      when(() => mockRepository.getFullFinancials(tTicker)).thenAnswer(
        (_) async => Right((tFullFinancials, CompanyProfileDataOrigin.cache)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right((tFullFinancials, CompanyProfileDataOrigin.cache)));
      verify(() => mockRepository.getFullFinancials(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
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
