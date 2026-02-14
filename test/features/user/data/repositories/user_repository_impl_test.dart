import 'dart:async';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart' as auth;
import 'package:bizzie/features/user/data/datasources/user_local_datasource.dart';
import 'package:bizzie/features/user/data/datasources/user_remote_datasource.dart';
import 'package:bizzie/features/user/data/dtos/user_dto.dart';
import 'package:bizzie/features/user/data/repositories/user_repository_impl.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRemoteDataSource extends Mock implements IUserRemoteDataSource {}

class MockUserLocalDataSource extends Mock implements IUserLocalDataSource {}

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemoteDataSource;
  late MockUserLocalDataSource mockLocalDataSource;
  late MockAuthRepository mockAuthRepository;

  final tUid = 'test-uid';
  final tDeviceId = 'device-123';
  final tToken = 'token-456';
  final tNow = DateTime(2024);

  final tUserDto = UserDto(
    uid: tUid,
    name: 'Test User',
    favoriteSector: 'Technology',
    investingExperience: 'beginner',
    createdAt: tNow,
    isSubscribed: false,
    fcmTokens: {tDeviceId: tToken},
  );

  final tUserModel = UserModel(
    uid: tUid,
    name: 'Test User',
    favoriteSector: 'Technology',
    investingExperience: InvestingExperience.beginner,
    createdAt: tNow,
    isSubscribed: false,
    fcmTokens: {tDeviceId: tToken},
  );

  final tWatchlistDto = WatchlistItemDto(
    ticker: 'AAPL',
    companyName: 'Apple Inc.',
    createdAt: tNow,
  );

  final tAuthUser = auth.UserModel(id: tUid, email: 'test@example.com');

  setUpAll(() {
    registerFallbackValue(tUserDto);
    registerFallbackValue(tUserModel);
  });

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockLocalDataSource = MockUserLocalDataSource();
    mockAuthRepository = MockAuthRepository();
    repository = UserRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockAuthRepository,
    );
  });

  group('getUser', () {
    test(
      'userRepository_getUser_success_returnsUserModelAndCachesSector',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getUser(any()),
        ).thenAnswer((_) async => tUserDto);
        when(
          () => mockRemoteDataSource.getWatchlist(any()),
        ).thenAnswer((_) async => [tWatchlistDto]);
        when(
          () => mockLocalDataSource.getCachedFavoriteSector(),
        ).thenReturn(null);
        when(
          () => mockLocalDataSource.cacheFavoriteSector(any()),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.getUser(tUid);

        // assert
        final expectedUser = tUserModel.copyWith(
          watchlist: [tWatchlistDto.toDomain()],
        );
        expect(result, Right(expectedUser));
        verify(() => mockRemoteDataSource.getUser(tUid)).called(1);
        verify(() => mockRemoteDataSource.getWatchlist(tUid)).called(1);
        verify(
          () =>
              mockLocalDataSource.cacheFavoriteSector(tUserDto.favoriteSector),
        ).called(1);
      },
    );

    test('userRepository_getUser_userNotFound_returnsFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getUser(any()),
      ).thenAnswer((_) async => null);

      // act
      final result = await repository.getUser(tUid);

      // assert
      expect(result, Left(Failure.userNotFound()));
    });

    test('userRepository_getUser_failure_returnsServerFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getUser(any()),
      ).thenThrow(Exception('DB Error'));

      // act
      final result = await repository.getUser(tUid);

      // assert
      expect(result, const Left(ServerFailure('Failed to get user')));
    });
  });

  group('watchUser', () {
    test(
      'userRepository_watchUser_success_emitsMappedUserWithWatchlist',
      () async {
        // arrange
        final userStream = Stream.value(tUserDto);
        final watchlistStream = Stream.value([tWatchlistDto]);
        when(
          () => mockRemoteDataSource.watchUser(tUid),
        ).thenAnswer((_) => userStream);
        when(
          () => mockRemoteDataSource.watchWatchlist(tUid),
        ).thenAnswer((_) => watchlistStream);
        when(
          () => mockLocalDataSource.getCachedFavoriteSector(),
        ).thenReturn('Technology');

        // act
        final streamResult = repository.watchUser(tUid);

        // assert
        expect(
          streamResult,
          emits(
            isA<UserModel>()
                .having((u) => u.uid, 'uid', tUid)
                .having((u) => u.watchlist.length, 'watchlist length', 1),
          ),
        );
      },
    );

    test('userRepository_watchUser_mappingError_throwsException', () async {
      // arrange
      final userStream = Stream.value(tUserDto);
      // Corrupt DTO to trigger toDomain() error if possible, or just mock error
      when(
        () => mockRemoteDataSource.watchUser(tUid),
      ).thenAnswer((_) => userStream);
      when(
        () => mockRemoteDataSource.watchWatchlist(tUid),
      ).thenAnswer((_) => Stream.error(Exception('Stream Error')));

      // act
      final streamResult = repository.watchUser(tUid);

      // assert
      expect(() => streamResult.first, throwsA(isA<Exception>()));
    });
  });

  group('updateUser', () {
    test('userRepository_updateUser_success_callsRemoteAndLocal', () async {
      // arrange
      when(
        () => mockRemoteDataSource.updateUser(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockLocalDataSource.cacheFavoriteSector(any()),
      ).thenAnswer((_) async {});

      // act
      final result = await repository.updateUser(tUserModel);

      // assert
      expect(result, const Right(null));
      verify(() => mockRemoteDataSource.updateUser(any())).called(1);
      verify(
        () =>
            mockLocalDataSource.cacheFavoriteSector(tUserModel.favoriteSector),
      ).called(1);
    });

    test('userRepository_updateUser_failure_returnsServerFailure', () async {
      // arrange
      when(() => mockRemoteDataSource.updateUser(any())).thenThrow(Exception());

      // act
      final result = await repository.updateUser(tUserModel);

      // assert
      expect(result, const Left(ServerFailure('Failed to update user')));
    });
  });

  group('getCachedFavoriteSector', () {
    test('userRepository_getCachedFavoriteSector_success_returnsValue', () {
      // arrange
      when(
        () => mockLocalDataSource.getCachedFavoriteSector(),
      ).thenReturn('Tech');

      // act
      final result = repository.getCachedFavoriteSector();

      // assert
      expect(result, 'Tech');
    });
  });

  group('updateFcmToken', () {
    test('userRepository_updateFcmToken_success_callsRemote', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockRemoteDataSource.updateFcmToken(any(), any(), any()),
      ).thenAnswer((_) async {});

      // act
      final result = await repository.updateFcmToken(tDeviceId, tToken);

      // assert
      expect(result, const Right(null));
      verify(
        () => mockRemoteDataSource.updateFcmToken(tUid, tDeviceId, tToken),
      ).called(1);
    });

    test('userRepository_updateFcmToken_userNotFound_returnsFailure', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(null);

      // act
      final result = await repository.updateFcmToken(tDeviceId, tToken);

      // assert
      expect(result, Left(Failure.userNotFound()));
    });

    test(
      'userRepository_updateFcmToken_failure_returnsServerFailure',
      () async {
        // arrange
        when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
        when(
          () => mockRemoteDataSource.updateFcmToken(any(), any(), any()),
        ).thenThrow(Exception('error'));

        // act
        final result = await repository.updateFcmToken(tDeviceId, tToken);

        // assert
        expect(result, isA<Left>());
      },
    );
  });

  group('removeFcmToken', () {
    test('userRepository_removeFcmToken_success_callsRemote', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockRemoteDataSource.removeFcmToken(any(), any()),
      ).thenAnswer((_) async {});

      // act
      final result = await repository.removeFcmToken(tDeviceId);

      // assert
      expect(result, const Right(null));
      verify(
        () => mockRemoteDataSource.removeFcmToken(tUid, tDeviceId),
      ).called(1);
    });
  });

  group('updateNotificationSettings', () {
    test(
      'userRepository_updateNotificationSettings_success_callsRemote',
      () async {
        // arrange
        when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
        when(
          () => mockRemoteDataSource.updateNotificationSettings(
            any(),
            any(),
            deviceId: any(named: 'deviceId'),
            token: any(named: 'token'),
          ),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.updateNotificationSettings(
          true,
          deviceId: tDeviceId,
          token: tToken,
        );

        // assert
        expect(result, const Right(null));
        verify(
          () => mockRemoteDataSource.updateNotificationSettings(
            tUid,
            true,
            deviceId: tDeviceId,
            token: tToken,
          ),
        ).called(1);
      },
    );
  });

  group('userStream', () {
    test('userRepository_userStream_emitsUserWhenAuthenticated', () async {
      // arrange
      final authController = StreamController<auth.UserModel?>();
      final userController = StreamController<UserDto>();
      final watchlistController = StreamController<List<WatchlistItemDto>>();

      when(
        () => mockAuthRepository.authStateChanges,
      ).thenAnswer((_) => authController.stream);
      when(
        () => mockRemoteDataSource.watchUser(tUid),
      ).thenAnswer((_) => userController.stream);
      when(
        () => mockRemoteDataSource.watchWatchlist(tUid),
      ).thenAnswer((_) => watchlistController.stream);
      when(
        () => mockLocalDataSource.getCachedFavoriteSector(),
      ).thenReturn('Technology');

      // act
      final stream = repository.userStream;

      // assert
      final expectFuture = expectLater(
        stream,
        emits(isA<UserModel>().having((u) => u.uid, 'uid', tUid)),
      );

      authController.add(tAuthUser);
      await Future.delayed(Duration.zero);
      userController.add(tUserDto);
      watchlistController.add([]);

      await expectFuture;
      authController.close();
    });

    test('userRepository_userStream_emitsEmptyWhenLoggedOut', () async {
      // arrange
      final authController = StreamController<auth.UserModel?>();
      when(
        () => mockAuthRepository.authStateChanges,
      ).thenAnswer((_) => authController.stream);

      // act
      final stream = repository.userStream;

      // assert
      authController.add(null);

      bool emitted = false;
      final sub = stream.listen((_) => emitted = true);

      await Future.delayed(const Duration(milliseconds: 50));
      expect(emitted, false);
      sub.cancel();
      authController.close();
    });
  });
}
