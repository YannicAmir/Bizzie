import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.server(String message) = ServerFailure;
  const factory Failure.cache(String message) = CacheFailure;
  const factory Failure.payment(String message) = PaymentFailure;
  const factory Failure.cancel([
    @Default('Operation cancelled') String message,
  ]) = CancelFailure;
  const factory Failure.userNotFound([
    @Default('User not found') String message,
  ]) = UserNotFoundFailure;
}
