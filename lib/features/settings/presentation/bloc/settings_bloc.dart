import 'dart:async';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/settings/domain/enums/sign_out_mode.dart';
import 'package:bizzie/features/settings/domain/usecases/get_settings_display_data_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/launch_url_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/open_app_settings_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/sign_out_usecase.dart';
import 'package:bizzie/features/settings/domain/usecases/toggle_notifications_usecase.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
  final OpenAppSettingsUseCase _openAppSettingsUseCase;
  final SettingsTracker _tracker;

  SettingsBloc(
    this._getSettingsDisplayDataUseCase,
    this._toggleNotificationsUseCase,
    this._launchUrlUseCase,
    this._signOutUseCase,
    this._openAppSettingsUseCase,
    this._tracker,
  ) : super(const SettingsState.initial()) {
    on<Started>(_onStarted, transformer: restartable());
    on<ToggledNotifications>(_onToggledNotifications);
    on<OpenUrl>(_onOpenUrl);
    on<SignedOut>(_onSignedOut);
    on<GuestLogoutPromptResolved>(_onGuestLogoutPromptResolved);
    on<OpenedSettings>(_onOpenedSettings);
    on<PermissionPromptProcessed>(_onPermissionPromptProcessed);
    on<EditProfileClicked>(_onEditProfileClicked);
    on<FeedbackClicked>(_onFeedbackClicked);
    on<MembershipClicked>(_onMembershipClicked);
  }

  bool get _shouldLogView => state.maybeMap(
    initial: (_) => true,
    loading: (_) => true,
    orElse: () => false,
  );

  bool get _isLoaded =>
      state.maybeMap(loaded: (_) => true, orElse: () => false);

  SettingsLoaded? get _loadedStateOrNull =>
      state.mapOrNull(loaded: (loadedState) => loadedState);

  Future<void> _onStarted(Started event, Emitter<SettingsState> emit) async {
    if (_shouldLogView) {
      unawaited(_tracker.logSettingsViewed());
    }

    if (_isLoaded) {
      _logger.info('Silently refreshing SettingsBloc');
    } else {
      _logger.info('Initializing SettingsBloc');
      emit(const SettingsState.loading());
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

  Future<void> _onToggledNotifications(
    ToggledNotifications event,
    Emitter<SettingsState> emit,
  ) async {
    final enable = event.enable;
    _logger.info('Toggling notifications to: $enable');

    final loadedState = _loadedStateOrNull;
    if (loadedState == null) return;

    if (enable && !loadedState.data.isSystemNotificationsEnabled) {
      _emitNotificationsPermissionDenied(loadedState, emit);
      return;
    }

    unawaited(_tracker.logNotificationsToggled(enabled: enable));
    emit(_withAppNotifications(loadedState, enabled: enable));

    final result = await _toggleNotificationsUseCase(enable);
    result.fold((l) {
      _logger.warning('Failed to toggle notifications', l);
      emit(_withAppNotifications(loadedState, enabled: !enable));
    }, (r) => null);
  }

  void _emitNotificationsPermissionDenied(
    SettingsLoaded loadedState,
    Emitter<SettingsState> emit,
  ) {
    _logger.info('User enabled notifications but system permission is missing');
    unawaited(_tracker.logNotificationsPermissionDenied());

    emit(
      _withAppNotifications(
        loadedState,
        enabled: false,
      ).copyWith(shouldShowPermissionPrompt: true),
    );
  }

  SettingsLoaded _withAppNotifications(
    SettingsLoaded loadedState, {
    required bool enabled,
  }) {
    return loadedState.copyWith(
      data: loadedState.data.copyWith(isAppNotificationsEnabled: enabled),
    );
  }

  Future<void> _onPermissionPromptProcessed(
    PermissionPromptProcessed event,
    Emitter<SettingsState> emit,
  ) async {
    final loadedState = _loadedStateOrNull;
    if (loadedState == null) return;
    emit(loadedState.copyWith(shouldShowPermissionPrompt: false));
  }

  Future<void> _onOpenedSettings(
    OpenedSettings event,
    Emitter<SettingsState> emit,
  ) async {
    _logger.info('Opening app settings from permission modal');
    unawaited(_tracker.logSystemSettingsOpened());

    final result = await _openAppSettingsUseCase(NoParams());
    result.fold(
      (failure) => _logger.warning('Failed to open app settings', failure),
      (_) => _logger.info('App settings opened successfully'),
    );
  }

  Future<void> _onSignedOut(
    SignedOut event,
    Emitter<SettingsState> emit,
  ) async {
    _logger.info('User signing out');
    final isGuest = state.maybeMap(
      loaded: (loadedState) => loadedState.data.isGuest,
      orElse: () => false,
    );
    unawaited(_tracker.logSignOutClicked(isGuest: isGuest));

    emit(const SettingsState.loading());
    final result = await _signOutUseCase(
      isGuest ? SignOutMode.deleteGuestAccount : SignOutMode.standard,
    );
    result.fold(
      (l) {
        _logger.warning('Failed to sign out', l);
        emit(SettingsState.failure(l));
      },
      (r) {
        _logger.info('User signed out successfully');
        unawaited(_tracker.logSignOutSuccess(isGuest: isGuest));
        emit(const SettingsState.initial());
      },
    );
  }

  Future<void> _onGuestLogoutPromptResolved(
    GuestLogoutPromptResolved event,
    Emitter<SettingsState> emit,
  ) async {
    _logger.info('Guest logout prompt resolved: ${event.choice.name}');
    unawaited(_tracker.logGuestLogoutChoice(choice: event.choice));
  }

  Future<void> _onOpenUrl(OpenUrl event, Emitter<SettingsState> emit) async {
    final url = event.url;
    _logger.info('Opening URL: $url');
    unawaited(_tracker.logSettingsLinkClicked(type: event.type));

    final result = await _launchUrlUseCase(url);
    result.fold(
      (failure) => _logger.warning('Failed to open URL: $url', failure),
      (_) => _logger.info('URL opened successfully: $url'),
    );
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
