// ignore_for_file: subtype_of_sealed_class
import 'dart:async';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:bizzie/features/onboarding/data/dtos/onboarding_profile_update_dto.dart';
import 'package:bizzie/core/data/dtos/user_dto.dart';
import 'package:bizzie/core/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

class MockConfigService extends Mock implements ConfigService {}

class MockBizzieBatch extends Mock implements BizzieBatch {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class FakeDocumentReference extends Fake
    implements DocumentReference<Map<String, dynamic>> {}

const tDataSourceLoggerName = 'OnboardingRemoteDataSource';

final tUserDto = UserDto(
  uid: '123',
  name: 'John',
  fcmTokens: {},
  investingExperience: 'beginner',
  isSubscribed: false,
  favoriteSector: '',
  createdAt: DateTime(2023),
);

final tWatchlistItem = WatchlistItemDto(
  ticker: 'AAPL',
  companyName: 'Apple',
  createdAt: DateTime(2023),
);

const tProfileUpdateDto = OnboardingProfileUpdateDto(
  name: 'Jane',
  investingExperience: 'expert',
  notificationsEnabled: true,
);

void main() {
  late OnboardingRemoteDataSource dataSource;
  late MockFirestoreService mockFirestoreService;
  late MockConfigService mockConfigService;

  setUpAll(() {
    registerFallbackValue(FakeDocumentReference());
    registerFallbackValue(tWatchlistItem);
  });

  setUp(() {
    mockFirestoreService = MockFirestoreService();
    mockConfigService = MockConfigService();

    dataSource = OnboardingRemoteDataSource(
      mockFirestoreService,
      mockConfigService,
    );
  });

  group('OnboardingRemoteDataSource', () {
    test('getStockMarketSectors_success_returnsSectorsFromConfig', () {
      // Arrange
      const tSectors = ['Tech', 'Health'];
      when(() => mockConfigService.stockMarketSectors).thenReturn(tSectors);

      // Act
      final result = dataSource.getStockMarketSectors();

      // Assert
      expect(result, tSectors);
      verify(() => mockConfigService.stockMarketSectors).called(1);
    });

    test('getOnboardingConfig_success_returnsBoolFromConfig', () {
      // Arrange
      const tKey = 'show_intro';
      when(() => mockConfigService.getBool(tKey)).thenReturn(true);

      // Act
      final result = dataSource.getOnboardingConfig(tKey);

      // Assert
      expect(result, true);
      verify(() => mockConfigService.getBool(tKey)).called(1);
    });

    group('userProfileExists', () {
      void stubProfileRead(Future<Map<String, dynamic>?> Function() read) {
        when(
          () => mockFirestoreService.getDocument<Map<String, dynamic>>(
            path: any(named: 'path'),
            fromJson: any(named: 'fromJson'),
            toJson: any(named: 'toJson'),
          ),
        ).thenAnswer((_) => read());
      }

      test('userProfileExists_documentFound_returnsTrue', () async {
        // arrange
        stubProfileRead(() async => {'name': 'Jane'});

        // act
        final result = await dataSource.userProfileExists('123');

        // assert
        expect(result, isTrue);
        verify(
          () => mockFirestoreService.getDocument<Map<String, dynamic>>(
            path: 'users/123',
            fromJson: any(named: 'fromJson'),
            toJson: any(named: 'toJson'),
          ),
        ).called(1);
      });

      test('userProfileExists_noDocument_returnsFalse', () async {
        // arrange
        stubProfileRead(() async => null);

        // act
        final result = await dataSource.userProfileExists('123');

        // assert
        expect(result, isFalse);
      });

      test('userProfileExists_readFails_rethrows', () async {
        // arrange
        stubProfileRead(() async => throw Exception('offline'));

        // act
        final call = dataSource.userProfileExists('123');

        // assert
        await expectLater(call, throwsException);
      });
    });

    test('saveUserProfile_validUser_callsBatchCommit', () async {
      // Arrange
      final tUser = UserDto(
        uid: '123',
        name: 'John',
        fcmTokens: {},
        investingExperience: 'beginner',
        isSubscribed: false,
        favoriteSector: '',
        createdAt: DateTime(2023),
      );

      final mockBizzieBatch = MockBizzieBatch();

      when(() => mockFirestoreService.batch()).thenReturn(mockBizzieBatch);
      when(
        () => mockBizzieBatch.setRaw(
          path: any(named: 'path'),
          data: any(named: 'data'),
        ),
      ).thenReturn(null);
      when(() => mockBizzieBatch.commit()).thenAnswer((_) async {});

      // Act
      await dataSource.saveUserProfile(tUser, []);

      // Assert
      verify(() => mockFirestoreService.batch()).called(1);
      verify(() => mockBizzieBatch.commit()).called(1);
      verify(
        () => mockBizzieBatch.setRaw(
          path: 'users/123',
          data: any(named: 'data'),
        ),
      ).called(1);
    });

    test(
      'saveUserProfile_firstWrite_createsFullDocWithCreatedAtSubscriptionAndWatchlist',
      () async {
        // arrange
        final mockBizzieBatch = MockBizzieBatch();
        when(() => mockFirestoreService.batch()).thenReturn(mockBizzieBatch);
        when(
          () => mockBizzieBatch.setRaw(
            path: any(named: 'path'),
            data: any(named: 'data'),
          ),
        ).thenReturn(null);
        when(
          () => mockBizzieBatch.setDocument<WatchlistItemDto>(
            path: any(named: 'path'),
            value: any(named: 'value'),
            toJson: any(named: 'toJson'),
          ),
        ).thenReturn(null);
        when(() => mockBizzieBatch.commit()).thenAnswer((_) async {});

        // act
        await dataSource.saveUserProfile(tUserDto, [tWatchlistItem]);

        // assert
        final userData =
            verify(
                  () => mockBizzieBatch.setRaw(
                    path: 'users/123',
                    data: captureAny(named: 'data'),
                  ),
                ).captured.single
                as Map<String, dynamic>;
        expect(userData['createdAt'], isA<FieldValue>());
        expect(userData['isSubscribed'], isFalse);
        expect(userData['fcmTokens'], isEmpty);
        expect(userData['name'], 'John');
        verify(
          () => mockBizzieBatch.setDocument<WatchlistItemDto>(
            path: 'users/123/watchlist/AAPL',
            value: tWatchlistItem,
            toJson: any(named: 'toJson'),
          ),
        ).called(1);
      },
    );

    group('updateOnboardingProfile', () {
      test(
        'updateOnboardingProfile_ownedFields_updatesOnlyThoseFieldsOnUserDoc',
        () async {
          // arrange
          when(
            () => mockFirestoreService.updateDocument(
              path: any(named: 'path'),
              data: any(named: 'data'),
            ),
          ).thenAnswer((_) async {});

          // act
          await dataSource.updateOnboardingProfile('123', tProfileUpdateDto);

          // assert
          final data =
              verify(
                    () => mockFirestoreService.updateDocument(
                      path: 'users/123',
                      data: captureAny(named: 'data'),
                    ),
                  ).captured.single
                  as Map<String, dynamic>;
          expect(data, {
            'name': 'Jane',
            'investingExperience': 'expert',
            'notificationsEnabled': true,
          });
          expect(
            data.keys,
            isNot(
              anyElement(
                isIn([
                  'isSubscribed',
                  'createdAt',
                  'fcmTokens',
                  'favoriteSector',
                ]),
              ),
            ),
          );
          verifyNever(() => mockFirestoreService.batch());
        },
      );

      test('updateOnboardingProfile_nullFields_omitsThemFromUpdate', () async {
        // arrange
        when(
          () => mockFirestoreService.updateDocument(
            path: any(named: 'path'),
            data: any(named: 'data'),
          ),
        ).thenAnswer((_) async {});

        // act
        await dataSource.updateOnboardingProfile(
          '123',
          const OnboardingProfileUpdateDto(name: 'Jane'),
        );

        // assert
        verify(
          () => mockFirestoreService.updateDocument(
            path: 'users/123',
            data: {'name': 'Jane'},
          ),
        ).called(1);
      });

      test('updateOnboardingProfile_noFields_skipsWrite', () async {
        // arrange

        // act
        await dataSource.updateOnboardingProfile(
          '123',
          const OnboardingProfileUpdateDto(),
        );

        // assert
        verifyNever(
          () => mockFirestoreService.updateDocument(
            path: any(named: 'path'),
            data: any(named: 'data'),
          ),
        );
        verifyNever(() => mockFirestoreService.batch());
      });

      test(
        'updateOnboardingProfile_awaitServerAckFalse_completesBeforeWriteResolves',
        () async {
          // arrange
          final writeCompleter = Completer<void>();
          when(
            () => mockFirestoreService.updateDocument(
              path: any(named: 'path'),
              data: any(named: 'data'),
            ),
          ).thenAnswer((_) => writeCompleter.future);

          // act
          await dataSource.updateOnboardingProfile(
            '123',
            tProfileUpdateDto,
            awaitServerAck: false,
          );

          // assert
          expect(writeCompleter.isCompleted, isFalse);
          verify(
            () => mockFirestoreService.updateDocument(
              path: 'users/123',
              data: any(named: 'data'),
            ),
          ).called(1);
        },
      );

      test('updateOnboardingProfile_updateFails_rethrows', () async {
        // arrange
        final tError = FirebaseException(
          plugin: 'cloud_firestore',
          code: 'not-found',
        );
        when(
          () => mockFirestoreService.updateDocument(
            path: any(named: 'path'),
            data: any(named: 'data'),
          ),
        ).thenAnswer((_) async => throw tError);

        // act
        final call = dataSource.updateOnboardingProfile(
          '123',
          tProfileUpdateDto,
        );

        // assert
        await expectLater(call, throwsA(tError));
      });
    });

    group('saveUserProfile awaitServerAck', () {
      late MockBizzieBatch mockBizzieBatch;
      late Completer<void> commitCompleter;

      setUp(() {
        mockBizzieBatch = MockBizzieBatch();
        commitCompleter = Completer<void>();
        when(() => mockFirestoreService.batch()).thenReturn(mockBizzieBatch);
        when(
          () => mockBizzieBatch.setRaw(
            path: any(named: 'path'),
            data: any(named: 'data'),
          ),
        ).thenReturn(null);
        when(
          () => mockBizzieBatch.commit(),
        ).thenAnswer((_) => commitCompleter.future);
      });

      test(
        'saveUserProfile_awaitServerAckFalse_completesBeforeCommitResolves',
        () async {
          // arrange
          var isSaveCompleted = false;

          // act
          final save = dataSource
              .saveUserProfile(tUserDto, [], awaitServerAck: false)
              .then((_) => isSaveCompleted = true);
          await save;

          // assert
          expect(isSaveCompleted, isTrue);
          expect(commitCompleter.isCompleted, isFalse);
          verify(() => mockBizzieBatch.commit()).called(1);
        },
      );

      test(
        'saveUserProfile_awaitServerAckFalseCommitFails_logsSevereWithoutThrowing',
        () async {
          // arrange
          final tError = FirebaseException(
            plugin: 'cloud_firestore',
            code: 'permission-denied',
          );
          final records = <LogRecord>[];
          final subscription = BizzieLogger.logRecord
              .where((record) => record.loggerName == tDataSourceLoggerName)
              .listen(records.add);
          addTearDown(subscription.cancel);

          // act
          await dataSource.saveUserProfile(tUserDto, [], awaitServerAck: false);
          commitCompleter.completeError(tError);
          await pumpEventQueue();

          // assert
          final severeRecords = records.where(
            (record) => record.level == Level.SEVERE,
          );
          expect(severeRecords, hasLength(1));
          expect(severeRecords.single.error, tError);
        },
      );

      test(
        'saveUserProfile_awaitServerAckDefault_waitsForCommitToResolve',
        () async {
          // arrange
          var isSaveCompleted = false;

          // act
          final save = dataSource
              .saveUserProfile(tUserDto, [])
              .then((_) => isSaveCompleted = true);
          await pumpEventQueue();
          final isCompletedBeforeAck = isSaveCompleted;
          commitCompleter.complete();
          await save;

          // assert
          expect(isCompletedBeforeAck, isFalse);
          expect(isSaveCompleted, isTrue);
        },
      );

      test(
        'saveUserProfile_awaitServerAckDefaultCommitFails_rethrows',
        () async {
          // arrange
          final tError = FirebaseException(
            plugin: 'cloud_firestore',
            code: 'unavailable',
          );
          when(() => mockBizzieBatch.commit()).thenThrow(tError);

          // act
          final call = dataSource.saveUserProfile(tUserDto, []);

          // assert
          await expectLater(call, throwsA(tError));
        },
      );
    });
  });
}
