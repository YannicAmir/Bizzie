import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/user/data/dtos/user_dto.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bizzie/features/user/data/datasources/user_remote_datasource.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/features/user/data/datasources/user_local_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:rxdart/rxdart.dart';

final _logger = BizzieLogger('UserRepositoryImpl');

@LazySingleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteDataSource _remoteDataSource;
  final IUserLocalDataSource _localDataSource;
  final IAuthRepository _authRepository;

  UserRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._authRepository,
  );

  @override
  Stream<UserModel?> get userStream => _authRepository.authStateChanges
      .map((user) => user?.id)
      .distinct()
      .switchMap((uid) {
        if (uid == null) {
          return Stream<UserModel?>.value(null);
        }
        return watchUser(uid);
      })
      .asBroadcastStream();

  @override
  String? getCachedFavoriteSector() {
    return _localDataSource.getCachedFavoriteSector();
  }

  @override
  Stream<UserModel?> watchUser(String uid) {
    _logger.info('Starting resilient reactive watch for user $uid');

    Stream<UserModel?> buildStream() => Rx.combineLatest2<UserDto?,
        List<WatchlistItemDto>,
        UserModel?>(
      _remoteDataSource.watchUser(uid),
      _remoteDataSource.watchWatchlist(uid),
      (userDto, List<WatchlistItemDto> watchlistDtos) =>
          _mapUser(userDto, watchlistDtos, uid),
    );

    bool firstEventReceived = false;
    return RetryWhenStream<UserModel?>(
      buildStream,
      (error, stackTrace) {
        if (error is FirebaseException && error.code == 'permission-denied') {
          _logger.info(
            'Terminal permission-denied error for uid: $uid. Skipping retry.',
          );
          return Stream.error(error);
        }

        _logger.warning(
          'User stream encountered recoverable error, retrying in 5s...',
          error,
        );
        return Stream.periodic(const Duration(seconds: 5)).take(3);
      },
    )
        .doOnData((_) => firstEventReceived = true)
        .timeout(
          const Duration(seconds: 20),
          onTimeout: (sink) {
            if (!firstEventReceived) {
              sink.addError(
                TimeoutException(
                  'Initial connection timeout',
                  const Duration(seconds: 20),
                ),
              );
            }
          },
        )
        .handleError((Object e, StackTrace s) {
          _logger.severe(
            'User stream persistent error or timeout for $uid',
            e,
            s,
          );
          throw e;
        });
  }

  UserModel? _mapUser(
    UserDto? userDto,
    List<WatchlistItemDto> watchlistDtos,
    String uid,
  ) {
    try {
      if (userDto == null) {
        _logger.info('No Firestore document found for user $uid');
        return null;
      }

      final watchlist = watchlistDtos.map((dto) => dto.toDomain()).toList();
      final user = userDto.toDomain().copyWith(watchlist: watchlist);

      if (user.favoriteSector.isNotEmpty &&
          _localDataSource.getCachedFavoriteSector() == null) {
        _logger.info(
          'Seeding local cache from stream: ${user.favoriteSector}',
        );
        _localDataSource.cacheFavoriteSector(user.favoriteSector);
      }

      return user;
    } catch (e, stack) {
      _logger.severe('Failed to map UserDto to Domain', e, stack);
      rethrow;
    }
  }

  @override
  void dispose() {
    _logger.info('Disposing user repository (No-op after refactor)');
  }

  @override
  Future<Either<Failure, UserModel>> getUser(String uid) async {
    try {
      final userDto = await _remoteDataSource.getUser(uid);

      if (userDto == null) {
        return Left(Failure.userNotFound());
      }

      final watchlistDtos = await _remoteDataSource.getWatchlist(uid);
      final watchlist = watchlistDtos.map((dto) => dto.toDomain()).toList();

      final user = userDto.toDomain().copyWith(watchlist: watchlist);

      final currentCached = _localDataSource.getCachedFavoriteSector();
      if (user.favoriteSector.isNotEmpty && currentCached == null) {
        _logger.info(
          'Seeding local cache from remote profile: ${user.favoriteSector}',
        );
        await _localDataSource.cacheFavoriteSector(user.favoriteSector);
      } else {
        _logger.info(
          'Skipping local cache update. Current: $currentCached, Remote: ${user.favoriteSector}',
        );
      }

      return Right(user);
    } catch (e, stack) {
      _logger.severe('Failed to get user', e, stack);
      return const Left(ServerFailure('Failed to get user'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserModel user) async {
    try {
      _logger.info('Updating user in remote and local: ${user.favoriteSector}');
      await _remoteDataSource.updateUser(UserDto.fromDomain(user));
      if (user.favoriteSector.isNotEmpty) {
        await _localDataSource.cacheFavoriteSector(user.favoriteSector);
      }

      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to update user', e, stack);
      return const Left(ServerFailure('Failed to update user'));
    }
  }

  @override
  Future<Either<Failure, void>> updateFcmToken(
    String deviceId,
    String token,
  ) async {
    final user = _authRepository.currentUser;
    if (user == null) {
      return Left(Failure.userNotFound());
    }
    try {
      await _remoteDataSource.updateFcmToken(user.id, deviceId, token);
      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to update FCM token', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFcmToken(String deviceId) async {
    final user = _authRepository.currentUser;
    if (user == null) {
      return Left(Failure.userNotFound());
    }
    try {
      await _remoteDataSource.removeFcmToken(user.id, deviceId);
      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to remove FCM token', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNotificationSettings(
    bool enabled, {
    String? deviceId,
    String? token,
  }) async {
    final user = _authRepository.currentUser;
    if (user == null) {
      return Left(Failure.userNotFound());
    }
    try {
      await _remoteDataSource.updateNotificationSettings(
        user.id,
        enabled,
        deviceId: deviceId,
        token: token,
      );
      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to update notification settings', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }
}
