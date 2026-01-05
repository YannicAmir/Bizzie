import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/interfaces/i_auth_repository.dart';
import '../../domain/models/user_model.dart';
import '../../domain/usecases/delete_account.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/sign_in_with_apple.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  final SignInWithGoogle _signInWithGoogle;
  final SignInWithApple _signInWithApple;
  final SignInWithEmail _signInWithEmail;
  final SignUpWithEmail _signUpWithEmail;
  final SignOut _signOut;
  final ResetPassword _resetPassword;
  final DeleteAccount _deleteAccount;
  StreamSubscription<UserModel?>? _authSubscription;

  AuthBloc({
    required IAuthRepository authRepository,
    required SignInWithGoogle signInWithGoogle,
    required SignInWithApple signInWithApple,
    required SignInWithEmail signInWithEmail,
    required SignUpWithEmail signUpWithEmail,
    required SignOut signOut,
    required ResetPassword resetPassword,
    required DeleteAccount deleteAccount,
  }) : _authRepository = authRepository,
       _signInWithGoogle = signInWithGoogle,
       _signInWithApple = signInWithApple,
       _signInWithEmail = signInWithEmail,
       _signUpWithEmail = signUpWithEmail,
       _signOut = signOut,
       _resetPassword = resetPassword,
       _deleteAccount = deleteAccount,
       super(
         authRepository.currentUser != null
             ? AuthState.authenticated(authRepository.currentUser!)
             : const AuthState.unauthenticated(),
       ) {
    on<AuthStatusRequested>(_onAuthStatusRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthAppleSignInRequested>(_onAppleSignInRequested);
    on<AuthEmailSignInRequested>(_onEmailSignInRequested);
    on<AuthEmailSignUpRequested>(_onEmailSignUpRequested);
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthResetPasswordRequested>(_onResetPasswordRequested);
    on<AuthDeleteAccountRequested>(_onDeleteAccountRequested);
  }

  Future<void> _onAuthStatusRequested(
    AuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authSubscription?.cancel();
    _authSubscription = _authRepository.authStateChanges.listen(
      (user) => add(AuthStatusChanged(user)),
    );
  }

  void _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthState.authenticated(event.user!));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading(method: 'google'));
    try {
      await _signInWithGoogle(NoParams());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onAppleSignInRequested(
    AuthAppleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading(method: 'apple'));
    try {
      await _signInWithApple(NoParams());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onEmailSignInRequested(
    AuthEmailSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading(method: 'email_signin'));
    try {
      await _signInWithEmail(
        SignInWithEmailParams(email: event.email, password: event.password),
      );
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onEmailSignUpRequested(
    AuthEmailSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading(method: 'email_signup'));
    try {
      await _signUpWithEmail(
        SignInWithEmailParams(email: event.email, password: event.password),
      );
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _signOut(NoParams());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onResetPasswordRequested(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _resetPassword(event.email);
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> _onDeleteAccountRequested(
    AuthDeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _deleteAccount(NoParams());
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
