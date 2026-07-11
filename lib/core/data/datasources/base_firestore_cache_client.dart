import 'dart:async';
import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/services/firestore_service.dart';

abstract class BaseFirestoreCacheClient {
  final FirestoreService _firestoreService;
  final ITimeProvider _timeProvider;
  final BizzieLogger _logger;

  BaseFirestoreCacheClient(
    this._firestoreService,
    this._timeProvider,
    String loggerName,
  ) : _logger = BizzieLogger(loggerName);

  bool _isSmartCacheValid({
    required DateTime? lastUpdated,
    required int weekendThresholdHour,
    required bool strictMarketAware,
    required Duration fallbackTtl,
  }) {
    if (lastUpdated == null) {
      return false;
    }

    final nowEt = _timeProvider.nowEt;

    if (_isWeekend(nowEt)) {
      return _isValidWeekendCache(
        nowEt: nowEt,
        lastUpdated: lastUpdated,
        thresholdHour: weekendThresholdHour,
      );
    }

    if (strictMarketAware && _isAfterMarketOpen(nowEt)) {
      return _isValidMarketAwareCache(lastUpdated: lastUpdated, nowEt: nowEt);
    }

    return _isValidTtlCache(
      lastUpdated: lastUpdated,
      nowEt: nowEt,
      ttl: fallbackTtl,
    );
  }

  bool _isWeekend(DateTime dateTime) {
    return dateTime.weekday == DateTime.saturday ||
        dateTime.weekday == DateTime.sunday;
  }

  bool _isValidWeekendCache({
    required DateTime nowEt,
    required DateTime lastUpdated,
    required int thresholdHour,
  }) {
    final daysSinceFriday = nowEt.weekday - DateTime.friday;
    final lastFriday = nowEt.subtract(Duration(days: daysSinceFriday));

    final fridayAnchorUtc = lastFriday
        .toUtc()
        .subtract(
          Duration(
            hours: lastFriday.hour,
            minutes: lastFriday.minute,
            seconds: lastFriday.second,
          ),
        )
        .add(Duration(hours: thresholdHour));

    return lastUpdated.toUtc().isAfter(fridayAnchorUtc);
  }

  bool _isAfterMarketOpen(DateTime dateTime) {
    return dateTime.hour > 9 || (dateTime.hour == 9 && dateTime.minute >= 30);
  }

  bool _isValidMarketAwareCache({
    required DateTime lastUpdated,
    required DateTime nowEt,
  }) {
    final marketOpenUtc = nowEt
        .toUtc()
        .subtract(
          Duration(
            hours: nowEt.hour,
            minutes: nowEt.minute,
            seconds: nowEt.second,
          ),
        )
        .add(const Duration(hours: 9, minutes: 30));
    return lastUpdated.toUtc().isAfter(marketOpenUtc);
  }

  bool _isValidTtlCache({
    required DateTime lastUpdated,
    required DateTime nowEt,
    required Duration ttl,
  }) {
    final diff = nowEt.difference(lastUpdated);
    return diff < ttl;
  }

  CollectionReference<FirestoreCacheEntry<T>> getCollectionRef<T>(
    String ticker,
    String collectionPath,
    T Function(Object?) fromJson,
    Object? Function(T) toJson,
  ) {
    return _firestoreService.getConvertedCollectionRef<FirestoreCacheEntry<T>>(
      path: '${FirestoreConstants.companies}/$ticker/$collectionPath',
      fromJson: (json) => FirestoreCacheEntry.fromJson(json, fromJson),
      toJson: (entry) => entry.toJson(toJson),
    );
  }

  DocumentReference<FirestoreCacheEntry<T>> getDocRef<T>(
    String ticker,
    String collection,
    String docId,
    T Function(Object?) fromJson,
    Object? Function(T) toJson,
  ) {
    return getCollectionRef(ticker, collection, fromJson, toJson).doc(docId);
  }

