import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/governance_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/profile_dtos.dart';

import 'package:bizzie/features/company_profile/data/repositories/security_repository_impl.dart';

import 'package:bizzie/features/company_profile/domain/models/share_stats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements CompanyRemoteDataSource {}

class MockLocalDataSource extends Mock implements CompanyFirestoreDataSource {}

void main() {
  late SecurityRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = SecurityRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );

    registerFallbackValue(const GovernanceDto(symbol: '', nameAndPosition: ''));
    registerFallbackValue(const <ExecutiveDto>[]);
  });

  const tTicker = 'AAPL';

  group('SecurityRepositoryImpl - ShareStats', () {
    final tQuote = QuoteDto(
      symbol: tTicker,
      name: 'Apple Inc.',
      price: 155.0,
      change: 5.0,
      changesPercentage: 3.2,
      marketCap: 2500000000.0,
      pe: 25.0,
      sharesOutstanding: 16000000000.0,
    );

    final tLegacyIncome = [
      const LegacyIncomeStatementDto(
        date: '2023-09-30',
        symbol: tTicker,
        reportedCurrency: 'USD',
        period: 'FY',
        weightedAverageShsOutDil: 16000000000,
        cik: '0000320193',
        fillingDate: '2023-10-01',
        acceptedDate: '2023-10-01',
        calendarYear: '2023',
        link: 'https://sec.gov/10k',
        finalLink: 'https://sec.gov/10k',
      ),
    ];

    test('getShareStats_success_returnsShareStats', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedQuote(tTicker),
      ).thenAnswer((_) async => tQuote);
      when(
        () => mockLocalDataSource.getCachedLegacyIncomeStatements(
          tTicker,
          period: 'annual',
        ),
      ).thenAnswer((_) async => tLegacyIncome);
      when(
        () => mockLocalDataSource.getCachedLegacyIncomeStatements(
          tTicker,
          period: 'quarter',
        ),
      ).thenAnswer((_) async => <LegacyIncomeStatementDto>[]);

      // act
      final result = await repository.getShareStats(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, isA<ShareStats>());
        expect(r.currentSharesOutstanding, 16000000000.0);
        expect(r.annualWeightedAverageShares.length, 1);
      });
    });
  });
}
