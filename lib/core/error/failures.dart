import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.server(String message) = ServerFailure;
  const factory Failure.cache(String message) = CacheFailure;
  const factory Failure.userNotFound([
    @Default('User not found') String message,
  ]) = UserNotFoundFailure;

  @override
  String get message => when(
    server: (msg) => msg,
    cache: (msg) => msg,
    userNotFound: (msg) => msg,
  );
}
