import 'dart:async';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/delete_account.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/domain/usecases/get_current_user.dart';
import 'package:bizzie/features/auth/domain/usecases/reset_password.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_apple.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_out.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../analytics/auth_tracker.dart';
import 'package:bizzie/features/auth/domain/enums/auth_method.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthStream _getAuthStream;
  final AuthTracker _tracker;

  final SignInWithGoogle _signInWithGoogle;
  final SignInWithApple _signInWithApple;
  final SignInWithEmail _signInWithEmail;
  final SignUpWithEmail _signUpWithEmail;
  final SignOut _signOut;
  final ResetPassword _resetPassword;
  final DeleteAccount _deleteAccount;
  StreamSubscription<UserModel?>? _authSubscription;

  AuthBloc({
    required GetAuthStream getAuthStream,
    required GetCurrentUser getCurrentUser,
    required SignInWithGoogle signInWithGoogle,
    required SignInWithApple signInWithApple,
    required SignInWithEmail signInWithEmail,
    required SignUpWithEmail signUpWithEmail,
    required SignOut signOut,
    required ResetPassword resetPassword,
    required DeleteAccount deleteAccount,
    required AuthTracker tracker,
  }) : _getAuthStream = getAuthStream,
       _tracker = tracker,
       _signInWithGoogle = signInWithGoogle,
       _signInWithApple = signInWithApple,
       _signInWithEmail = signInWithEmail,
       _signUpWithEmail = signUpWithEmail,
       _signOut = signOut,
       _resetPassword = resetPassword,
       _deleteAccount = deleteAccount,
       super(_getInitialState(getCurrentUser)) {
    on<AuthStatusRequested>(_onAuthStatusRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthAppleSignInRequested>(_onAppleSignInRequested);
    on<AuthEmailSignInRequested>(_onEmailSignInRequested);
    on<AuthEmailSignUpRequested>(_onEmailSignUpRequested);
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthResetPasswordRequested>(_onResetPasswordRequested);
    on<AuthDeleteAccountRequested>(_onDeleteAccountRequested);

    state.whenOrNull(authenticated: (user) => _tracker.setUserId(user.id));
  }

  Future<void> _onAuthStatusRequested(
    AuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authSubscription?.cancel();
    _authSubscription = _getAuthStream(
      NoParams(),
    ).listen((user) => add(AuthStatusChanged(user)));
  }

  void _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      _tracker.setUserId(event.user!.id);
      emit(AuthState.authenticated(event.user!));
    } else {
      _tracker.setUserId(null);
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading(method: 'google'));
    await _tracker.logLoginStarted(
      method: AuthMethod.google,
      source: event.source,
    );

    final result = await _signInWithGoogle(NoParams());
    await result.fold(
      (failure) async {
        await _tracker.logLoginFailure(
          method: AuthMethod.google,
          source: event.source,
          error: failure.message,
        );
        emit(AuthState.failure(failure));
      },
      (user) async {
        await _tracker.logLoginSuccess(
          method: AuthMethod.google,
          source: event.source,
        );
      },
    );
  }

  Future<void> _onAppleSignInRequested(
    AuthAppleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading(method: 'apple'));
    await _tracker.logLoginStarted(
      method: AuthMethod.apple,
      source: event.source,
    );

    final result = await _signInWithApple(NoParams());
    await result.fold(
      (failure) async {
        await _tracker.logLoginFailure(
          method: AuthMethod.apple,
          source: event.source,
          error: failure.message,
        );
        emit(AuthState.failure(failure));
      },
      (user) async {
        await _tracker.logLoginSuccess(
          method: AuthMethod.apple,
          source: event.source,
        );
      },
    );
  }

  Future<void> _onEmailSignInRequested(
    AuthEmailSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading(method: 'email_signin'));
    await _tracker.logLoginStarted(
      method: AuthMethod.email,
      source: event.source,
    );

    final result = await _signInWithEmail(
      SignInWithEmailParams(email: event.email, password: event.password),
    );
    await result.fold(
      (failure) async {
        await _tracker.logLoginFailure(
          method: AuthMethod.email,
          source: event.source,
          error: failure.message,
        );
        emit(AuthState.failure(failure));
      },
      (user) async {
        await _tracker.logLoginSuccess(
          method: AuthMethod.email,
          source: event.source,
        );
      },
    );
  }

  Future<void> _onEmailSignUpRequested(
    AuthEmailSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading(method: 'email_signup'));
    await _tracker.logSignUpStarted(
      method: AuthMethod.email,
      source: event.source,
    );

    final result = await _signUpWithEmail(
      SignUpWithEmailParams(email: event.email, password: event.password),
    );
    await result.fold(
      (failure) async {
        await _tracker.logSignUpFailure(
          method: AuthMethod.email,
          source: event.source,
          error: failure.message,
        );
        emit(AuthState.failure(failure));
      },
      (user) async {
        await _tracker.logSignUpSuccess(
          method: AuthMethod.email,
          source: event.source,
        );
      },
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signOut(NoParams());
    await result.fold(
      (failure) async => emit(AuthState.failure(failure)),
      (_) async => await _tracker.logLogout(),
    );
  }

  Future<void> _onResetPasswordRequested(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _resetPassword(
      ResetPasswordParams(email: event.email),
    );
    await result.fold(
      (failure) async => emit(AuthState.failure(failure)),
      (_) async =>
          await _tracker.logPasswordResetRequested(source: event.source),
    );
  }

  Future<void> _onDeleteAccountRequested(
    AuthDeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _deleteAccount(NoParams());
    await result.fold(
      (failure) async => emit(AuthState.failure(failure)),
      (_) async => await _tracker.logAccountDeleted(),
    );
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  static AuthState _getInitialState(GetCurrentUser getCurrentUser) {
    final user = getCurrentUser(NoParams());
    return user != null
        ? AuthState.authenticated(user)
        : const AuthState.unauthenticated();
  }
}
