import 'package:bizzie/features/user/data/dtos/user_dto.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:injectable/injectable.dart';

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
    final snapshot = await _firestoreService.getDocument(path: 'users/$uid');

    if (snapshot.exists && snapshot.data() != null) {
      return UserDto.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<List<WatchlistItemDto>> getWatchlist(String uid) async {
    final snapshot = await _firestoreService.instance
        .collection('users')
        .doc(uid)
        .collection('watchlist')
        .get();

    return snapshot.docs
        .map((doc) => WatchlistItemDto.fromJson(doc.data()))
        .toList();
  }
}
