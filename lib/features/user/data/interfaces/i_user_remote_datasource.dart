import 'package:bizzie/core/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/core/data/dtos/user_dto.dart';

abstract class IUserRemoteDataSource {
  Future<UserDto?> getUser(String uid);
  Stream<UserDto?> watchUser(String uid);
  Future<List<WatchlistItemDto>> getWatchlist(String uid);
  Stream<List<WatchlistItemDto>> watchWatchlist(String uid);
  Future<void> updateUser(UserDto user);
  Future<void> updateFcmToken(String uid, String deviceId, String token);
  Future<void> removeFcmToken(String uid, String deviceId);
  Future<void> updateLastViewedAt(String uid);
  Future<void> updateNotificationSettings(
    String uid,
    bool enabled, {
    String? deviceId,
    String? token,
  });
}
