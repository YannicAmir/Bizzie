import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/features/company_profile/dividends/data/dtos/dividend_dto.dart';

abstract class DividendsFirestoreDataSource {
  Future<void> cacheDividends(String ticker, List<DividendDto> dividends);
  Future<List<DividendDto>?> getCachedDividends(String ticker);
}

@LazySingleton(as: DividendsFirestoreDataSource)
class DividendsFirestoreDataSourceImpl implements DividendsFirestoreDataSource {
  final FirebaseFirestore _firestore;

  DividendsFirestoreDataSourceImpl(this._firestore);

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
}
