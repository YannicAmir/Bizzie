import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_dto.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/earnings_report_dto.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_eod_dto.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/profile_dtos.dart'; // For QuoteDto

abstract class SecurityFirestoreDataSource {
  Future<void> cachePrices(String ticker, List<HistoricalPriceDto> prices);
  Future<List<HistoricalPriceDto>?> getCachedPrices(String ticker);

  Future<void> cacheQuote(String ticker, QuoteDto quote);
  Future<QuoteDto?> getCachedQuote(String ticker);

  Future<void> cacheHistoricalEodPrices(
    String ticker,
    List<HistoricalPriceEodDto> prices,
  );
  Future<List<HistoricalPriceEodDto>?> getCachedHistoricalEodPrices(
    String ticker,
  );

  Future<void> cacheEarningsReports(
    String ticker,
    List<EarningsReportDto> reports,
  );
  Future<List<EarningsReportDto>?> getCachedEarningsReports(String ticker);
}

@LazySingleton(as: SecurityFirestoreDataSource)
class SecurityFirestoreDataSourceImpl implements SecurityFirestoreDataSource {
  final FirebaseFirestore _firestore;

  SecurityFirestoreDataSourceImpl(this._firestore);

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
  Future<void> cacheEarningsReports(
    String ticker,
    List<EarningsReportDto> reports,
  ) async {
    await _getDocRef<List<EarningsReportDto>>(
      ticker,
      'financials',
      'earnings_reports',
      (json) =>
          (json as List).map((e) => EarningsReportDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    ).set(FirestoreCacheEntry(data: reports, lastUpdated: DateTime.now()));
  }

  @override
  Future<List<EarningsReportDto>?> getCachedEarningsReports(
    String ticker,
  ) async {
    return _fetchWithCacheFirst(
      _getDocRef<List<EarningsReportDto>>(
        ticker,
        'financials',
        'earnings_reports',
        (json) =>
            (json as List).map((e) => EarningsReportDto.fromJson(e)).toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      ),
    );
  }
}
