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
  final tNow = DateTime(2024);

  final tUserDto = UserDto(
    uid: tUid,
    name: 'Test User',
    favoriteSector: 'Technology',
    investingExperience: 'beginner',
    createdAt: tNow,
    isSubscribed: false,
    fcmTokens: const {},
  );

  final tUserModel = UserModel(
    uid: tUid,
    name: 'Test User',
    favoriteSector: 'Technology',
    investingExperience: InvestingExperience.beginner,
    createdAt: tNow,
    isSubscribed: false,
  );

  final tWatchlistDto = WatchlistItemDto(
    ticker: 'AAPL',
    companyName: 'Apple Inc.',
    createdAt: tNow,
  );

  final tAuthUser = auth.UserModel(id: tUid, email: 'test@example.com');

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockLocalDataSource = MockUserLocalDataSource();
    mockAuthRepository = MockAuthRepository();
    repository = UserRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockAuthRepository,
    );

    registerFallbackValue(tUserDto);
    registerFallbackValue(tUserModel);
  });

  group('getUser', () {
    test('getUser_success_returnsUserModel', () async {
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
      ).thenAnswer((_) async => Future.value());

      // act
      final result = await repository.getUser(tUid);

      // assert
      final expectedUser = tUserModel.copyWith(
        watchlist: [tWatchlistDto.toDomain()],
      );
      expect(result, Right(expectedUser));
      verify(() => mockRemoteDataSource.getUser(tUid)).called(1);
      verify(() => mockRemoteDataSource.getWatchlist(tUid)).called(1);
      verify(() => mockLocalDataSource.cacheFavoriteSector(any())).called(1);
    });

    test('getUser_userNotFound_returnsFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getUser(any()),
      ).thenAnswer((_) async => null);

      // act
      final result = await repository.getUser(tUid);

      // assert
      expect(result, const Left(UserNotFoundFailure()));
      verify(() => mockRemoteDataSource.getUser(tUid)).called(1);
    });

    test('getUser_failure_returnsFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getUser(any()),
      ).thenThrow(Exception('DB Error'));

      // act
      final result = await repository.getUser(tUid);

      // assert
      expect(result, const Left(ServerFailure('Failed to get user')));
      verify(() => mockRemoteDataSource.getUser(tUid)).called(1);
    });
  });

  group('updateUser', () {
    test('updateUser_success_updatesAndReturnsRight', () async {
      // arrange
      when(
        () => mockRemoteDataSource.updateUser(any()),
      ).thenAnswer((_) async => Future.value());
      when(
        () => mockLocalDataSource.cacheFavoriteSector(any()),
      ).thenAnswer((_) async => Future.value());

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

    test('updateUser_failure_returnsFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.updateUser(any()),
      ).thenThrow(Exception('Update Error'));

      // act
      final result = await repository.updateUser(tUserModel);

      // assert
      expect(result, const Left(ServerFailure('Failed to update user')));
    });
  });

  group('getCachedFavoriteSector', () {
    test('getCachedFavoriteSector_call_returnsValueFromLocalDataSource', () {
      // arrange
      const tSector = 'Technology';
      when(
        () => mockLocalDataSource.getCachedFavoriteSector(),
      ).thenReturn(tSector);

      // act
      final result = repository.getCachedFavoriteSector();

      // assert
      expect(result, tSector);
      verify(() => mockLocalDataSource.getCachedFavoriteSector()).called(1);
    });
  });

  group('dispose', () {
    test('dispose_call_executesWithoutError', () {
      // act
      void callDispose() => repository.dispose();

      // assert
      expect(callDispose, returnsNormally);
    });
  });

  group('watchUser', () {
    test('watchUser_emission_combinesProfileAndWatchlistCorrectly', () async {
      // arrange
      final userController = StreamController<UserDto?>();
      final watchlistController = StreamController<List<WatchlistItemDto>>();

      when(
        () => mockRemoteDataSource.watchUser(tUid),
      ).thenAnswer((_) => userController.stream);
      when(
        () => mockRemoteDataSource.watchWatchlist(tUid),
      ).thenAnswer((_) => watchlistController.stream);
      when(
        () => mockLocalDataSource.getCachedFavoriteSector(),
      ).thenReturn('Technology');
      when(
        () => mockLocalDataSource.cacheFavoriteSector(any()),
      ).thenAnswer((_) async => Future.value());

      // act
      final stream = repository.watchUser(tUid);

      // assert
      final expectFuture = expectLater(
        stream,
        emitsInOrder([
          isA<UserModel>()
              .having((u) => u.uid, 'uid', tUid)
              .having((u) => u.watchlist.length, 'watchlist', 1)
              .having((u) => u.watchlist[0].ticker, 'ticker', 'AAPL'),
        ]),
      );

      userController.add(tUserDto);
      watchlistController.add([tWatchlistDto]);

      await expectFuture;

      userController.close();
      watchlistController.close();
    });

    test('watchUser_streamError_throwsException', () async {
      // arrange
      when(
        () => mockRemoteDataSource.watchUser(tUid),
      ).thenAnswer((_) => Stream.error(Exception('Remote failed')));
      when(
        () => mockRemoteDataSource.watchWatchlist(tUid),
      ).thenAnswer((_) => Stream.value([]));

      // act & assert
      expect(() => repository.watchUser(tUid).first, throwsA(isA<Exception>()));
    });
  });

  group('userStream', () {
    test('userStream_authStateChange_switchMapsToAuthenticatedUser', () async {
      // arrange
      final authController = StreamController<auth.UserModel?>();
      final userController = StreamController<UserDto?>();
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
      ).thenReturn(null);
      when(
        () => mockLocalDataSource.cacheFavoriteSector(any()),
      ).thenAnswer((_) async => Future.value());

      // act
      final streamResult = repository.userStream;

      // assert
      final expectFuture = expectLater(
        streamResult,
        emitsInOrder([isA<UserModel>().having((u) => u.uid, 'uid', tUid)]),
      );

      authController.add(tAuthUser);

      await Future.delayed(Duration.zero);

      userController.add(tUserDto);
      watchlistController.add([]);

      await expectFuture;

      authController.close();
      userController.close();
      watchlistController.close();
    });

    test('userStream_loggedOut_emitsEmptyStream', () async {
      // arrange
      final authController = StreamController<auth.UserModel?>();
      when(
        () => mockAuthRepository.authStateChanges,
      ).thenAnswer((_) => authController.stream);

      // act
      final stream = repository.userStream;

      // assert
      authController.add(null);

      var emitted = false;
      final sub = stream.listen((_) => emitted = true);

      await Future.delayed(const Duration(milliseconds: 100));
      expect(emitted, false);

      sub.cancel();
      authController.close();
    });
  });
}
