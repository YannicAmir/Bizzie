import 'package:bizzie/features/user/data/datasources/user_remote_datasource.dart';
import 'package:bizzie/features/user/data/dtos/user_dto.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  late UserRemoteDataSource dataSource;
  late MockFirestoreService mockFirestoreService;

  setUpAll(() {
    registerFallbackValue(
      UserDto(
        uid: 'fallback',
        name: 'fallback',
        favoriteSector: 'fallback',
        investingExperience: 'beginner',
        createdAt: DateTime(2023),
        fcmTokens: const {},
      ),
    );
    registerFallbackValue(
      WatchlistItemDto(
        ticker: 'fallback',
        companyName: 'fallback',
        createdAt: DateTime(2023),
      ),
    );
    registerFallbackValue(FieldValue.delete());
  });

  setUp(() {
    mockFirestoreService = MockFirestoreService();
    dataSource = UserRemoteDataSource(mockFirestoreService);
  });

  const tUid = 'user_123';
  const tDeviceId = 'device_456';
  const tToken = 'token_789';

  final tUserDto = UserDto(
    uid: tUid,
    name: 'Test User',
    favoriteSector: 'Technology',
    investingExperience: 'beginner',
    createdAt: DateTime(2023),
    fcmTokens: {tDeviceId: tToken},
  );

  final tWatchlistItem = WatchlistItemDto(
    ticker: 'AAPL',
    companyName: 'Apple Inc.',
    createdAt: DateTime(2023),
  );

  group('UserRemoteDataSource', () {
    group('getUser', () {
      test('userRemoteDataSource_getUser_success_returnsUserDto', () async {
        // arrange
        when(
          () => mockFirestoreService.getDocument<UserDto>(
            path: any(named: 'path'),
            fromJson: UserDto.fromJson,
            toJson: any(named: 'toJson'),
          ),
        ).thenAnswer((_) async => tUserDto);

        // act
        final result = await dataSource.getUser(tUid);

        // assert
        expect(result, equals(tUserDto));
        verify(
          () => mockFirestoreService.getDocument<UserDto>(
            path: 'users/$tUid',
            fromJson: UserDto.fromJson,
            toJson: any(named: 'toJson'),
          ),
        ).called(1);
      });

      test('userRemoteDataSource_getUser_noUser_returnsNull', () async {
        // arrange
        when(
          () => mockFirestoreService.getDocument<UserDto>(
            path: any(named: 'path'),
            fromJson: UserDto.fromJson,
            toJson: any(named: 'toJson'),
          ),
        ).thenAnswer((_) async => null);

        // act
        final result = await dataSource.getUser(tUid);

        // assert
        expect(result, isNull);
      });

      test('userRemoteDataSource_getUser_failure_rethrowsException', () async {
        // arrange
        when(
          () => mockFirestoreService.getDocument<UserDto>(
            path: any(named: 'path'),
            fromJson: UserDto.fromJson,
            toJson: any(named: 'toJson'),
          ),
        ).thenThrow(Exception('Firestore error'));

        // act & assert
        expect(() => dataSource.getUser(tUid), throwsException);
      });
    });

    group('watchUser', () {
      test('userRemoteDataSource_watchUser_returnsStreamOfUserDto', () {
        // arrange
        final stream = Stream.value(tUserDto);
        when(
          () => mockFirestoreService.getDocumentStream<UserDto>(
            path: any(named: 'path'),
            fromJson: UserDto.fromJson,
            toJson: any(named: 'toJson'),
          ),
        ).thenAnswer((_) => stream);

        // act
        final result = dataSource.watchUser(tUid);

        // assert
        expect(result, emits(tUserDto));
      });
    });

    group('updateUser', () {
      test('userRemoteDataSource_updateUser_success_callsFirestore', () async {
        // arrange
        when(
          () => mockFirestoreService.setDocument<UserDto>(
            path: any(named: 'path'),
            value: any(named: 'value'),
            toJson: any(named: 'toJson'),
            merge: any(named: 'merge'),
          ),
        ).thenAnswer((_) async {});

        // act
        await dataSource.updateUser(tUserDto);

        // assert
        verify(
          () => mockFirestoreService.setDocument<UserDto>(
            path: 'users/${tUserDto.uid}',
            value: tUserDto,
            toJson: any(named: 'toJson'),
            merge: true,
          ),
        ).called(1);
      });
    });

    group('updateFcmToken', () {
      test(
        'userRemoteDataSource_updateFcmToken_success_callsFirestore',
        () async {
          // arrange
          when(
            () => mockFirestoreService.updateDocument(
              path: any(named: 'path'),
              data: any(named: 'data'),
            ),
          ).thenAnswer((_) async {});

          // act
          await dataSource.updateFcmToken(tUid, tDeviceId, tToken);

          // assert
          verify(
            () => mockFirestoreService.updateDocument(
              path: 'users/$tUid',
              data: {'fcmTokens.$tDeviceId': tToken},
            ),
          ).called(1);
        },
      );
    });

    group('removeFcmToken', () {
      test(
        'userRemoteDataSource_removeFcmToken_success_callsFirestore',
        () async {
          // arrange
          when(
            () => mockFirestoreService.updateDocument(
              path: any(named: 'path'),
              data: any(named: 'data'),
            ),
          ).thenAnswer((_) async {});

          // act
          await dataSource.removeFcmToken(tUid, tDeviceId);

          // assert
          verify(
            () => mockFirestoreService.updateDocument(
              path: 'users/$tUid',
              data: any(named: 'data'),
            ),
          ).called(1);
        },
      );
    });

    group('updateNotificationSettings', () {
      test(
        'userRemoteDataSource_updateNotificationSettings_enabledOnly_callsFirestoreCorrectly',
        () async {
          // arrange
          when(
            () => mockFirestoreService.updateDocument(
              path: any(named: 'path'),
              data: any(named: 'data'),
            ),
          ).thenAnswer((_) async {});

          // act
          await dataSource.updateNotificationSettings(tUid, true);

          // assert
          verify(
            () => mockFirestoreService.updateDocument(
              path: 'users/$tUid',
              data: {'notificationsEnabled': true},
            ),
          ).called(1);
        },
      );

      test(
        'userRemoteDataSource_updateNotificationSettings_enabledWithToken_callsFirestoreCorrectly',
        () async {
          // arrange
          when(
            () => mockFirestoreService.updateDocument(
              path: any(named: 'path'),
              data: any(named: 'data'),
            ),
          ).thenAnswer((_) async {});

          // act
          await dataSource.updateNotificationSettings(
            tUid,
            true,
            deviceId: tDeviceId,
            token: tToken,
          );

          // assert
          verify(
            () => mockFirestoreService.updateDocument(
              path: 'users/$tUid',
              data: {
                'notificationsEnabled': true,
                'fcmTokens.$tDeviceId': tToken,
              },
            ),
          ).called(1);
        },
      );

      test(
        'userRemoteDataSource_updateNotificationSettings_disabled_callsFirestoreCorrectly',
        () async {
          // arrange
          when(
            () => mockFirestoreService.updateDocument(
              path: any(named: 'path'),
              data: any(named: 'data'),
            ),
          ).thenAnswer((_) async {});

          // act
          await dataSource.updateNotificationSettings(tUid, false);

          // assert
          verify(
            () => mockFirestoreService.updateDocument(
              path: 'users/$tUid',
              data: {'notificationsEnabled': false},
            ),
          ).called(1);
        },
      );
    });

    group('getWatchlist', () {
      test('userRemoteDataSource_getWatchlist_success_returnsList', () async {
        // arrange
        final tWatchlist = [tWatchlistItem];
        when(
          () => mockFirestoreService.getCollection<WatchlistItemDto>(
            path: any(named: 'path'),
            fromJson: WatchlistItemDto.fromJson,
            toJson: any(named: 'toJson'),
          ),
        ).thenAnswer((_) async => tWatchlist);

        // act
        final result = await dataSource.getWatchlist(tUid);

        // assert
        expect(result, equals(tWatchlist));
      });
    });

    group('watchWatchlist', () {
      test('userRemoteDataSource_watchWatchlist_returnsStream', () {
        // arrange
        final tWatchlist = [tWatchlistItem];
        final stream = Stream.value(tWatchlist);
        when(
          () => mockFirestoreService.getCollectionStream<WatchlistItemDto>(
            path: any(named: 'path'),
            fromJson: WatchlistItemDto.fromJson,
            toJson: any(named: 'toJson'),
          ),
        ).thenAnswer((_) => stream);

        // act
        final result = dataSource.watchWatchlist(tUid);

        // assert
        expect(result, emits(tWatchlist));
      });
    });
  });
}
