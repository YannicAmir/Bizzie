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
  const factory Failure.permission([
    @Default('Permission denied') String message,
  ]) = PermissionFailure;
  const factory Failure.passwordMismatch([
    @Default('Passwords do not match') String message,
  ]) = PasswordMismatchFailure;
  const factory Failure.reauthentication([
    @Default('Reauthentication failed') String message,
  ]) = ReauthenticationFailure;
  const factory Failure.rateLimit({
    required int retryAfterSeconds,
    @Default('Daily chat limit reached') String message,
  }) = RateLimitFailure;

  String get errorMessage => map(
        server: (f) => f.message,
        cache: (f) => f.message,
        payment: (f) => f.message,
        cancel: (f) => f.message,
        userNotFound: (f) => f.message,
        permission: (f) => f.message,
        passwordMismatch: (f) => f.message,
        reauthentication: (f) => f.message,
        rateLimit: (f) => f.message,
      );
}
