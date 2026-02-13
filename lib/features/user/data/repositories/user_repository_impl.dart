import 'dart:async';
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
  Stream<UserModel> get userStream => _authRepository.authStateChanges
      .map((user) => user?.id)
      .distinct()
      .switchMap((uid) {
        if (uid == null) {
          return const Stream<UserModel>.empty();
        }
        return watchUser(uid);
      })
      .asBroadcastStream();

  @override
  String? getCachedFavoriteSector() {
    return _localDataSource.getCachedFavoriteSector();
  }

  @override
  Stream<UserModel> watchUser(String uid) {
    _logger.info('Starting reactive watch for user $uid');

    return Rx.combineLatest2(
      _remoteDataSource.watchUser(uid).where((dto) => dto != null),
      _remoteDataSource.watchWatchlist(uid),
      (userDto, watchlistDtos) {
        final watchlist = watchlistDtos.map((dto) => dto.toDomain()).toList();
        final user = userDto!.toDomain().copyWith(watchlist: watchlist);

        if (user.favoriteSector.isNotEmpty &&
            _localDataSource.getCachedFavoriteSector() == null) {
          _logger.info(
            'Seeding local cache from stream: ${user.favoriteSector}',
          );
          _localDataSource.cacheFavoriteSector(user.favoriteSector);
        }

        return user;
      },
    ).handleError((Object e, StackTrace s) {
      _logger.severe('User stream error for $uid', e, s);
      throw e;
    });
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
}
