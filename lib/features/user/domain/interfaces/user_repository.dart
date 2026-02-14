import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserModel>> getUser(String uid);
  Future<Either<Failure, void>> updateUser(UserModel user);
  String? getCachedFavoriteSector();
  Stream<UserModel> get userStream;
  Stream<UserModel> watchUser(String uid);
  Future<Either<Failure, void>> updateFcmToken(String deviceId, String token);
  Future<Either<Failure, void>> removeFcmToken(String deviceId);
  Future<Either<Failure, void>> updateNotificationSettings(
    bool enabled, {
    String? deviceId,
    String? token,
  });
  void dispose();
}
