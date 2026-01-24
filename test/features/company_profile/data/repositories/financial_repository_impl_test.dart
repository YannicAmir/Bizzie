import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/market_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/repositories/financial_repository_impl.dart';
import 'package:bizzie/features/company_profile/domain/models/dividend_info.dart';
import 'package:bizzie/features/company_profile/domain/models/revenue_stats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements CompanyRemoteDataSource {}

class MockLocalDataSource extends Mock implements CompanyFirestoreDataSource {}

void main() {
  late FinancialRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = FinancialRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  const tTicker = 'AAPL';

  group('FinancialRepositoryImpl - DividendInfo', () {
    final tDividendDto = DividendDto(
      date: '2023-01-01',
      dividend: 0.23,
      adjDividend: 0.23,
      recordDate: '2023-01-02',
      paymentDate: '2023-01-15',
      declarationDate: '2022-12-15',
    );
    final List<DividendDto> tDividendsList = [tDividendDto];

    test(
      'getDividendInfo_cacheInformationResult_returnsRightWithData',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getCachedDividends(tTicker),
        ).thenAnswer((_) async => tDividendsList);

        // act
        final result = await repository.getDividendInfo(tTicker);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('Should return right'), (r) {
          expect(r, isA<DividendInfo>());
          expect(r.history.length, 1);
          expect(r.history.first.dividend, 0.23);
        });
        verify(() => mockLocalDataSource.getCachedDividends(tTicker)).called(1);
        verifyZeroInteractions(mockRemoteDataSource);
      },
    );

    test(
      'getDividendInfo_cacheMiss_fetchesFromRemoteAndCaches_returnsRightWithData',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getCachedDividends(tTicker),
        ).thenAnswer((_) async => null);
        when(
          () => mockRemoteDataSource.getDividends(tTicker),
        ).thenAnswer((_) async => tDividendsList);
        when(
          () => mockLocalDataSource.cacheDividends(tTicker, tDividendsList),
        ).thenAnswer((_) async => Future.value());

        // act
        final result = await repository.getDividendInfo(tTicker);

        // assert
        expect(result.isRight(), true);
        verify(() => mockLocalDataSource.getCachedDividends(tTicker)).called(1);
        verify(() => mockRemoteDataSource.getDividends(tTicker)).called(1);
        verify(
          () => mockLocalDataSource.cacheDividends(tTicker, tDividendsList),
        ).called(1);
      },
    );

    test('getDividendInfo_serverExample_returnLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedDividends(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getDividends(tTicker),
      ).thenThrow(Exception('Server Error'));

      // act
      final result = await repository.getDividendInfo(tTicker);

      // assert
      expect(result.isLeft(), true);
    });
  });

  group('FinancialRepositoryImpl - RevenueStats', () {
    final tIncomeDto = IncomeStatementDto(
      date: '2023-01-01',
      symbol: tTicker,
      reportedCurrency: 'USD',
      revenue: 1000000,
      netIncome: 500000,
      epsDiluted: 2.5,
      period: 'FY',
      cik: '0000320193',
      filingDate: '2023-02-01',
      acceptedDate: '2023-02-01',
      fiscalYear: '2023',
    );
    final List<IncomeStatementDto> tIncomeList = [tIncomeDto];

    test('getRevenueStats_success_returnsRightWithRevenueStats', () async {
      // arrange
      // Mock annual
      when(
        () => mockLocalDataSource.getCachedIncomeStatements(
          tTicker,
          period: 'annual',
        ),
      ).thenAnswer((_) async => null);
      when(
        () =>
            mockRemoteDataSource.getIncomeStatements(tTicker, period: 'annual'),
      ).thenAnswer((_) async => tIncomeList);
      when(
        () => mockLocalDataSource.cacheIncomeStatements(
          tTicker,
          tIncomeList,
          period: 'annual',
        ),
      ).thenAnswer((_) async => Future.value());

      // Mock quarter
      when(
        () => mockLocalDataSource.getCachedIncomeStatements(
          tTicker,
          period: 'quarter',
        ),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getIncomeStatements(
          tTicker,
          period: 'quarter',
        ),
      ).thenAnswer((_) async => tIncomeList);
      when(
        () => mockLocalDataSource.cacheIncomeStatements(
          tTicker,
          tIncomeList,
          period: 'quarter',
        ),
      ).thenAnswer((_) async => Future.value());

      // Mock currency
      when(
        () => mockLocalDataSource.getCachedExchangeRate('USDUSD'),
      ).thenAnswer((_) async => 1.0);

      // act
      final result = await repository.getRevenueStats(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should not return left'), (r) {
        expect(r, isA<RevenueStats>());
        expect(r.annualRevenue.length, 1);
        expect(r.annualRevenue.first.value, 1000000);
      });
    });
  });
}
