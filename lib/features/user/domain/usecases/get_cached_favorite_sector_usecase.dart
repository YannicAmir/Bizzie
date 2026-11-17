import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCachedFavoriteSectorUseCase
    implements SynchronousUseCase<String?, NoParams> {
  final IUserRepository _repository;

  GetCachedFavoriteSectorUseCase(this._repository);

  @override
  String? call([NoParams? params]) {
    return _repository.getCachedFavoriteSector();
  }
}
