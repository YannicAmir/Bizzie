import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/company_profile/data/dtos/profile_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/financial_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/governance_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/market_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/key_metrics_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/ratios_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/balance_sheet_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/historical_price_eod_dto.dart';

abstract class CompanyFirestoreDataSource {
  Future<void> cacheProfile(String ticker, ProfileDto profile);
  Future<ProfileDto?> getCachedProfile(String ticker);

  Future<void> cacheQuote(String ticker, QuoteDto quote);
  Future<QuoteDto?> getCachedQuote(String ticker);

  Future<void> cacheRatios(
    String ticker,
    List<RatiosDto> ratios, {
    required bool isTtm,
  });
  Future<List<RatiosDto>?> getCachedRatios(
    String ticker, {
    required bool isTtm,
  });

  Future<void> cacheKeyMetrics(
    String ticker,
    List<KeyMetricsDto> metrics, {
    required bool isTtm,
  });
  Future<List<KeyMetricsDto>?> getCachedKeyMetrics(
    String ticker, {
    required bool isTtm,
  });

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

  Future<void> cacheGovernance(
    String ticker,
    GovernanceDto governance,
    List<ExecutiveDto> executives,
  );
  Future<GovernanceDto?> getCachedGovernance(String ticker);
  Future<List<ExecutiveDto>?> getCachedExecutives(String ticker);

  Future<void> cacheDividends(String ticker, List<DividendDto> dividends);
  Future<List<DividendDto>?> getCachedDividends(String ticker);

  Future<void> cachePrices(String ticker, List<HistoricalPriceDto> prices);
  Future<List<HistoricalPriceDto>?> getCachedPrices(String ticker);

  Future<void> cacheHistoricalEodPrices(
    String ticker,
    List<HistoricalPriceEodDto> prices,
  );
  Future<List<HistoricalPriceEodDto>?> getCachedHistoricalEodPrices(
    String ticker,
  );

  Future<void> cacheProxyUrl(String ticker, String? url);
  Future<String?> getCachedProxyUrl(String ticker);

  Future<void> cacheStockNews(String ticker, List<NewsDto> news);

  Future<List<NewsDto>?> getCachedStockNews(String ticker);

  Future<void> cacheExchangeRate(String pair, double rate);
  Future<double?> getCachedExchangeRate(String pair);
}

@LazySingleton(as: CompanyFirestoreDataSource)
class CompanyFirestoreDataSourceImpl implements CompanyFirestoreDataSource {
  final FirebaseFirestore _firestore;

  CompanyFirestoreDataSourceImpl(this._firestore);

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
  Future<void> cacheProfile(String ticker, ProfileDto profile) async {
    await _getDocRef<ProfileDto>(
      ticker,
      'info',
      'profile',
      (json) => ProfileDto.fromJson(json as Map<String, dynamic>),
      (data) => data.toJson(),
    ).set(FirestoreCacheEntry(data: profile, lastUpdated: DateTime.now()));
  }

  @override
  Future<ProfileDto?> getCachedProfile(String ticker) async {
    return _fetchWithCacheFirst(
      _getDocRef<ProfileDto>(
        ticker,
        'info',
        'profile',
        (json) => ProfileDto.fromJson(json as Map<String, dynamic>),
        (data) => data.toJson(),
      ),
    );
  }

  @override
  Future<void> cacheQuote(String ticker, QuoteDto quote) async {
    await _getDocRef<QuoteDto>(
      ticker,
      'market',
      'quote',
      (json) => QuoteDto.fromJson(json as Map<String, dynamic>),
      (data) => data.toJson(),
    ).set(FirestoreCacheEntry(data: quote, lastUpdated: DateTime.now()));
  }

  @override
  Future<QuoteDto?> getCachedQuote(String ticker) async {
    return _fetchWithCacheFirst(
      _getDocRef<QuoteDto>(
        ticker,
        'market',
        'quote',
        (json) => QuoteDto.fromJson(json as Map<String, dynamic>),
        (data) => data.toJson(),
      ),
      fallbackTtl: const Duration(minutes: 5),
    );
  }

