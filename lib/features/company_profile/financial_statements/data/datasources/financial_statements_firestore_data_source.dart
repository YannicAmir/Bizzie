import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/financial_dtos.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/balance_sheet_dto.dart';

abstract class FinancialStatementsFirestoreDataSource {
  Future<void> cacheFinancials(
    String ticker,
    List<FinancialStatementDto> data, {
    required String type,
    required String period,
  });
  Future<List<FinancialStatementDto>?> getCachedFinancials(
    String ticker, {
    required String type,
    required String period,
  });

  Future<void> cacheIncomeStatements(
    String ticker,
    List<IncomeStatementDto> data, {
    required String period,
  });
  Future<List<IncomeStatementDto>?> getCachedIncomeStatements(
    String ticker, {
    required String period,
  });

  Future<void> cacheLegacyIncomeStatements(
    String ticker,
    List<LegacyIncomeStatementDto> data, {
    required String period,
  });
  Future<List<LegacyIncomeStatementDto>?> getCachedLegacyIncomeStatements(
    String ticker, {
    required String period,
  });

  Future<void> cacheCashFlowStatements(
    String ticker,
    List<CashFlowStatementDto> data, {
    required String period,
  });
  Future<List<CashFlowStatementDto>?> getCachedCashFlowStatements(
    String ticker, {
    required String period,
  });

  Future<void> cacheBalanceSheets(
    String ticker,
    List<BalanceSheetDto> data, {
    required String period,
  });
  Future<List<BalanceSheetDto>?> getCachedBalanceSheets(
    String ticker, {
    required String period,
  });

  Future<void> cacheExchangeRate(String pair, double rate);
  Future<double?> getCachedExchangeRate(String pair);
}

