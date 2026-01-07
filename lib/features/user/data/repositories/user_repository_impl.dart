import 'package:bizzie/core/error/failures.dart';

import 'package:bizzie/features/onboarding/domain/models/user_model.dart';
import 'package:bizzie/features/user/data/datasources/user_remote_datasource.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/features/user/data/datasources/user_local_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

@LazySingleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteDataSource _remoteDataSource;
  final IUserLocalDataSource _localDataSource;
  final _logger = BizzieLogger('UserRepositoryImpl');

  UserRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  String? getCachedFavoriteSector() {
    return _localDataSource.getCachedFavoriteSector();
  }

  @override
  Future<Either<Failure, UserModel>> getUser(String uid) async {
    try {
      final userDto = await _remoteDataSource.getUser(uid);

      if (userDto == null) {
        return Left(UserNotFoundFailure());
      }

      final watchlistDtos = await _remoteDataSource.getWatchlist(uid);
      final watchlist = watchlistDtos.map((dto) => dto.toDomain()).toList();

      final user = userDto.toDomain().copyWith(watchlist: watchlist);
      await _localDataSource.cacheFavoriteSector(user.favoriteSector);
      return Right(user);
    } catch (e, stack) {
      _logger.severe('Failed to get user', e, stack);
      return Left(ServerFailure(e.toString()));
    }
  }
}
