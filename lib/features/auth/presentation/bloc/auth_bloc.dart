import 'dart:async';

import 'package:bizzie/core/enums/guest_gate_trigger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/enums/auth_method.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import 'package:bizzie/features/auth/domain/models/link_with_email_params.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/link_with_apple_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/link_with_email_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/link_with_google_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_apple_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_up_with_email_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/launch_url_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../analytics/auth_tracker.dart';
import '../enums/auth_loading_method.dart';
import 'auth_event.dart';
import 'auth_state.dart';

final _logger = BizzieLogger('AuthBloc');

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthStreamUseCase _getAuthStream;
  final GetCurrentUserUseCase _getCurrentUser;
  final AuthTracker _tracker;

  final SignInWithGoogleUseCase _signInWithGoogle;
  final SignInWithAppleUseCase _signInWithApple;
  final SignInWithEmailUseCase _signInWithEmail;
  final SignUpWithEmailUseCase _signUpWithEmail;
  final LinkWithEmailUseCase _linkWithEmail;
  final LinkWithGoogleUseCase _linkWithGoogle;
  final LinkWithAppleUseCase _linkWithApple;
  final SignOutUseCase _signOut;
  final ResetPasswordUseCase _resetPassword;
  final DeleteAccountUseCase _deleteAccount;
  final LaunchUrlUseCase _launchUrlUseCase;
  GuestGateTrigger? _guestLinkTrigger;

  AuthBloc(
    this._tracker,
    this._getAuthStream,
    this._getCurrentUser,
    this._signInWithGoogle,
    this._signInWithApple,
    this._signInWithEmail,
    this._signUpWithEmail,
    this._linkWithEmail,
    this._linkWithGoogle,
    this._linkWithApple,
    this._signOut,
    this._resetPassword,
    this._deleteAccount,
    this._launchUrlUseCase,
  ) : super(_getInitialState(_getCurrentUser)) {
    on<AuthStatusRequested>(_onAuthStatusRequested, transformer: restartable());
    on<AuthLogoutRequested>(_onLogoutRequested, transformer: droppable());
    on<AuthGoogleSignInRequested>(
      _onGoogleSignInRequested,
      transformer: droppable(),
    );
    on<AuthAppleSignInRequested>(
      _onAppleSignInRequested,
      transformer: droppable(),
    );
    on<AuthEmailSignInRequested>(
      _onEmailSignInRequested,
      transformer: droppable(),
    );
    on<AuthEmailSignUpRequested>(
      _onEmailSignUpRequested,
      transformer: droppable(),
    );
    on<AuthResetPasswordRequested>(
      _onResetPasswordRequested,
      transformer: droppable(),
    );
    on<AuthDeleteAccountRequested>(
      _onDeleteAccountRequested,
      transformer: droppable(),
    );
    on<AuthLegalLinkOpened>(_onLegalLinkOpened);
    on<AuthGuestGateShown>(_onGuestGateShown);
    on<AuthGuestGateDismissed>(_onGuestGateDismissed);
    on<AuthGuestLinkStarted>(_onGuestLinkStarted);

    state.whenOrNull(
      authenticated: (user) {
        unawaited(_tracker.setUserId(user.id));
        unawaited(_tracker.setAccountType(isGuest: user.isAnonymous));
      },
    );
  }

  Future<void> _onAuthStatusRequested(
    AuthStatusRequested event,
    Emitter<AuthState> emit,
  ) {
    return emit.forEach<UserModel?>(
      _getAuthStream(NoParams()),
      onData: _stateForUser,
      onError: (error, stackTrace) {
        _logger.severe('Auth state stream error', error, stackTrace);
        return state;
      },
    );
  }

  AuthState _stateForUser(UserModel? user) {
    if (user == null) {
      unawaited(_tracker.setUserId(null));
      return const AuthState.unauthenticated();
    }
    unawaited(_tracker.setUserId(user.id));
    unawaited(_tracker.setAccountType(isGuest: user.isAnonymous));
    return AuthState.authenticated(user);
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.shouldLinkGuestFor(event.source)) {
      return _linkGuestWithGoogle(source: event.source, emit: emit);
    }
    emit(const AuthState.loading(method: AuthLoadingMethod.google));
    await _signInWithProvider(
      method: AuthMethod.google,
      source: event.source,
      signIn: () => _signInWithGoogle(NoParams()),
      emit: emit,
    );
  }

  Future<void> _onAppleSignInRequested(
    AuthAppleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.shouldLinkGuestFor(event.source)) {
      return _linkGuestWithApple(source: event.source, emit: emit);
    }
    emit(const AuthState.loading(method: AuthLoadingMethod.apple));
    await _signInWithProvider(
      method: AuthMethod.apple,
      source: event.source,
      signIn: () => _signInWithApple(NoParams()),
      emit: emit,
    );
  }

  Future<bool> _signInWithProvider({
    required AuthMethod method,
    required AuthSource source,
    required Future<Either<Failure, UserModel>> Function() signIn,
    required Emitter<AuthState> emit,
  }) async {
    await _tracker.logLoginStarted(method: method, source: source);

    final result = await signIn();
    return result.fold(
      (failure) async {
        await _tracker.logLoginFailure(
          method: method,
          source: source,
          error: failure.errorMessage,
        );
        emit(AuthState.failure(failure));
        _restoreSignedInSession(emit);
        return false;
      },
      (user) async {
        await _tracker.logLoginSuccess(method: method, source: source);
        return true;
      },
    );
  }

  Future<void> _onEmailSignInRequested(
    AuthEmailSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading(method: AuthLoadingMethod.emailSignIn));
    final signedIn = await _signInWithProvider(
      method: AuthMethod.email,
      source: event.source,
      signIn: () => _signInWithEmail(
        SignInWithEmailParams(email: event.email, password: event.password),
      ),
      emit: emit,
    );
    if (signedIn && event.source == AuthSource.guestGate) {
      await _logGuestAccountLinked(
        method: AuthMethod.email,
        fallbackSignIn: true,
      );
    }
  }

  Future<void> _onEmailSignUpRequested(
    AuthEmailSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.shouldLinkGuestFor(event.source)) {
      return _linkGuestWithEmail(
        email: event.email,
        password: event.password,
        source: event.source,
        emit: emit,
      );
    }
    emit(const AuthState.loading(method: AuthLoadingMethod.emailSignUp));
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
          error: failure.errorMessage,
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

  Future<void> _linkGuestWithEmail({
    required String email,
    required String password,
    required AuthSource source,
    required Emitter<AuthState> emit,
  }) async {
    emit(const AuthState.loading(method: AuthLoadingMethod.emailSignUp));
    await _linkWithProvider(
      method: AuthMethod.email,
      source: source,
      link: () =>
          _linkWithEmail(LinkWithEmailParams(email: email, password: password)),
      emit: emit,
    );
  }

  Future<void> _linkGuestWithGoogle({
    required AuthSource source,
    required Emitter<AuthState> emit,
  }) async {
    emit(const AuthState.loading(method: AuthLoadingMethod.google));
    await _linkWithProvider(
      method: AuthMethod.google,
      source: source,
      link: () => _linkWithGoogle(NoParams()),
      emit: emit,
      onCredentialAlreadyInUse: () => _signInWithProvider(
        method: AuthMethod.google,
        source: source,
        signIn: () => _signInWithGoogle(NoParams()),
        emit: emit,
      ),
    );
  }

  Future<void> _linkGuestWithApple({
    required AuthSource source,
    required Emitter<AuthState> emit,
  }) async {
    emit(const AuthState.loading(method: AuthLoadingMethod.apple));
    await _linkWithProvider(
      method: AuthMethod.apple,
      source: source,
      link: () => _linkWithApple(NoParams()),
      emit: emit,
      onCredentialAlreadyInUse: () => _signInWithProvider(
        method: AuthMethod.apple,
        source: source,
        signIn: () => _signInWithApple(NoParams()),
        emit: emit,
      ),
    );
  }

  Future<void> _linkWithProvider({
    required AuthMethod method,
    required AuthSource source,
    required Future<Either<Failure, UserModel>> Function() link,
    required Emitter<AuthState> emit,
    Future<bool> Function()? onCredentialAlreadyInUse,
  }) async {
    await _tracker.logSignUpStarted(method: method, source: source);

    final result = await link();
    await result.fold(
      (failure) async {
        if (failure is CredentialAlreadyInUseFailure &&
            onCredentialAlreadyInUse != null) {
          if (await onCredentialAlreadyInUse()) {
            await _logGuestAccountLinked(method: method, fallbackSignIn: true);
          }
          return;
        }
        await _tracker.logSignUpFailure(
          method: method,
          source: source,
          error: failure.errorMessage,
        );
        emit(AuthState.failure(failure));
        _restoreSignedInSession(emit);
      },
      (user) async {
        await _tracker.logSignUpSuccess(method: method, source: source);
        await _logGuestAccountLinked(method: method, fallbackSignIn: false);
      },
    );
  }

  Future<void> _logGuestAccountLinked({
    required AuthMethod method,
    required bool fallbackSignIn,
  }) async {
    await _tracker.logGuestAccountLinked(
      method: method,
      trigger: _guestLinkTrigger,
      fallbackSignIn: fallbackSignIn,
    );
    await _tracker.setAccountType(isGuest: false);
    _guestLinkTrigger = null;
  }

  void _restoreSignedInSession(Emitter<AuthState> emit) {
    final currentUser = _getCurrentUser(NoParams());
    if (currentUser != null) emit(AuthState.authenticated(currentUser));
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signOut(NoParams());
    await result.fold((failure) async {
      emit(AuthState.failure(failure));
      _restoreSignedInSession(emit);
    }, (_) async => await _tracker.logLogout());
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
    await result.fold((failure) async {
      emit(AuthState.failure(failure));
      _restoreSignedInSession(emit);
    }, (_) async => await _tracker.logAccountDeleted());
  }

  Future<void> _onLegalLinkOpened(
    AuthLegalLinkOpened event,
    Emitter<AuthState> emit,
  ) async {
    unawaited(_tracker.logAuthLinkClicked(type: event.url));
    final result = await _launchUrlUseCase(event.url);
    result.fold(
      (failure) => _logger.warning(
        'Failed to open legal link: ${event.url}',
        failure.errorMessage,
      ),
      (_) {},
    );
  }

  Future<void> _onGuestGateShown(
    AuthGuestGateShown event,
    Emitter<AuthState> emit,
  ) async {
    _guestLinkTrigger = event.trigger;
    await _tracker.logGuestGateShown(trigger: event.trigger);
  }

  void _onGuestGateDismissed(
    AuthGuestGateDismissed event,
    Emitter<AuthState> emit,
  ) {
    _guestLinkTrigger = null;
  }

  void _onGuestLinkStarted(
    AuthGuestLinkStarted event,
    Emitter<AuthState> emit,
  ) {
    _guestLinkTrigger = event.trigger;
  }

  static AuthState _getInitialState(GetCurrentUserUseCase getCurrentUser) {
    final user = getCurrentUser(NoParams());
    return user != null
        ? AuthState.authenticated(user)
        : const AuthState.unauthenticated();
  }
}
