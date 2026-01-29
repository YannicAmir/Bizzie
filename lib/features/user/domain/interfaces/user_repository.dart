import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserModel>> getUser(String uid);
  String? getCachedFavoriteSector();
}
