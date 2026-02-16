import 'package:bizzie/features/app_ratings/data/interfaces/i_app_ratings_local_datasource.dart';
import 'package:bizzie/features/app_ratings/domain/interfaces/i_app_ratings_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAppRatingsRepository)
class AppRatingsRepositoryImpl implements IAppRatingsRepository {
  final IAppRatingsLocalDataSource _localDataSource;

  AppRatingsRepositoryImpl(this._localDataSource);

  @override
  Future<int> getInteractionCount() async {
    return _localDataSource.getInteractionCount();
  }

  @override
  Future<void> incrementInteractionCount() async {
    final currentCount = _localDataSource.getInteractionCount();
    await _localDataSource.setInteractionCount(currentCount + 1);
  }

  @override
  Future<int> getPromptAttempts() async {
    return _localDataSource.getPromptAttempts();
  }

  @override
  Future<void> incrementPromptAttempts() async {
    final currentAttempts = _localDataSource.getPromptAttempts();
    await _localDataSource.setPromptAttempts(currentAttempts + 1);
  }
}
