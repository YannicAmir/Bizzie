import 'package:bizzie/core/constants/storage_constants.dart';
import 'package:bizzie/features/app_ratings/data/interfaces/i_app_ratings_local_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IAppRatingsLocalDataSource)
class AppRatingsLocalDataSource implements IAppRatingsLocalDataSource {
  final SharedPreferences _sharedPreferences;

  static const String _interactionCountKey =
      StorageConstants.appRatingsInteractionCount;
  static const String _promptAttemptsKey =
      StorageConstants.appRatingsPromptAttempts;

  AppRatingsLocalDataSource(this._sharedPreferences);

  @override
  int getInteractionCount() {
    return _sharedPreferences.getInt(_interactionCountKey) ?? 0;
  }

  @override
  Future<void> setInteractionCount(int count) async {
    await _sharedPreferences.setInt(_interactionCountKey, count);
  }

  @override
  int getPromptAttempts() {
    return _sharedPreferences.getInt(_promptAttemptsKey) ?? 0;
  }

  @override
  Future<void> setPromptAttempts(int attempts) async {
    await _sharedPreferences.setInt(_promptAttemptsKey, attempts);
  }
}
