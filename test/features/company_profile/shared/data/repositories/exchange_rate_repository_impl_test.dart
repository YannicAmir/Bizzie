import 'package:bizzie/core/data/models/cache_result.dart' as cache;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_device_locale_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/interfaces/i_financial_statements_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/i_exchange_rate_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/frankfurter_response_dto.dart';
import 'package:bizzie/features/company_profile/shared/data/repositories/exchange_rate_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeviceLocaleService extends Mock implements IDeviceLocaleService {}

class MockTimeProvider extends Mock implements ITimeProvider {}

class MockExchangeRateRemoteDataSource extends Mock
    implements IExchangeRateRemoteDataSource {}

class MockFinancialFirestoreDataSource extends Mock
    implements IFinancialStatementsFirestoreDataSource {}

void main() {
  late ExchangeRateRepositoryImpl repository;
  late MockDeviceLocaleService mockLocaleService;
  late MockTimeProvider mockTimeProvider;
  late MockExchangeRateRemoteDataSource mockRemoteDataSource;
  late MockFinancialFirestoreDataSource mockLocalDataSource;

  setUp(() {
    mockLocaleService = MockDeviceLocaleService();
    mockTimeProvider = MockTimeProvider();
    mockRemoteDataSource = MockExchangeRateRemoteDataSource();
    mockLocalDataSource = MockFinancialFirestoreDataSource();
    repository = ExchangeRateRepositoryImpl(
      mockLocaleService,
      mockTimeProvider,
      mockRemoteDataSource,
      mockLocalDataSource,
    );

    // Default mock data
    when(() => mockLocaleService.preferredCurrency).thenReturn('USD');
    when(() => mockTimeProvider.nowEt).thenReturn(DateTime(2023, 1, 1));
  });

  const tTicker = 'AAPL';
  const tReportedCurrency = 'CNY';
  const tTargetCurrency = 'USD';
  const tPair = 'CNYUSD';
  const tRequestDate = '2023-01-01';

  group('getMultiplier', () {
    test('getMultiplier_sameCurrency_returnsOneMultiplierDigitally', () async {
      // arrange
      when(() => mockLocaleService.preferredCurrency).thenReturn('USD');

      // act
      final result = await repository.getMultiplier(
        reportedCurrency: 'USD',
        ticker: tTicker,
      );

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r.$1.multiplier, 1.0);
        expect(r.$1.targetCurrency, 'USD');
        expect(r.$2, CompanyProfileDataOrigin.cache);
      });
      verify(() => mockLocaleService.preferredCurrency).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('getMultiplier_nullCurrency_returnsOneMultiplierDigitally', () async {
      // arrange
      when(() => mockLocaleService.preferredCurrency).thenReturn('USD');

      // act
      final result = await repository.getMultiplier(
        reportedCurrency: null,
        ticker: tTicker,
      );

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r.$1.multiplier, 1.0);
        expect(r.$1.targetCurrency, 'USD');
      });
    });

    test('getMultiplier_cacheHit_returnsMultiplierFromCache', () async {
      // arrange
      when(
        () => mockLocalDataSource.syncExchangeRate(
          tPair,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async =>
            const cache.CacheSuccess(0.14, CompanyProfileDataOrigin.cache),
      );

      // act
      final result = await repository.getMultiplier(
        reportedCurrency: tReportedCurrency,
        ticker: tTicker,
      );

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r.$1.multiplier, 0.14);
        expect(r.$1.targetCurrency, tTargetCurrency);
        expect(r.$2, CompanyProfileDataOrigin.cache);
      });
    });

    test('getMultiplier_remoteSuccess_returnsMultiplierFromRemote', () async {
      // arrange
      final tResponse = FrankfurterResponseDto(
        amount: 1.0,
        base: 'USD',
        date: tRequestDate,
        rates: {'CNY': 7.0},
      );

      when(
        () => mockLocalDataSource.syncExchangeRate(
          tPair,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer((invocation) async {
        final fetcher =
            invocation.namedArguments[#remoteFetcher]
                as Future<double> Function();
        return cache.CacheSuccess(
          await fetcher(),
          CompanyProfileDataOrigin.api,
        );
      });

      when(
        () => mockRemoteDataSource.getExchangeRate(
          base: any(named: 'base'),
          target: any(named: 'target'),
          date: any(named: 'date'),
        ),
      ).thenAnswer((_) async => tResponse);

      // act
      final result = await repository.getMultiplier(
        reportedCurrency: tReportedCurrency,
        ticker: tTicker,
      );

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r.$1.multiplier, 1.0 / 7.0);
        expect(r.$1.targetCurrency, tTargetCurrency);
        expect(r.$2, CompanyProfileDataOrigin.api);
      });
      verify(
        () => mockRemoteDataSource.getExchangeRate(
          base: tTargetCurrency,
          target: tReportedCurrency,
          date: tRequestDate,
        ),
      ).called(1);
    });

    test('getMultiplier_remoteRateNotFound_failsbackToOne', () async {
      // arrange
      final tResponse = FrankfurterResponseDto(
        amount: 1.0,
        base: 'USD',
        date: tRequestDate,
        rates: {'EUR': 0.9}, // CNY not in rates
      );

      when(
        () => mockLocalDataSource.syncExchangeRate(
          tPair,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer((invocation) async {
        final fetcher =
            invocation.namedArguments[#remoteFetcher]
                as Future<double> Function();
        try {
          return cache.CacheSuccess(
            await fetcher(),
            CompanyProfileDataOrigin.api,
          );
        } catch (e) {
          return cache.CacheFailure<double>(ServerFailure('Rate not found'));
        }
      });

      when(
        () => mockRemoteDataSource.getExchangeRate(
          base: any(named: 'base'),
          target: any(named: 'target'),
          date: any(named: 'date'),
        ),
      ).thenAnswer((_) async => tResponse);

      // act
      final result = await repository.getMultiplier(
        reportedCurrency: tReportedCurrency,
        ticker: tTicker,
      );

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r.$1.multiplier, 1.0);
        expect(r.$1.targetCurrency, tReportedCurrency);
      });
    });

    test('getMultiplier_syncReturnsFailure_failsbackToOne', () async {
      // arrange
      when(
        () => mockLocalDataSource.syncExchangeRate(
          tPair,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async => cache.CacheFailure<double>(ServerFailure('Some error')),
      );

      // act
      final result = await repository.getMultiplier(
        reportedCurrency: tReportedCurrency,
        ticker: tTicker,
      );

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r.$1.multiplier, 1.0);
        expect(r.$1.targetCurrency, tReportedCurrency);
      });
    });

    test('getMultiplier_syncReturnsNotFound_failsbackToOne', () async {
      // arrange
      when(
        () => mockLocalDataSource.syncExchangeRate(
          tPair,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer((_) async => const cache.CacheNotFound<double>());

      // act
      final result = await repository.getMultiplier(
        reportedCurrency: tReportedCurrency,
        ticker: tTicker,
      );

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r.$1.multiplier, 1.0);
        expect(r.$1.targetCurrency, tReportedCurrency);
      });
    });

    test('getMultiplier_unexpectedException_failsbackToOne', () async {
      // arrange
      when(
        () => mockLocalDataSource.syncExchangeRate(
          tPair,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenThrow(Exception('Unexpected'));

      // act
      final result = await repository.getMultiplier(
        reportedCurrency: tReportedCurrency,
        ticker: tTicker,
      );

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r.$1.multiplier, 1.0);
        expect(r.$1.targetCurrency, tReportedCurrency);
      });
    });
  });
}
