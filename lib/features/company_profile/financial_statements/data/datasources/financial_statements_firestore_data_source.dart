import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/financial_dtos.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/balance_sheet_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/interfaces/i_financial_statements_firestore_datasource.dart';
import 'package:bizzie/services/firestore_service.dart';

@Injectable(as: IFinancialStatementsFirestoreDataSource)
class FinancialStatementsFirestoreDataSourceImpl
    extends BaseFirestoreCacheClient
    implements IFinancialStatementsFirestoreDataSource {
  FinancialStatementsFirestoreDataSourceImpl(
    FirestoreService firestoreService,
    ITimeProvider timeProvider,
  ) : super(
        firestoreService,
        timeProvider,
        'FinancialStatementsFirestoreDataSource',
      );

  @override
  Future<result.CacheResult<List<FinancialStatementDto>>> syncFinancials(
    String ticker, {
    required String type,
    required String period,
    required Future<List<FinancialStatementDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<FinancialStatementDto>>(
      docRef: _financialsRef(ticker, type, period),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<result.CacheResult<List<IncomeStatementDto>>> syncIncomeStatements(
    String ticker, {
    required String period,
    required Future<List<IncomeStatementDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<IncomeStatementDto>>(
      docRef: _incomeStableRef(ticker, period),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<result.CacheResult<List<LegacyIncomeStatementDto>>>
  syncLegacyIncomeStatements(
    String ticker, {
    required String period,
    required Future<List<LegacyIncomeStatementDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<LegacyIncomeStatementDto>>(
      docRef: _incomeLegacyRef(ticker, period),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<result.CacheResult<List<BalanceSheetDto>>> syncBalanceSheets(
    String ticker, {
    required String period,
    required Future<List<BalanceSheetDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<BalanceSheetDto>>(
      docRef: _balanceSheetRef(ticker, period),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<result.CacheResult<List<CashFlowStatementDto>>> syncCashFlowStatements(
    String ticker, {
    required String period,
    required Future<List<CashFlowStatementDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<CashFlowStatementDto>>(
      docRef: _cashFlowRef(ticker, period),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<result.CacheResult<double>> syncExchangeRate(
    String pair, {
    required Future<double> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<double>(
      docRef: _exchangeRateRef(pair),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
      fallbackTtl: const Duration(hours: 24),
    );
  }

  @override
  Future<(List<FinancialStatementDto>, CompanyProfileDataOrigin)?>
  getCachedFinancials(
    String ticker, {
    required String type,
    required String period,
  }) async {
    final res = await fetchWithCacheFirst(_financialsRef(ticker, type, period));
    if (res is result.CacheSuccess<List<FinancialStatementDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  @override
  Future<(List<IncomeStatementDto>, CompanyProfileDataOrigin)?>
  getCachedIncomeStatements(String ticker, {required String period}) async {
    final res = await fetchWithCacheFirst(_incomeStableRef(ticker, period));
    if (res is result.CacheSuccess<List<IncomeStatementDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  @override
  Future<(List<LegacyIncomeStatementDto>, CompanyProfileDataOrigin)?>
  getCachedLegacyIncomeStatements(
    String ticker, {
    required String period,
  }) async {
    final res = await fetchWithCacheFirst(_incomeLegacyRef(ticker, period));
    if (res is result.CacheSuccess<List<LegacyIncomeStatementDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  @override
  Future<(List<BalanceSheetDto>, CompanyProfileDataOrigin)?>
  getCachedBalanceSheets(String ticker, {required String period}) async {
    final res = await fetchWithCacheFirst(_balanceSheetRef(ticker, period));
    if (res is result.CacheSuccess<List<BalanceSheetDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  @override
  Future<(List<CashFlowStatementDto>, CompanyProfileDataOrigin)?>
  getCachedCashFlowStatements(String ticker, {required String period}) async {
    final res = await fetchWithCacheFirst(_cashFlowRef(ticker, period));
    if (res is result.CacheSuccess<List<CashFlowStatementDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  @override
  Future<(double, CompanyProfileDataOrigin)?> getCachedExchangeRate(
    String pair,
  ) async {
    final res = await fetchWithCacheFirst(
      _exchangeRateRef(pair),
      fallbackTtl: const Duration(hours: 24),
    );
    if (res is result.CacheSuccess<double>) return (res.data, res.origin);
    return null;
  }

  DocumentReference<FirestoreCacheEntry<List<FinancialStatementDto>>>
  _financialsRef(String ticker, String type, String period) =>
      getDocRef<List<FinancialStatementDto>>(
        ticker,
        FirestoreConstants.financials,
        '${type}_$period',
        (json) => (json as List)
            .map((e) => FinancialStatementDto.fromJson(e))
            .toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      );

  DocumentReference<FirestoreCacheEntry<List<IncomeStatementDto>>>
  _incomeStableRef(String ticker, String period) =>
      getDocRef<List<IncomeStatementDto>>(
        ticker,
        FirestoreConstants.financials,
        '${FirestoreConstants.incomeStablePrefix}_$period',
        (json) =>
            (json as List).map((e) => IncomeStatementDto.fromJson(e)).toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      );

  DocumentReference<FirestoreCacheEntry<List<LegacyIncomeStatementDto>>>
  _incomeLegacyRef(String ticker, String period) =>
      getDocRef<List<LegacyIncomeStatementDto>>(
        ticker,
        FirestoreConstants.financials,
        '${FirestoreConstants.incomeLegacyPrefix}_$period',
        (json) => (json as List)
            .map((e) => LegacyIncomeStatementDto.fromJson(e))
            .toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      );

  DocumentReference<FirestoreCacheEntry<List<BalanceSheetDto>>>
  _balanceSheetRef(String ticker, String period) =>
      getDocRef<List<BalanceSheetDto>>(
        ticker,
        FirestoreConstants.financials,
        '${FirestoreConstants.balanceSheetPrefix}_$period',
        (json) =>
            (json as List).map((e) => BalanceSheetDto.fromJson(e)).toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      );

  DocumentReference<FirestoreCacheEntry<List<CashFlowStatementDto>>>
  _cashFlowRef(String ticker, String period) =>
      getDocRef<List<CashFlowStatementDto>>(
        ticker,
        FirestoreConstants.financials,
        '${FirestoreConstants.cashFlowPrefix}_$period',
        (json) => (json as List)
            .map((e) => CashFlowStatementDto.fromJson(e))
            .toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      );

  DocumentReference<FirestoreCacheEntry<double>> _exchangeRateRef(
    String pair,
  ) => getDocRef<double>(
    pair,
    FirestoreConstants.market,
    FirestoreConstants.price,
    (json) => (json as num).toDouble(),
    (data) => data,
  );
}