@LazySingleton(as: FinancialStatementsFirestoreDataSource)
class FinancialStatementsFirestoreDataSourceImpl
    implements FinancialStatementsFirestoreDataSource {
  final FirebaseFirestore _firestore;

  FinancialStatementsFirestoreDataSourceImpl(this._firestore);

  bool _isSmartCacheValid({
    required DateTime? lastUpdated,
    int weekendThresholdHour = 22,
    bool strictMarketAware = false,
    Duration fallbackTtl = const Duration(hours: 24),
  }) {
    if (lastUpdated == null) return false;
    final now = DateTime.now();

    if (now.weekday == DateTime.saturday || now.weekday == DateTime.sunday) {
      final daysSinceFriday = now.weekday - DateTime.friday;
      final lastFriday = now.subtract(Duration(days: daysSinceFriday));

      final anchor = DateTime(
        lastFriday.year,
        lastFriday.month,
        lastFriday.day,
        weekendThresholdHour,
        0,
      );

      return lastUpdated.isAfter(anchor);
    }

    if (strictMarketAware) {
      final marketOpen = DateTime(now.year, now.month, now.day, 9, 30);
      if (now.isAfter(marketOpen)) {
        return lastUpdated.isAfter(marketOpen);
      }
    }

    final diff = now.difference(lastUpdated);
    return diff < fallbackTtl;
  }

  CollectionReference<FirestoreCacheEntry<T>> _getCollectionRef<T>(
    String ticker,
    String collectionPath,
    T Function(Object?) fromJson,
    Object? Function(T) toJson,
  ) {
    return _firestore
        .collection('companies')
        .doc(ticker)
        .collection(collectionPath)
        .withConverter<FirestoreCacheEntry<T>>(
          fromFirestore: (snapshot, _) =>
              FirestoreCacheEntry.fromJson(snapshot.data()!, fromJson),
          toFirestore: (entry, _) => entry.toJson(toJson),
        );
  }

  DocumentReference<FirestoreCacheEntry<T>> _getDocRef<T>(
    String ticker,
    String collection,
    String docId,
    T Function(Object?) fromJson,
    Object? Function(T) toJson,
  ) {
    return _getCollectionRef(ticker, collection, fromJson, toJson).doc(docId);
  }

  Future<T?> _fetchWithCacheFirst<T>(
    DocumentReference<FirestoreCacheEntry<T>> docRef, {
    int weekendThresholdHour = 22,
    bool strictMarketAware = false,
    Duration fallbackTtl = const Duration(hours: 24),
  }) async {
    bool validator(DateTime? ts) => _isSmartCacheValid(
      lastUpdated: ts,
      weekendThresholdHour: weekendThresholdHour,
      strictMarketAware: strictMarketAware,
      fallbackTtl: fallbackTtl,
    );

    try {
      final doc = await docRef.get(const GetOptions(source: Source.cache));
      if (doc.exists) {
        final entry = doc.data();
        if (entry != null && validator(entry.lastUpdated)) {
          return entry.data;
        }
      }
    } catch (_) {}

    try {
      final doc = await docRef.get(const GetOptions(source: Source.server));
      if (doc.exists) {
        final entry = doc.data();
        if (entry != null && validator(entry.lastUpdated)) {
          return entry.data;
        }
      }
    } catch (_) {}

    return null;
  }

  @override
  Future<void> cacheFinancials(
    String ticker,
    List<FinancialStatementDto> data, {
    required String type,
    required String period,
  }) async {
    await _getDocRef<List<FinancialStatementDto>>(
      ticker,
      'financials',
      '${type}_$period',
      (json) =>
          (json as List).map((e) => FinancialStatementDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: data, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<FinancialStatementDto>?> getCachedFinancials(
    String ticker, {
    required String type,
    required String period,
  }) async {
    return _fetchWithCacheFirst(
      _getDocRef<List<FinancialStatementDto>>(
        ticker,
        'financials',
        '${type}_$period',
        (json) => (json as List)
            .map((e) => FinancialStatementDto.fromJson(e))
            .toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
    );
  }

  @override
  Future<void> cacheIncomeStatements(
    String ticker,
    List<IncomeStatementDto> data, {
    required String period,
  }) async {
    await _getDocRef<List<IncomeStatementDto>>(
      ticker,
      'financials',
      'income_stable_$period',
      (json) =>
          (json as List).map((e) => IncomeStatementDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: data, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<IncomeStatementDto>?> getCachedIncomeStatements(
    String ticker, {
    required String period,
  }) async {
    return _fetchWithCacheFirst(
      _getDocRef<List<IncomeStatementDto>>(
        ticker,
        'financials',
        'income_stable_$period',
        (json) =>
            (json as List).map((e) => IncomeStatementDto.fromJson(e)).toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
    );
  }

  @override
  Future<void> cacheLegacyIncomeStatements(
    String ticker,
    List<LegacyIncomeStatementDto> data, {
    required String period,
  }) async {
    await _getDocRef<List<LegacyIncomeStatementDto>>(
      ticker,
      'financials',
      'income_legacy_$period',
      (json) => (json as List)
          .map((e) => LegacyIncomeStatementDto.fromJson(e))
          .toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: data, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<LegacyIncomeStatementDto>?> getCachedLegacyIncomeStatements(
    String ticker, {
    required String period,
  }) async {
    return _fetchWithCacheFirst(
      _getDocRef<List<LegacyIncomeStatementDto>>(
        ticker,
        'financials',
        'income_legacy_$period',
        (json) => (json as List)
            .map((e) => LegacyIncomeStatementDto.fromJson(e))
            .toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
    );
  }

  @override
  Future<void> cacheBalanceSheets(
    String ticker,
    List<BalanceSheetDto> data, {
    required String period,
  }) async {
    await _getDocRef<List<BalanceSheetDto>>(
      ticker,
      'financials',
      'balance_sheet_$period',
      (json) => (json as List).map((e) => BalanceSheetDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: data, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<BalanceSheetDto>?> getCachedBalanceSheets(
    String ticker, {
    required String period,
  }) async {
    return _fetchWithCacheFirst(
      _getDocRef<List<BalanceSheetDto>>(
        ticker,
        'financials',
        'balance_sheet_$period',
        (json) =>
            (json as List).map((e) => BalanceSheetDto.fromJson(e)).toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
    );
  }

  @override
  Future<void> cacheCashFlowStatements(
    String ticker,
    List<CashFlowStatementDto> data, {
    required String period,
  }) async {
    await _getDocRef<List<CashFlowStatementDto>>(
      ticker,
      'financials',
      'cash_flow_$period',
      (json) =>
          (json as List).map((e) => CashFlowStatementDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: data, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<CashFlowStatementDto>?> getCachedCashFlowStatements(
    String ticker, {
    required String period,
  }) async {
    return _fetchWithCacheFirst(
      _getDocRef<List<CashFlowStatementDto>>(
        ticker,
        'financials',
        'cash_flow_$period',
        (json) => (json as List)
            .map((e) => CashFlowStatementDto.fromJson(e))
            .toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
    );
  }

  @override
  Future<void> cacheExchangeRate(String pair, double rate) async {
    await _getDocRef<double>(
      pair,
      'market',
      'price',
      (json) => (json as num).toDouble(),
      (data) => data,
    ).set(FirestoreCacheEntry(data: rate, lastUpdated: DateTime.now()));
  }

  @override
  Future<double?> getCachedExchangeRate(String pair) async {
    return _fetchWithCacheFirst(
      _getDocRef<double>(
        pair,
        'market',
        'price',
        (json) => (json as num).toDouble(),
        (data) => data,
      ),
      fallbackTtl: const Duration(hours: 24),
    );
  }
}
