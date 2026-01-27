import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/profile_dtos.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/governance_dtos.dart';

abstract class BusinessFirestoreDataSource {
  Future<void> cacheProfile(String ticker, ProfileDto profile);
  Future<ProfileDto?> getCachedProfile(String ticker);

  Future<void> cacheQuote(String ticker, QuoteDto quote);
  Future<QuoteDto?> getCachedQuote(String ticker);

  Future<void> cacheGovernance(
    String ticker,
    GovernanceDto governance,
    List<ExecutiveDto> executives,
  );
  Future<GovernanceDto?> getCachedGovernance(String ticker);
  Future<List<ExecutiveDto>?> getCachedExecutives(String ticker);

  Future<void> cacheExchangeRate(String pair, double rate);
  Future<double?> getCachedExchangeRate(String pair);

  Future<void> cacheProxyUrl(String ticker, String? url);
  Future<String?> getCachedProxyUrl(String ticker);
}

@LazySingleton(as: BusinessFirestoreDataSource)
class BusinessFirestoreDataSourceImpl implements BusinessFirestoreDataSource {
  final FirebaseFirestore _firestore;

  BusinessFirestoreDataSourceImpl(this._firestore);

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
}
