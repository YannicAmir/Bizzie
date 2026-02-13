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
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:rxdart/rxdart.dart';

final _logger = BizzieLogger('UserRepositoryImpl');

@LazySingleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteDataSource _remoteDataSource;
  final IUserLocalDataSource _localDataSource;

  /// Internal reactive buffer — closed and replaced on [dispose].
  BehaviorSubject<UserModel> _userSubject = BehaviorSubject<UserModel>();

  /// Active Firestore snapshot subscription.
  StreamSubscription? _activeFirestoreSub;

  /// Bridges [_userSubject] → [_forwardingController].
  StreamSubscription? _forwardingSub;

  /// The UID currently being watched. Guards against redundant listeners.
  String? _watchingUid;

  /// Cached watchlist from the initial fetch (subcollection data
  /// is not included in Firestore document snapshots).
  List<Company> _cachedWatchlist = [];

  /// Forwarding stream that survives [dispose] cycles.
  /// External consumers (e.g. [SubscriptionModule]) capture a reference
  /// at DI time; this reference must stay valid across logout → re-login.
  final _forwardingController = StreamController<UserModel>.broadcast();

  UserRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Stream<UserModel> get userStream => _forwardingController.stream;

  @override
  String? getCachedFavoriteSector() {
    return _localDataSource.getCachedFavoriteSector();
  }

  @override
  Stream<UserModel> watchUser(String uid) {
    // Guard: same UID already being watched — return existing stream.
    if (_watchingUid == uid) {
      _logger.info('Already watching user $uid, returning existing stream');
      return _userSubject.stream;
    }

    // Teardown any previous watcher.
    _activeFirestoreSub?.cancel();
    _forwardingSub?.cancel();
    _watchingUid = uid;

    _logger.info('Starting real-time watch for user $uid');

    // Fetch watchlist once (subcollection data is not in document snapshots).
    _remoteDataSource
        .getWatchlist(uid)
        .then((watchlistDtos) {
          _cachedWatchlist = watchlistDtos
              .map((dto) => dto.toDomain())
              .toList();
          _logger.info(
            'Cached ${_cachedWatchlist.length} watchlist items for user $uid',
          );
        })
        .catchError((Object e, StackTrace s) {
          _logger.severe('Failed to fetch watchlist for user $uid', e, s);
          _cachedWatchlist = [];
        });

    // Subscribe to Firestore document stream, filtering null snapshots.
    _activeFirestoreSub = _remoteDataSource
        .watchUser(uid)
        .where((dto) => dto != null)
        .listen(
          (dto) {
            final user = dto!.toDomain().copyWith(watchlist: _cachedWatchlist);
            _userSubject.add(user);

            // Seed local cache on first emission if needed.
            if (user.favoriteSector.isNotEmpty &&
                _localDataSource.getCachedFavoriteSector() == null) {
              _logger.info(
                'Seeding local cache from stream: ${user.favoriteSector}',
              );
              _localDataSource.cacheFavoriteSector(user.favoriteSector);
            }
          },
          onError: (Object e, StackTrace s) {
            _logger.severe('Firestore user stream error', e, s);
            _userSubject.addError(e, s);
          },
        );

    // Bridge internal subject → forwarding controller.
    _forwardingSub = _userSubject.listen(
      _forwardingController.add,
      onError: _forwardingController.addError,
    );

    return _userSubject.stream;
  }

  @override
  void dispose() {
    _logger.info('Disposing user repository stream state');
    _activeFirestoreSub?.cancel();
    _activeFirestoreSub = null;
    _forwardingSub?.cancel();
    _forwardingSub = null;
    _watchingUid = null;
    _cachedWatchlist = [];
    _userSubject.close();
    _userSubject = BehaviorSubject<UserModel>();
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

      // Only seed local cache from remote if it's currently empty
      // This prevents reactive fetches from overwriting a fresh local change with stale remote data
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
      return Left(Failure.server(e.toString()));
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

      // Emit user update through internal subject.
      _userSubject.add(user);

      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to update user', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }
}
