abstract class IUserLocalDataSource {
  Future<void> cacheFavoriteSector(String sector);
  String? getCachedFavoriteSector();
}
