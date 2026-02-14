import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/settings/domain/usecases/get_settings_display_data_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/launch_url_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/open_app_settings_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/reset_password_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/sign_out_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/get_subscription_status_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/toggle_notifications_usecase.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('SettingsBloc');

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsDisplayDataUseCase _getSettingsDisplayDataUseCase;
  final ToggleNotificationsUseCase _toggleNotificationsUseCase;
  final LaunchUrlUseCase _launchUrlUseCase;
  final SignOutUseCase _signOutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final IAuthRepository _authRepository;
  final OpenAppSettingsUseCase _openAppSettingsUseCase;
  final GetSubscriptionStatusUseCase _getSubscriptionStatusUseCase;

  SettingsBloc(
    this._getSettingsDisplayDataUseCase,
    this._toggleNotificationsUseCase,
    this._launchUrlUseCase,
    this._signOutUseCase,
    this._resetPasswordUseCase,
    this._authRepository,
    this._openAppSettingsUseCase,
    this._getSubscriptionStatusUseCase,
  ) : super(const SettingsState.initial()) {
    on<SettingsEvent>((event, emit) async {
      await event.map(
        started: (e) => _onStarted(e, emit),
        toggledNotifications: (e) => _onToggledNotifications(e, emit),
        openUrl: (e) => _onOpenUrl(e, emit),
        signedOut: (e) => _onSignedOut(e, emit),
        refreshSubscription: (e) => _onRefreshSubscription(e, emit),
        resetPassword: (e) => _onResetPassword(e, emit),
        openedSettings: (e) => _onOpenedSettings(e, emit),
      );
    });
  }

  Future<void> _onStarted(dynamic event, Emitter<SettingsState> emit) async {
    final isSilent = state.maybeMap(loaded: (_) => true, orElse: () => false);
    if (!isSilent) {
      _logger.info('Initializing SettingsBloc');
      emit(const SettingsState.loading());
    } else {
      _logger.info('Silently refreshing SettingsBloc');
    }

    final result = await _getSettingsDisplayDataUseCase(NoParams());
    result.fold(
      (l) {
        _logger.warning('Failed to load settings data', l);
        emit(SettingsState.failure(l));
      },
      (r) {
        _logger.info('Settings data loaded successfully');
        emit(SettingsState.loaded(r));
      },
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

    await state.maybeMap(
      loaded: (loadedState) async {
        final data = loadedState.data;

        if (enable && !data.isSystemNotificationsEnabled) {
          _logger.info(
            'User enabled notifications but system permission is missing',
          );
          emit(SettingsState.failure(const Failure.permission()));
          emit(
            loadedState.copyWith(
              data: data.copyWith(isAppNotificationsEnabled: false),
            ),
          );
          return;
        }

        _logger.info('Toggling notifications to: $enable');
        emit(
          loadedState.copyWith(
            data: data.copyWith(isAppNotificationsEnabled: enable),
          ),
        );
        final result = await _toggleNotificationsUseCase(enable);
        result.fold((l) {
          _logger.warning('Failed to toggle notifications', l);
          emit(
            loadedState.copyWith(
              data: loadedState.data.copyWith(
                isAppNotificationsEnabled: !enable,
              ),
            ),
          );
        }, (r) => null);
      },
      orElse: () async {},
    );
  }

  Future<void> _onOpenedSettings(
    dynamic event,
    Emitter<SettingsState> emit,
  ) async {
    await _openAppSettingsUseCase(NoParams());
  }

  Future<void> _onSignedOut(dynamic event, Emitter<SettingsState> emit) async {
    _logger.info('User signing out');
    emit(const SettingsState.loading());
    final result = await _signOutUseCase(NoParams());
    result.fold(
      (l) {
        _logger.warning('Failed to sign out', l);
        emit(SettingsState.failure(l));
      },
      (r) {
        _logger.info('User signed out successfully');
        emit(const SettingsState.initial());
      },
    );
  }

  Future<void> _onRefreshSubscription(
    dynamic event,
    Emitter<SettingsState> emit,
  ) async {
    _logger.info('Refreshing subscription status');
    final result = await _getSubscriptionStatusUseCase(NoParams());

    result.fold(
      (failure) => _logger.warning('Failed to refresh subscription', failure),
      (status) {
        _logger.info('Subscription refreshed successfully');
        state.maybeMap(
          loaded: (loadedState) {
            emit(
              loadedState.copyWith(
                data: loadedState.data.copyWith(subscriptionStatus: status),
              ),
            );
          },
          orElse: () => null,
        );
      },
    );
  }

  Future<void> _onOpenUrl(dynamic event, Emitter<SettingsState> emit) async {
    final url = event.url as String;
    await _launchUrlUseCase(url);
  }
}