  Future<result.CacheResult<T>> fetchWithCacheFirst<T>(
    DocumentReference<FirestoreCacheEntry<T>> docRef, {
    int weekendThresholdHour = 22,
    bool strictMarketAware = false,
    Duration fallbackTtl = const Duration(hours: 24),
  }) async {
    final cacheResult = await _tryFetchFromSource(
      docRef: docRef,
      source: Source.cache,
      weekendThresholdHour: weekendThresholdHour,
      strictMarketAware: strictMarketAware,
      fallbackTtl: fallbackTtl,
    );

    if (cacheResult is result.CacheSuccess<T>) {
      return cacheResult;
    }

    final serverResult = await _tryFetchFromSource(
      docRef: docRef,
      source: Source.server,
      weekendThresholdHour: weekendThresholdHour,
      strictMarketAware: strictMarketAware,
      fallbackTtl: fallbackTtl,
    );

    return serverResult ?? const result.CacheNotFound();
  }

  Future<result.CacheResult<T>?> _tryFetchFromSource<T>({
    required DocumentReference<FirestoreCacheEntry<T>> docRef,
    required Source source,
    required int weekendThresholdHour,
    required bool strictMarketAware,
    required Duration fallbackTtl,
  }) async {
    try {
      final doc = await docRef.get(GetOptions(source: source));
      if (!doc.exists) {
        return null;
      }

      final entry = doc.data();
      if (entry == null) {
        return null;
      }

      final isValid = _isSmartCacheValid(
        lastUpdated: entry.lastUpdated,
        weekendThresholdHour: weekendThresholdHour,
        strictMarketAware: strictMarketAware,
        fallbackTtl: fallbackTtl,
      );

      if (isValid) {
        final origin = source == Source.cache
            ? CompanyProfileDataOrigin.cache
            : CompanyProfileDataOrigin.db;
        return result.CacheSuccess(entry.data, origin);
      }
    } catch (e) {
      if (source == Source.cache) {
        _logger.warning('Local cache fetch failed', e);
      } else {
        _logger.severe('Firestore server fetch failed', e);
        return result.CacheFailure(Failure.cache(e.toString()));
      }
    }
    return null;
  }

  Future<result.CacheResult<T>> syncOrFetch<T>({
    required DocumentReference<FirestoreCacheEntry<T>> docRef,
    required Future<T> Function() remoteFetcher,
    int weekendThresholdHour = 22,
    bool strictMarketAware = false,
    Duration fallbackTtl = const Duration(hours: 24),
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cacheResult = await fetchWithCacheFirst(
        docRef,
        weekendThresholdHour: weekendThresholdHour,
        strictMarketAware: strictMarketAware,
        fallbackTtl: fallbackTtl,
      );

      if (cacheResult is result.CacheSuccess<T>) {
        return cacheResult;
      }
    }

    return await _executeRemoteFetchAndCache(
      docRef: docRef,
      remoteFetcher: remoteFetcher,
    );
  }

  Future<result.CacheResult<T>> _executeRemoteFetchAndCache<T>({
    required DocumentReference<FirestoreCacheEntry<T>> docRef,
    required Future<T> Function() remoteFetcher,
  }) async {
    try {
      final remoteData = await remoteFetcher();

      _persistToCacheAsync(docRef, remoteData);

      return result.CacheSuccess(remoteData, CompanyProfileDataOrigin.api);
    } catch (e) {
      _logger.severe('Remote fetch failed', e);
      return await _fetchStaleFallback(docRef, e);
    }
  }

  void _persistToCacheAsync<T>(
    DocumentReference<FirestoreCacheEntry<T>> docRef,
    T data,
  ) {
    unawaited(
      saveToCache(docRef, data).catchError((e) {
        _logger.severe('Failed to save to local cache', e);
      }),
    );
  }

  Future<result.CacheResult<T>> _fetchStaleFallback<T>(
    DocumentReference<FirestoreCacheEntry<T>> docRef,
    Object originalError,
  ) async {
    try {
      final doc = await docRef.get(const GetOptions(source: Source.cache));
      final entry = doc.data();

      if (doc.exists && entry != null) {
        _logger.warning('Returning stale cache after remote failure');
        return result.CacheSuccess(entry.data, CompanyProfileDataOrigin.cache);
      }
    } catch (e) {
      _logger.warning('Stale cache fallback fetch failed', e);
    }

    return result.CacheFailure(Failure.server(originalError.toString()));
  }

  Future<void> saveToCache<T>(
    DocumentReference<FirestoreCacheEntry<T>> docRef,
    T data,
  ) async {
    await docRef.set(
      FirestoreCacheEntry(data: data, lastUpdated: _timeProvider.nowEt),
    );
  }
}