  @override
  Future<void> cacheRatios(
    String ticker,
    List<RatiosDto> ratios, {
    required bool isTtm,
  }) async {
    final docId = isTtm ? 'ratios_ttm' : 'ratios_annual';
    await _getDocRef<List<RatiosDto>>(
      ticker,
      'financials',
      docId,
      (json) => (json as List).map((e) => RatiosDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: ratios, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<RatiosDto>?> getCachedRatios(
    String ticker, {
    required bool isTtm,
  }) async {
    final docId = isTtm ? 'ratios_ttm' : 'ratios_annual';
    return _fetchWithCacheFirst(
      _getDocRef<List<RatiosDto>>(
        ticker,
        'financials',
        docId,
        (json) => (json as List).map((e) => RatiosDto.fromJson(e)).toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
    );
  }

  @override
  Future<void> cacheKeyMetrics(
    String ticker,
    List<KeyMetricsDto> metrics, {
    required bool isTtm,
  }) async {
    final docId = isTtm ? 'key_metrics_ttm' : 'key_metrics_annual';
    await _getDocRef<List<KeyMetricsDto>>(
      ticker,
      'financials',
      docId,
      (json) => (json as List).map((e) => KeyMetricsDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: metrics, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<KeyMetricsDto>?> getCachedKeyMetrics(
    String ticker, {
    required bool isTtm,
  }) async {
    final docId = isTtm ? 'key_metrics_ttm' : 'key_metrics_annual';
    return _fetchWithCacheFirst(
      _getDocRef<List<KeyMetricsDto>>(
        ticker,
        'financials',
        docId,
        (json) => (json as List).map((e) => KeyMetricsDto.fromJson(e)).toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
    );
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
  Future<void> cacheGovernance(
    String ticker,
    GovernanceDto governance,
    List<ExecutiveDto> executives,
  ) async {
    final data = {
      'governance': governance.toJson(),
      'executives': executives.map((e) => e.toJson()).toList(),
    };

    await _getDocRef<Map<String, dynamic>>(
      ticker,
      'info',
      'governance',
      (json) => json as Map<String, dynamic>,
      (data) => data,
    ).set(FirestoreCacheEntry(data: data, lastUpdated: DateTime.now()));
  }

  @override
  Future<GovernanceDto?> getCachedGovernance(String ticker) async {
    final data = await _fetchWithCacheFirst<Map<String, dynamic>>(
      _getDocRef<Map<String, dynamic>>(
        ticker,
        'info',
        'governance',
        (json) => json as Map<String, dynamic>,
        (data) => data,
      ),
    );
    if (data == null) return null;
    return GovernanceDto.fromJson(data['governance']);
  }

  @override
  Future<List<ExecutiveDto>?> getCachedExecutives(String ticker) async {
    final data = await _fetchWithCacheFirst<Map<String, dynamic>>(
      _getDocRef<Map<String, dynamic>>(
        ticker,
        'info',
        'governance',
        (json) => json as Map<String, dynamic>,
        (data) => data,
      ),
    );
    if (data == null) return null;
    return (data['executives'] as List)
        .map((e) => ExecutiveDto.fromJson(e))
        .toList();
  }

  @override
  Future<void> cacheDividends(
    String ticker,
    List<DividendDto> dividends,
  ) async {
    await _getDocRef<List<DividendDto>>(
      ticker,
      'market',
      'dividends',
      (json) => (json as List).map((e) => DividendDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: dividends, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<DividendDto>?> getCachedDividends(String ticker) async {
    return _fetchWithCacheFirst(
      _getDocRef<List<DividendDto>>(
        ticker,
        'market',
        'dividends',
        (json) => (json as List).map((e) => DividendDto.fromJson(e)).toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
    );
  }

  @override
  Future<void> cachePrices(
    String ticker,
    List<HistoricalPriceDto> prices,
  ) async {
    await _getDocRef<List<HistoricalPriceDto>>(
      ticker,
      'market',
      'prices_history',
      (json) =>
          (json as List).map((e) => HistoricalPriceDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: prices, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<HistoricalPriceDto>?> getCachedPrices(String ticker) async {
    return _fetchWithCacheFirst(
      _getDocRef<List<HistoricalPriceDto>>(
        ticker,
        'market',
        'prices_history',
        (json) =>
            (json as List).map((e) => HistoricalPriceDto.fromJson(e)).toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
    );
  }

  @override
  Future<void> cacheHistoricalEodPrices(
    String ticker,
    List<HistoricalPriceEodDto> prices,
  ) async {
    await _getDocRef<List<HistoricalPriceEodDto>>(
      ticker,
      'market',
      'prices_eod',
      (json) =>
          (json as List).map((e) => HistoricalPriceEodDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: prices, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<HistoricalPriceEodDto>?> getCachedHistoricalEodPrices(
    String ticker,
  ) async {
    return _fetchWithCacheFirst(
      _getDocRef<List<HistoricalPriceEodDto>>(
        ticker,
        'market',
        'prices_eod',
        (json) => (json as List)
            .map((e) => HistoricalPriceEodDto.fromJson(e))
            .toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
      weekendThresholdHour: 17,
      strictMarketAware: true,
    );
  }

  @override
  Future<void> cacheProxyUrl(String ticker, String? url) async {
    await _getDocRef<Map<String, dynamic>>(
      ticker,
      'info',
      'proxy',
      (json) => json as Map<String, dynamic>,
      (data) => data,
    ).set(FirestoreCacheEntry(data: {'url': url}, lastUpdated: DateTime.now()));
  }

  @override
  Future<String?> getCachedProxyUrl(String ticker) async {
    final data = await _fetchWithCacheFirst<Map<String, dynamic>>(
      _getDocRef<Map<String, dynamic>>(
        ticker,
        'info',
        'proxy',
        (json) => json as Map<String, dynamic>,
        (data) => data,
      ),
    );
    if (data == null) return null;
    return data['url'] as String?;
  }

  @override
  Future<void> cacheStockNews(String ticker, List<NewsDto> news) async {
    await _getDocRef<List<NewsDto>>(
      ticker,
      'market',
      'news',
      (json) => (json as List).map((e) => NewsDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: news, lastUpdated: DateTime.now()));
  }

  @override
  @override
  Future<List<NewsDto>?> getCachedStockNews(String ticker) async {
    return _fetchWithCacheFirst(
      _getDocRef<List<NewsDto>>(
        ticker,
        'market',
        'news',
        (json) => (json as List).map((e) => NewsDto.fromJson(e)).toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
      fallbackTtl: const Duration(minutes: 5),
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
