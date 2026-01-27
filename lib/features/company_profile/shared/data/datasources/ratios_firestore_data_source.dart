import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/ratios_dto.dart';
import 'package:bizzie/features/company_profile/roe/data/dtos/key_metrics_dto.dart';

abstract class RatiosFirestoreDataSource {
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
}

@LazySingleton(as: RatiosFirestoreDataSource)
class RatiosFirestoreDataSourceImpl implements RatiosFirestoreDataSource {
  final FirebaseFirestore _firestore;

  RatiosFirestoreDataSourceImpl(this._firestore);

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
}
