import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as cache;
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTimeProvider extends Mock implements ITimeProvider {}

// Firestore marks these classes @sealed, but mocking them is required to
// simulate per-source (cache vs server) behaviour and fetch errors, which
// FakeFirebaseFirestore cannot differentiate.
// ignore: subtype_of_sealed_class
class MockDocumentReference extends Mock
    implements DocumentReference<FirestoreCacheEntry<String>> {}

// ignore: subtype_of_sealed_class
class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<FirestoreCacheEntry<String>> {}

class TestFirestoreCacheClient extends BaseFirestoreCacheClient {
  TestFirestoreCacheClient(
    FirestoreService firestoreService,
    ITimeProvider timeProvider,
  ) : super(firestoreService, timeProvider, 'TestFirestoreCacheClient');
}

const tTicker = 'AAPL';
const tCollectionPath = 'profile';
const tDocId = 'latest';
const tData = 'cached-data';
const tServerData = 'server-data';
const tRemoteData = 'remote-data';

// All fixtures are UTC-constructed so the client's toUtc() arithmetic is
// timezone-independent regardless of the machine running the tests.
// 2026-07-08 is a Wednesday, 2026-07-10 a Friday, 2026-07-11 a Saturday.
final tWednesdayAfternoonEt = DateTime.utc(2026, 7, 8, 14, 0);
final tFreshLastUpdated = DateTime.utc(2026, 7, 8, 13, 0);
final tStaleLastUpdated = DateTime.utc(2026, 7, 6, 10, 0);

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late MockTimeProvider mockTimeProvider;
  late MockDocumentReference mockDocRef;
  late TestFirestoreCacheClient sut;

  setUpAll(() {
    registerFallbackValue(const GetOptions());
    registerFallbackValue(
      FirestoreCacheEntry<String>(data: '', lastUpdated: DateTime.utc(2020)),
    );
  });

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    mockTimeProvider = MockTimeProvider();
    mockDocRef = MockDocumentReference();
    sut = TestFirestoreCacheClient(
      FirestoreService(fakeFirestore),
      mockTimeProvider,
    );
    when(() => mockTimeProvider.nowEt).thenReturn(tWednesdayAfternoonEt);
  });

  MockDocumentSnapshot buildSnapshot(
    FirestoreCacheEntry<String>? entry, {
    bool exists = true,
  }) {
    final snapshot = MockDocumentSnapshot();
    when(() => snapshot.exists).thenReturn(exists);
    when(snapshot.data).thenReturn(entry);
    return snapshot;
  }

  void stubGetForSource(
    Source source,
    DocumentSnapshot<FirestoreCacheEntry<String>> snapshot,
  ) {
    when(
      () => mockDocRef.get(
        any(that: isA<GetOptions>().having((o) => o.source, 'source', source)),
      ),
    ).thenAnswer((_) async => snapshot);
  }

  void stubBothSources(
    FirestoreCacheEntry<String>? entry, {
    bool exists = true,
  }) {
    stubGetForSource(Source.cache, buildSnapshot(entry, exists: exists));
    stubGetForSource(Source.server, buildSnapshot(entry, exists: exists));
  }

  FirestoreCacheEntry<String> buildEntry(
    DateTime lastUpdated, {
    String data = tData,
  }) {
    return FirestoreCacheEntry(data: data, lastUpdated: lastUpdated);
  }

  group('BaseFirestoreCacheClient', () {
    group('getCollectionRef', () {
      test(
        'getCollectionRef_withTicker_buildsCompaniesSubcollectionPath',
        () async {
          // arrange
          final ref = sut.getCollectionRef<String>(
            tTicker,
            tCollectionPath,
            (json) => json! as String,
            (value) => value,
          );

          // act
          await ref.doc(tDocId).set(buildEntry(tFreshLastUpdated));

          // assert
          final rawSnapshot = await fakeFirestore
              .collection(FirestoreConstants.companies)
              .doc(tTicker)
              .collection(tCollectionPath)
              .doc(tDocId)
              .get();
          expect(rawSnapshot.exists, isTrue);
          expect(rawSnapshot.data()?['data'], tData);
          expect(
            (rawSnapshot.data()?['lastUpdated'] as Timestamp).toDate().toUtc(),
            tFreshLastUpdated,
          );
        },
      );

      test('getCollectionRef_malformedEntry_throwsWhenDecoding', () async {
        // arrange
        await fakeFirestore
            .collection(FirestoreConstants.companies)
            .doc(tTicker)
            .collection(tCollectionPath)
            .doc(tDocId)
            .set({'data': tData});
        final ref = sut.getCollectionRef<String>(
          tTicker,
          tCollectionPath,
          (json) => json! as String,
          (value) => value,
        );

        // act
        Future<String?> readEntryData() async =>
            (await ref.doc(tDocId).get()).data()?.data;

        // assert
        await expectLater(readEntryData(), throwsA(isA<TypeError>()));
      });
    });

    group('getDocRef', () {
      test('getDocRef_withDocId_pointsToExpectedDocumentPath', () {
        // arrange
        const expectedPath =
            '${FirestoreConstants.companies}/$tTicker/$tCollectionPath/$tDocId';

        // act
        final docRef = sut.getDocRef<String>(
          tTicker,
          tCollectionPath,
          tDocId,
          (json) => json! as String,
          (value) => value,
        );

        // assert
        expect(docRef.path, expectedPath);
      });

      test('getDocRef_missingDocument_snapshotDoesNotExist', () async {
        // arrange
        final docRef = sut.getDocRef<String>(
          tTicker,
          tCollectionPath,
          tDocId,
          (json) => json! as String,
          (value) => value,
        );

        // act
        final snapshot = await docRef.get();

        // assert
        expect(snapshot.exists, isFalse);
      });
    });

    group('saveToCache', () {
      test('saveToCache_withData_persistsEntryWithNowEtTimestamp', () async {
        // arrange
        final docRef = sut.getDocRef<String>(
          tTicker,
          tCollectionPath,
          tDocId,
          (json) => json! as String,
          (value) => value,
        );

        // act
        await sut.saveToCache(docRef, tData);

        // assert
        final rawSnapshot = await fakeFirestore
            .collection(FirestoreConstants.companies)
            .doc(tTicker)
            .collection(tCollectionPath)
            .doc(tDocId)
            .get();
        expect(rawSnapshot.data()?['data'], tData);
        expect(
          (rawSnapshot.data()?['lastUpdated'] as Timestamp).toDate().toUtc(),
          tWednesdayAfternoonEt,
        );
      });

      test('saveToCache_setThrows_propagatesError', () async {
        // arrange
        when(() => mockDocRef.set(any())).thenThrow(Exception('write denied'));

        // act
        Future<void> save() => sut.saveToCache(mockDocRef, tData);

        // assert
        await expectLater(save(), throwsA(isA<Exception>()));
      });
    });

    group('fetchWithCacheFirst', () {
      test(
        'fetchWithCacheFirst_validCacheEntry_returnsCacheSuccessWithCacheOrigin',
        () async {
          // arrange
          stubGetForSource(
            Source.cache,
            buildSnapshot(buildEntry(tFreshLastUpdated)),
          );

          // act
          final result = await sut.fetchWithCacheFirst(mockDocRef);

          // assert
          expect(result, isA<cache.CacheSuccess<String>>());
          final success = result as cache.CacheSuccess<String>;
          expect(success.data, tData);
          expect(success.origin, CompanyProfileDataOrigin.cache);
        },
      );

      test(
        'fetchWithCacheFirst_staleCacheFreshServer_returnsCacheSuccessWithDbOrigin',
        () async {
          // arrange
          stubGetForSource(
            Source.cache,
            buildSnapshot(buildEntry(tStaleLastUpdated)),
          );
          stubGetForSource(
            Source.server,
            buildSnapshot(buildEntry(tFreshLastUpdated, data: tServerData)),
          );

          // act
          final result = await sut.fetchWithCacheFirst(mockDocRef);

          // assert
          expect(result, isA<cache.CacheSuccess<String>>());
          final success = result as cache.CacheSuccess<String>;
          expect(success.data, tServerData);
          expect(success.origin, CompanyProfileDataOrigin.db);
        },
      );

      test(
        'fetchWithCacheFirst_missingInBothSources_returnsCacheNotFound',
        () async {
          // arrange
          stubBothSources(null, exists: false);

          // act
          final result = await sut.fetchWithCacheFirst(mockDocRef);

          // assert
          expect(result.isNotFound, isTrue);
        },
      );

      test(
        'fetchWithCacheFirst_staleInBothSources_returnsCacheNotFound',
        () async {
          // arrange
          stubBothSources(buildEntry(tStaleLastUpdated));

          // act
          final result = await sut.fetchWithCacheFirst(mockDocRef);

          // assert
          expect(result.isNotFound, isTrue);
        },
      );

      test(
        'fetchWithCacheFirst_cacheThrowsFreshServer_returnsCacheSuccessWithDbOrigin',
        () async {
          // arrange
          when(
            () => mockDocRef.get(
              any(
                that: isA<GetOptions>().having(
                  (o) => o.source,
                  'source',
                  Source.cache,
                ),
              ),
            ),
          ).thenThrow(Exception('cache unavailable'));
          stubGetForSource(
            Source.server,
            buildSnapshot(buildEntry(tFreshLastUpdated, data: tServerData)),
          );

          // act
          final result = await sut.fetchWithCacheFirst(mockDocRef);

          // assert
          expect(result, isA<cache.CacheSuccess<String>>());
          final success = result as cache.CacheSuccess<String>;
          expect(success.data, tServerData);
          expect(success.origin, CompanyProfileDataOrigin.db);
        },
      );

      test(
        'fetchWithCacheFirst_serverFetchThrows_returnsCacheFailureWithCacheFailure',
        () async {
          // arrange
          stubGetForSource(Source.cache, buildSnapshot(null, exists: false));
          when(
            () => mockDocRef.get(
              any(
                that: isA<GetOptions>().having(
                  (o) => o.source,
                  'source',
                  Source.server,
                ),
              ),
            ),
          ).thenThrow(Exception('network down'));

          // act
          final result = await sut.fetchWithCacheFirst(mockDocRef);

          // assert
          expect(result, isA<cache.CacheFailure<String>>());
          final failureResult = result as cache.CacheFailure<String>;
          expect(
            failureResult.failure,
            Failure.cache(Exception('network down').toString()),
          );
        },
      );
    });

    group('smart cache validity', () {
      group('weekend', () {
        test(
          'fetchWithCacheFirst_saturdayEntryAfterFridayThreshold_returnsCacheSuccess',
          () async {
            // arrange
            when(
              () => mockTimeProvider.nowEt,
            ).thenReturn(DateTime.utc(2026, 7, 11, 12, 0));
            stubGetForSource(
              Source.cache,
              buildSnapshot(buildEntry(DateTime.utc(2026, 7, 10, 23, 0))),
            );

            // act
            final result = await sut.fetchWithCacheFirst(mockDocRef);

            // assert
            expect(result, isA<cache.CacheSuccess<String>>());
          },
        );

        test(
          'fetchWithCacheFirst_sundayEntryAfterFridayThreshold_returnsCacheSuccess',
          () async {
            // arrange
            when(
              () => mockTimeProvider.nowEt,
            ).thenReturn(DateTime.utc(2026, 7, 12, 12, 0));
            stubGetForSource(
              Source.cache,
              buildSnapshot(buildEntry(DateTime.utc(2026, 7, 10, 23, 0))),
            );

            // act
            final result = await sut.fetchWithCacheFirst(mockDocRef);

            // assert
            expect(result, isA<cache.CacheSuccess<String>>());
          },
        );

        test(
          'fetchWithCacheFirst_saturdayEntryBeforeFridayThreshold_returnsCacheNotFound',
          () async {
            // arrange
            when(
              () => mockTimeProvider.nowEt,
            ).thenReturn(DateTime.utc(2026, 7, 11, 12, 0));
            stubBothSources(buildEntry(DateTime.utc(2026, 7, 10, 21, 0)));

            // act
            final result = await sut.fetchWithCacheFirst(mockDocRef);

            // assert
            expect(result.isNotFound, isTrue);
          },
        );

        test(
          'fetchWithCacheFirst_customWeekendThresholdHour_validatesAgainstCustomAnchor',
          () async {
            // arrange
            when(
              () => mockTimeProvider.nowEt,
            ).thenReturn(DateTime.utc(2026, 7, 11, 12, 0));
            stubGetForSource(
              Source.cache,
              buildSnapshot(buildEntry(DateTime.utc(2026, 7, 10, 21, 0))),
            );

            // act
            final result = await sut.fetchWithCacheFirst(
              mockDocRef,
              weekendThresholdHour: 20,
            );

            // assert
            expect(result, isA<cache.CacheSuccess<String>>());
          },
        );
      });

      group('strict market-aware', () {
        test(
          'fetchWithCacheFirst_afterMarketOpenEntryAfterOpen_returnsCacheSuccess',
          () async {
            // arrange
            stubGetForSource(
              Source.cache,
              buildSnapshot(buildEntry(DateTime.utc(2026, 7, 8, 10, 0))),
            );

            // act
            final result = await sut.fetchWithCacheFirst(
              mockDocRef,
              strictMarketAware: true,
            );

            // assert
            expect(result, isA<cache.CacheSuccess<String>>());
          },
        );

        test(
          'fetchWithCacheFirst_afterMarketOpenEntryBeforeOpen_returnsCacheNotFound',
          () async {
            // arrange
            stubBothSources(buildEntry(DateTime.utc(2026, 7, 8, 9, 0)));

            // act
            final result = await sut.fetchWithCacheFirst(
              mockDocRef,
              strictMarketAware: true,
            );

            // assert
            expect(result.isNotFound, isTrue);
          },
        );

        test(
          'fetchWithCacheFirst_exactlyAtMarketOpen_usesMarketAwareValidation',
          () async {
            // arrange
            when(
              () => mockTimeProvider.nowEt,
            ).thenReturn(DateTime.utc(2026, 7, 8, 9, 30));
            stubBothSources(buildEntry(DateTime.utc(2026, 7, 7, 20, 0)));

            // act
            final result = await sut.fetchWithCacheFirst(
              mockDocRef,
              strictMarketAware: true,
            );

            // assert
            expect(result.isNotFound, isTrue);
          },
        );

        test(
          'fetchWithCacheFirst_afterCloseSettledIntradayEntry_returnsCacheNotFound',
          () async {
            // arrange: now is 5pm ET (close settled); entry captured intraday
            // at noon must be invalidated so the final close is re-fetched.
            when(
              () => mockTimeProvider.nowEt,
            ).thenReturn(DateTime.utc(2026, 7, 8, 17, 0));
            stubBothSources(buildEntry(DateTime.utc(2026, 7, 8, 12, 0)));

            // act
            final result = await sut.fetchWithCacheFirst(
              mockDocRef,
              strictMarketAware: true,
            );

            // assert
            expect(result.isNotFound, isTrue);
          },
        );

        test(
          'fetchWithCacheFirst_afterCloseSettledEntryAfterSettlement_returnsCacheSuccess',
          () async {
            // arrange: entry captured after the close settled reflects the
            // final closing price and stays valid.
            when(
              () => mockTimeProvider.nowEt,
            ).thenReturn(DateTime.utc(2026, 7, 8, 18, 0));
            stubGetForSource(
              Source.cache,
              buildSnapshot(buildEntry(DateTime.utc(2026, 7, 8, 16, 30))),
            );

            // act
            final result = await sut.fetchWithCacheFirst(
              mockDocRef,
              strictMarketAware: true,
            );

            // assert
            expect(result, isA<cache.CacheSuccess<String>>());
          },
        );

        test(
          'fetchWithCacheFirst_withinSettlementBufferIntradayEntry_returnsCacheSuccess',
          () async {
            // arrange: at 4:10pm ET the buffer has not elapsed, so the intraday
            // entry is still treated as valid (no premature re-fetch).
            when(
              () => mockTimeProvider.nowEt,
            ).thenReturn(DateTime.utc(2026, 7, 8, 16, 10));
            stubGetForSource(
              Source.cache,
              buildSnapshot(buildEntry(DateTime.utc(2026, 7, 8, 12, 0))),
            );

            // act
            final result = await sut.fetchWithCacheFirst(
              mockDocRef,
              strictMarketAware: true,
            );

            // assert
            expect(result, isA<cache.CacheSuccess<String>>());
          },
        );

        test(
          'fetchWithCacheFirst_beforeMarketOpenWithinTtl_returnsCacheSuccess',
          () async {
            // arrange
            when(
              () => mockTimeProvider.nowEt,
            ).thenReturn(DateTime.utc(2026, 7, 8, 8, 0));
            stubGetForSource(
              Source.cache,
              buildSnapshot(buildEntry(DateTime.utc(2026, 7, 7, 20, 0))),
            );

            // act
            final result = await sut.fetchWithCacheFirst(
              mockDocRef,
              strictMarketAware: true,
            );

            // assert
            expect(result, isA<cache.CacheSuccess<String>>());
          },
        );
      });

      group('ttl fallback', () {
        test(
          'fetchWithCacheFirst_entryExactlyTtlOld_returnsCacheNotFound',
          () async {
            // arrange
            stubBothSources(buildEntry(DateTime.utc(2026, 7, 7, 14, 0)));

            // act
            final result = await sut.fetchWithCacheFirst(mockDocRef);

            // assert
            expect(result.isNotFound, isTrue);
          },
        );

        test(
          'fetchWithCacheFirst_customTtlExpired_returnsCacheNotFound',
          () async {
            // arrange
            stubBothSources(buildEntry(DateTime.utc(2026, 7, 8, 12, 0)));

            // act
            final result = await sut.fetchWithCacheFirst(
              mockDocRef,
              fallbackTtl: const Duration(hours: 1),
            );

            // assert
            expect(result.isNotFound, isTrue);
          },
        );
      });
    });

    group('syncOrFetch', () {
      test('syncOrFetch_validCache_returnsCacheWithoutCallingRemote', () async {
        // arrange
        var remoteCallCount = 0;
        stubGetForSource(
          Source.cache,
          buildSnapshot(buildEntry(tFreshLastUpdated)),
        );

        // act
        final result = await sut.syncOrFetch(
          docRef: mockDocRef,
          remoteFetcher: () async {
            remoteCallCount++;
            return tRemoteData;
          },
        );

        // assert
        expect(result, isA<cache.CacheSuccess<String>>());
        final success = result as cache.CacheSuccess<String>;
        expect(success.data, tData);
        expect(success.origin, CompanyProfileDataOrigin.cache);
        expect(remoteCallCount, 0);
      });

      test(
        'syncOrFetch_forceRefresh_bypassesCacheAndReturnsApiSuccess',
        () async {
          // arrange
          when(() => mockDocRef.set(any())).thenAnswer((_) async {});

          // act
          final result = await sut.syncOrFetch(
            docRef: mockDocRef,
            remoteFetcher: () async => tRemoteData,
            forceRefresh: true,
          );

          // assert
          expect(result, isA<cache.CacheSuccess<String>>());
          final success = result as cache.CacheSuccess<String>;
          expect(success.data, tRemoteData);
          expect(success.origin, CompanyProfileDataOrigin.api);
          verifyNever(() => mockDocRef.get(any()));
        },
      );

      test(
        'syncOrFetch_cacheMissRemoteSucceeds_returnsApiSuccessAndPersistsEntry',
        () async {
          // arrange
          stubBothSources(null, exists: false);
          when(() => mockDocRef.set(any())).thenAnswer((_) async {});

          // act
          final result = await sut.syncOrFetch(
            docRef: mockDocRef,
            remoteFetcher: () async => tRemoteData,
          );

          // assert
          expect(result, isA<cache.CacheSuccess<String>>());
          final success = result as cache.CacheSuccess<String>;
          expect(success.data, tRemoteData);
          expect(success.origin, CompanyProfileDataOrigin.api);
          await untilCalled(() => mockDocRef.set(any()));
          final capturedEntry =
              verify(() => mockDocRef.set(captureAny())).captured.single
                  as FirestoreCacheEntry<String>;
          expect(capturedEntry.data, tRemoteData);
          expect(capturedEntry.lastUpdated, tWednesdayAfternoonEt);
        },
      );

      test(
        'syncOrFetch_remoteThrowsWithStaleCache_returnsStaleCacheSuccess',
        () async {
          // arrange
          stubBothSources(buildEntry(tStaleLastUpdated));

          // act
          final result = await sut.syncOrFetch(
            docRef: mockDocRef,
            remoteFetcher: () async => throw Exception('api down'),
          );

          // assert
          expect(result, isA<cache.CacheSuccess<String>>());
          final success = result as cache.CacheSuccess<String>;
          expect(success.data, tData);
          expect(success.origin, CompanyProfileDataOrigin.cache);
        },
      );

      test(
        'syncOrFetch_remoteThrowsWithoutCache_returnsCacheFailureWithServerFailure',
        () async {
          // arrange
          stubBothSources(null, exists: false);

          // act
          final result = await sut.syncOrFetch(
            docRef: mockDocRef,
            remoteFetcher: () async => throw Exception('api down'),
          );

          // assert
          expect(result, isA<cache.CacheFailure<String>>());
          final failureResult = result as cache.CacheFailure<String>;
          expect(
            failureResult.failure,
            Failure.server(Exception('api down').toString()),
          );
        },
      );

      test('syncOrFetch_persistFails_stillReturnsApiSuccess', () async {
        // arrange
        stubBothSources(null, exists: false);
        when(() => mockDocRef.set(any())).thenThrow(Exception('write denied'));

        // act
        final result = await sut.syncOrFetch(
          docRef: mockDocRef,
          remoteFetcher: () async => tRemoteData,
        );

        // assert
        expect(result, isA<cache.CacheSuccess<String>>());
        final success = result as cache.CacheSuccess<String>;
        expect(success.data, tRemoteData);
        expect(success.origin, CompanyProfileDataOrigin.api);
      });
    });
  });
}
