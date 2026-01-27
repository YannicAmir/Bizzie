import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/eps/data/repositories/eps_repository_impl.dart';
import 'package:bizzie/features/company_profile/eps/domain/models/eps_stats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFinancialRemoteDataSource extends Mock
    implements FinancialStatementsRemoteDataSource {}

class MockFinancialLocalDataSource extends Mock
    implements FinancialStatementsFirestoreDataSource {}

void main() {
  late EpsRepositoryImpl repository;
  late MockFinancialRemoteDataSource mockRemoteDataSource;
  late MockFinancialLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockFinancialRemoteDataSource();
    mockLocalDataSource = MockFinancialLocalDataSource();
    repository = EpsRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  const tTicker = 'AAPL';

  group('EpsRepositoryImpl', () {
    final tIncomeStatementDto = IncomeStatementDto(
      date: '2023-01-01',
      period: 'FY',
      epsDiluted: 10.0,
      reportedCurrency: 'USD',
      symbol: 'AAPL',
      cik: '0000320193',
      filingDate: '2023-01-01',
      acceptedDate: '2023-01-01',
      fiscalYear: '2022',
    );
    final List<IncomeStatementDto> tIncomeStatements = [tIncomeStatementDto];

    test('getEpsStats_cacheInformationResult_returnsRightWithData', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedIncomeStatements(
          tTicker,
          period: any(named: 'period'),
        ),
      ).thenAnswer((_) async => tIncomeStatements);

      // act
      final result = await repository.getEpsStats(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, isA<EpsStats>());
        expect(r.annualEps.length, 1);
        expect(r.annualEps.first.value, 10.0);
      });
    });

    test('getEpsStats_serverExample_returnLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedIncomeStatements(
          tTicker,
          period: any(named: 'period'),
        ),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getIncomeStatements(
          tTicker,
          period: any(named: 'period'),
        ),
      ).thenThrow(Exception('Server Error'));

      // act
      final result = await repository.getEpsStats(tTicker);

      // assert
      expect(result.isLeft(), true);
    });
  });
}
