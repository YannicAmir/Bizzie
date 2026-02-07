import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/settings/domain/usecases/get_settings_display_data_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/launch_url_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/reset_password_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/sign_out_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/submit_feedback_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/toggle_notifications_usecase.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsDisplayDataUseCase _getSettingsDisplayDataUseCase;
  final ToggleNotificationsUseCase _toggleNotificationsUseCase;
  final SubmitFeedbackUseCase _submitFeedbackUseCase;
  final LaunchUrlUseCase _launchUrlUseCase;
  final SignOutUseCase _signOutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final IAuthRepository _authRepository;

  SettingsBloc(
    this._getSettingsDisplayDataUseCase,
    this._toggleNotificationsUseCase,
    this._submitFeedbackUseCase,
    this._launchUrlUseCase,
    this._signOutUseCase,
    this._resetPasswordUseCase,
    this._authRepository,
  ) : super(const SettingsState.initial()) {
    on<SettingsEvent>((event, emit) async {
      await event.map(
        started: (e) => _onStarted(e, emit),
        toggledNotifications: (e) => _onToggledNotifications(e, emit),
        submitFeedback: (e) => _onSubmitFeedback(e, emit),
        openUrl: (e) => _onOpenUrl(e, emit),
        signedOut: (e) => _onSignedOut(e, emit),
        refreshSubscription: (e) => _onRefreshSubscription(e, emit),
        resetPassword: (e) => _onResetPassword(e, emit),
      );
    });
  }

  Future<void> _onStarted(dynamic event, Emitter<SettingsState> emit) async {
    emit(const SettingsState.loading());
    final result = await _getSettingsDisplayDataUseCase(NoParams());
    result.fold(
      (l) => emit(SettingsState.failure(l)),
      (r) => emit(SettingsState.loaded(r)),
    );
  }

  Future<void> _onResetPassword(
    dynamic event,
    Emitter<SettingsState> emit,
  ) async {
    final user = _authRepository.currentUser;
    if (user != null) {
      await _resetPasswordUseCase(user.email);
    }
  }

  Future<void> _onToggledNotifications(
    dynamic event,
    Emitter<SettingsState> emit,
  ) async {
    final enable = event.enable as bool;
    state.maybeMap(
      loaded: (loadedState) async {
        final data = loadedState.data;
        emit(
          loadedState.copyWith(
            data: data.copyWith(isAppNotificationsEnabled: enable),
          ),
        );
        final result = await _toggleNotificationsUseCase(enable);
        result.fold(
          (l) => emit(
            loadedState.copyWith(
              data: loadedState.data.copyWith(
                isAppNotificationsEnabled: !enable,
              ),
            ),
          ),
          (r) => null,
        );
      },
      orElse: () {},
    );
  }

  Future<void> _onSignedOut(dynamic event, Emitter<SettingsState> emit) async {
    emit(const SettingsState.loading());
    final result = await _signOutUseCase(NoParams());
    result.fold((l) => emit(SettingsState.failure(l)), (r) {
      emit(const SettingsState.initial());
    });
  }

  Future<void> _onRefreshSubscription(
    dynamic event,
    Emitter<SettingsState> emit,
  ) async {
    // To be implemented
  }

  Future<void> _onOpenUrl(dynamic event, Emitter<SettingsState> emit) async {
    final url = event.url as String;
    await _launchUrlUseCase(url);
  }

  Future<void> _onSubmitFeedback(
    dynamic event,
    Emitter<SettingsState> emit,
  ) async {
    final message = event.message as String;
    await _submitFeedbackUseCase(message);
  }
}
