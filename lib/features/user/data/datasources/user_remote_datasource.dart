import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bizzie/features/user/data/dtos/user_dto.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('UserRemoteDataSource');

abstract class IUserRemoteDataSource {
  Future<UserDto?> getUser(String uid);
  Future<List<WatchlistItemDto>> getWatchlist(String uid);
}

@LazySingleton(as: IUserRemoteDataSource)
class UserRemoteDataSource implements IUserRemoteDataSource {
  final FirestoreService _firestoreService;

  UserRemoteDataSource(this._firestoreService);

  @override
  Future<UserDto?> getUser(String uid) async {
    _logger.info('Fetching user profile for UID: $uid');
    try {
      final user = await _firestoreService.getDocument<UserDto>(
        path: 'users/$uid',
        fromJson: UserDto.fromJson,
        toJson: (dto) => dto.toJson(),
      );
      if (user != null) {
        _logger.info('Successfully fetched user profile for UID: $uid');
      } else {
        _logger.warning('No user profile found for UID: $uid');
      }
      return user;
    } catch (e, s) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        _logger.warning(
          'Failed to fetch user profile (expected on logout) for UID: $uid',
        );
      } else {
        _logger.severe('Failed to fetch user profile for UID: $uid', e, s);
      }
      rethrow;
    }
  }

  @override
  Future<List<WatchlistItemDto>> getWatchlist(String uid) async {
    _logger.info('Fetching watchlist for UID: $uid');
    try {
      final watchlist = await _firestoreService.getCollection<WatchlistItemDto>(
        path: 'users/$uid/watchlist',
        fromJson: WatchlistItemDto.fromJson,
        toJson: (dto) => dto.toJson(),
      );
      _logger.info(
        'Successfully fetched ${watchlist.length} watchlist items for UID: $uid',
      );
      return watchlist;
    } catch (e, s) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        _logger.warning(
          'Failed to fetch watchlist (expected on logout) for UID: $uid',
        );
      } else {
        _logger.severe('Failed to fetch watchlist for UID: $uid', e, s);
      }
      rethrow;
    }
  }
}
