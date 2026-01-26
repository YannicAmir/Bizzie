import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/net_income/data/repositories/net_income_repository_impl.dart';
import 'package:bizzie/features/company_profile/net_income/domain/models/net_income_stats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements CompanyRemoteDataSource {}

class MockLocalDataSource extends Mock implements CompanyFirestoreDataSource {}

void main() {
  late NetIncomeRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = NetIncomeRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  const tTicker = 'AAPL';

  group('NetIncomeRepositoryImpl', () {
    final tIncomeStatementDto = IncomeStatementDto(
      date: '2023-01-01',
      period: 'FY',
      netIncome: 100.0,
      reportedCurrency: 'USD',
      symbol: 'AAPL',
      cik: '0000320193',
      filingDate: '2023-01-01',
      acceptedDate: '2023-01-01',
      fiscalYear: '2022',
    );
    final List<IncomeStatementDto> tIncomeStatements = [tIncomeStatementDto];

    test(
      'getNetIncomeStats_cacheInformationResult_returnsRightWithData',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getCachedIncomeStatements(
            tTicker,
            period: any(named: 'period'),
          ),
        ).thenAnswer((_) async => tIncomeStatements);

        // act
        final result = await repository.getNetIncomeStats(tTicker);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('Should return right'), (r) {
          expect(r, isA<NetIncomeStats>());
          expect(r.annualNetIncome.length, 1);
          expect(r.annualNetIncome.first.value, 100.0);
        });
      },
    );

    test('getNetIncomeStats_serverExample_returnLeftFailure', () async {
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
      final result = await repository.getNetIncomeStats(tTicker);

      // assert
      expect(result.isLeft(), true);
    });
  });
}
