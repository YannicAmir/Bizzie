import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import '../../domain/models/user_model.dart';
import '../enums/auth_loading_method.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading({AuthLoadingMethod? method}) = AuthLoading;
  const factory AuthState.authenticated(UserModel user) = AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.failure(Failure failure) = AuthFailure;

  const AuthState._();

  bool get isGuest => maybeMap(
    authenticated: (state) => state.user.isAnonymous,
    orElse: () => false,
  );

  String? get userId => mapOrNull(authenticated: (state) => state.user.id);

  bool shouldLinkGuestFor(AuthSource source) =>
      source == AuthSource.guestGate ||
      (source == AuthSource.onboarding && isGuest);
}
