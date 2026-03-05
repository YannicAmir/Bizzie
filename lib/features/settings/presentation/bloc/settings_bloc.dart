import 'dart:async';
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

import 'package:bizzie/features/settings/presentation/analytics/settings_tracker.dart';

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
  final SettingsTracker _tracker;

  SettingsBloc(
    this._getSettingsDisplayDataUseCase,
    this._toggleNotificationsUseCase,
    this._launchUrlUseCase,
    this._signOutUseCase,
    this._resetPasswordUseCase,
    this._authRepository,
    this._openAppSettingsUseCase,
    this._getSubscriptionStatusUseCase,
    this._tracker,
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
        editProfileClicked: (e) => _onEditProfileClicked(e, emit),
        feedbackClicked: (e) => _onFeedbackClicked(e, emit),
        membershipClicked: (e) => _onMembershipClicked(e, emit),
      );
    });
  }

  Future<void> _onStarted(Started event, Emitter<SettingsState> emit) async {
    final shouldLogView = state.maybeMap(
      initial: (_) => true,
      loading: (_) => true,
      orElse: () => false,
    );

    if (shouldLogView) {
      unawaited(_tracker.logSettingsViewed());
    }

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
    ResetPassword event,
    Emitter<SettingsState> emit,
  ) async {
    _logger.info('User requested password reset');
    unawaited(_tracker.logPasswordResetClicked());

    final user = _authRepository.currentUser;
    if (user != null) {
      await _resetPasswordUseCase(user.email);
    }
  }

  Future<void> _onToggledNotifications(
    ToggledNotifications event,
    Emitter<SettingsState> emit,
  ) async {
    final enable = event.enable;
    _logger.info('Toggling notifications to: $enable');

    await state.maybeMap(
      loaded: (loadedState) async {
        final data = loadedState.data;

        if (enable && !data.isSystemNotificationsEnabled) {
          _logger.info(
            'User enabled notifications but system permission is missing',
          );
          unawaited(_tracker.logNotificationsPermissionDenied());

          emit(SettingsState.failure(const Failure.permission()));
          emit(
            loadedState.copyWith(
              data: data.copyWith(isAppNotificationsEnabled: false),
            ),
          );
          return;
        }

        unawaited(_tracker.logNotificationsToggled(enabled: enable));

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
    OpenedSettings event,
    Emitter<SettingsState> emit,
  ) async {
    _logger.info('Opening app settings from permission modal');
    unawaited(_tracker.logSystemSettingsOpened());
    await _openAppSettingsUseCase(NoParams());
  }

  Future<void> _onSignedOut(
    SignedOut event,
    Emitter<SettingsState> emit,
  ) async {
    _logger.info('User signing out');
    unawaited(_tracker.logSignOutClicked());

    emit(const SettingsState.loading());
    final result = await _signOutUseCase(NoParams());
    result.fold(
      (l) {
        _logger.warning('Failed to sign out', l);
        emit(SettingsState.failure(l));
      },
      (r) {
        _logger.info('User signed out successfully');
        unawaited(_tracker.logSignOutSuccess());
        emit(const SettingsState.initial());
      },
    );
  }

  Future<void> _onRefreshSubscription(
    RefreshSubscription event,
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

  Future<void> _onOpenUrl(OpenUrl event, Emitter<SettingsState> emit) async {
    final url = event.url;
    _logger.info('Opening URL: $url');
    unawaited(_tracker.logSettingsLinkClicked(type: url));
    await _launchUrlUseCase(url);
  }

  Future<void> _onEditProfileClicked(
    EditProfileClicked event,
    Emitter<SettingsState> emit,
  ) async {
    _logger.info('User clicked Edit Profile');
    unawaited(_tracker.logEditProfileClicked());
  }

  Future<void> _onFeedbackClicked(
    FeedbackClicked event,
    Emitter<SettingsState> emit,
  ) async {
    _logger.info('User clicked Send Feedback');
    unawaited(_tracker.logFeedbackClicked());
  }

  Future<void> _onMembershipClicked(
    MembershipClicked event,
    Emitter<SettingsState> emit,
  ) async {
    _logger.info('User clicked Membership. Subscribed: ${event.isSubscribed}');
    unawaited(_tracker.logMembershipClicked(isSubscribed: event.isSubscribed));
  }
}
