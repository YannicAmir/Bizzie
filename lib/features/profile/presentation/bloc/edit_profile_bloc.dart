import 'package:bizzie/features/auth/domain/usecases/get_current_user.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:bizzie/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_state.dart';
import 'package:bizzie/features/user/domain/usecases/get_user_usecase.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/auth/domain/usecases/reauthenticate_usecase.dart';
import 'package:bizzie/features/auth/domain/enums/auth_provider.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/profile/domain/enums/reauth_action.dart';

final _logger = BizzieLogger('EditProfileBloc');

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  static const int maxReauthAttempts = 3;

  final GetCurrentUser _getCurrentUser;
  final GetUserUseCase _getUserUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final ReauthenticateUseCase _reauthenticateUseCase;

  EditProfileBloc(
    this._getCurrentUser,
    this._getUserUseCase,
    this._updateProfileUseCase,
    this._deleteAccountUseCase,
    this._reauthenticateUseCase,
  ) : super(
        EditProfileState.initial(favoriteSector: _getUserUseCase.cachedSector),
      ) {
    on<Started>(_onStarted, transformer: restartable());
    on<FirstNameChanged>(_onFirstNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<SaveRequested>(_onSaveRequested);
    on<DeleteAccountRequested>(_onDeleteAccountRequested);
    on<ReauthenticateWithPassword>(_onReauthenticateWithPassword);
    on<ReauthenticateWithGoogle>(_onReauthenticateWithGoogle);
    on<ReauthenticateWithApple>(_onReauthenticateWithApple);
    on<ReauthModalDismissed>(_onReauthModalDismissed);
    on<DeleteAccountConfirmed>(_onDeleteAccountConfirmed);
    on<DeleteConfirmationDismissed>(_onDeleteConfirmationDismissed);
    on<ShowDeleteConfirmation>(_onShowDeleteConfirmation);
    on<ToggleReauthPasswordVisibility>(_onToggleReauthPasswordVisibility);
  }

  Future<void> _onStarted(Started event, Emitter<EditProfileState> emit) async {
    _logger.info('EditProfile started');
    final cachedSector = _getUserUseCase.cachedSector;
    emit(EditProfileState.loading(favoriteSector: cachedSector));

    final currentUser = _getCurrentUser();
    if (currentUser == null) {
      _logger.severe('User not found during EditProfile initialization');
      emit(
        EditProfileState.failure(
          const Failure.userNotFound(),
          favoriteSector: cachedSector,
        ),
      );
      return;
    }

    final userResult = await _getUserUseCase(currentUser.id);

    userResult.fold(
      (failure) {
        _logger.severe('Failed to load user profile: $failure');
        emit(EditProfileState.failure(failure, favoriteSector: cachedSector));
      },
      (userModel) {
        _logger.info('User profile loaded successfully');
        emit(
          EditProfileState.form(
            firstName: userModel.name,
            email: currentUser.email,
            originalFirstName: userModel.name,
            originalEmail: currentUser.email,
            favoriteSector: userModel.favoriteSector,
            providers: currentUser.providers,
          ),
        );
      },
    );
  }

  Future<void> _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<EditProfileState> emit,
  ) async {
    state.mapOrNull(
      form: (currentState) {
        emit(
          currentState.copyWith(firstName: event.firstName, saveFailure: null),
        );
      },
    );
  }

  Future<void> _onEmailChanged(
    EmailChanged event,
    Emitter<EditProfileState> emit,
  ) async {
    state.mapOrNull(
      form: (currentState) {
        emit(currentState.copyWith(email: event.email, saveFailure: null));
      },
    );
  }

  Future<void> _onSaveRequested(
    SaveRequested event,
    Emitter<EditProfileState> emit,
  ) async {
    await state.mapOrNull(
      form: (currentState) async {
        if (currentState.isSubmitting) return;

        _logger.info('Profile update initiated');
        emit(currentState.copyWith(isSubmitting: true, saveFailure: null));

        final result = await _updateProfileUseCase(
          UpdateProfileParams(
            firstName: currentState.firstName != currentState.originalFirstName
                ? currentState.firstName
                : null,
          ),
        );

        result.fold(
          (failure) {
            failure.maybeMap(
              reauthentication: (_) {
                _logger.info('Sensitive update requires re-authentication');
                emit(
                  currentState.copyWith(
                    isSubmitting: false,
                    isShowReauthModal: true,
                    pendingReauthAction: ReauthAction.save,
                    saveFailure: null,
                  ),
                );
              },
              orElse: () {
                _logger.severe('Profile update failed: $failure');
                emit(
                  currentState.copyWith(
                    isSubmitting: false,
                    saveFailure: failure,
                  ),
                );
              },
            );
          },
          (_) {
            _logger.info('Profile updated successfully');
            emit(
              EditProfileState.success(
                favoriteSector: currentState.favoriteSector,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onDeleteAccountRequested(
    DeleteAccountRequested event,
    Emitter<EditProfileState> emit,
  ) async {
    await state.mapOrNull(
      form: (currentState) async {
        if (currentState.isDeleting) return;

        emit(
          currentState.copyWith(
            isShowReauthModal: true,
            pendingReauthAction: ReauthAction.deleteAccount,
          ),
        );
      },
    );
  }

  Future<void> _onDeleteAccountConfirmed(
    DeleteAccountConfirmed event,
    Emitter<EditProfileState> emit,
  ) async {
    await state.mapOrNull(
      form: (currentState) async {
        if (currentState.isDeleting) return;

        _logger.info('Account deletion initiated');
        emit(
          currentState.copyWith(
            isDeleting: true,
            isShowDeleteConfirmation: false,
          ),
        );

        final result = await _deleteAccountUseCase(NoParams());

        result.fold(
          (failure) {
            _logger.severe('Account deletion failed: $failure');
            emit(
              currentState.copyWith(isDeleting: false, saveFailure: failure),
            );
          },
          (_) {
            _logger.info('Account deleted successfully');
            emit(
              EditProfileState.deleted(
                favoriteSector: currentState.favoriteSector,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onDeleteConfirmationDismissed(
    DeleteConfirmationDismissed event,
    Emitter<EditProfileState> emit,
  ) async {
    state.mapOrNull(
      form: (currentState) {
        emit(currentState.copyWith(isShowDeleteConfirmation: false));
      },
    );
  }

  Future<void> _onReauthenticateWithPassword(
    ReauthenticateWithPassword event,
    Emitter<EditProfileState> emit,
  ) async {
    await _handleReauthentication(
      emit,
      AuthProvider.password,
      password: event.password,
    );
  }

  Future<void> _onToggleReauthPasswordVisibility(
    ToggleReauthPasswordVisibility event,
    Emitter<EditProfileState> emit,
  ) async {
    state.mapOrNull(
      form: (currentState) {
        emit(
          currentState.copyWith(
            isReauthPasswordVisible: !currentState.isReauthPasswordVisible,
          ),
        );
      },
    );
  }

  Future<void> _onReauthenticateWithGoogle(
    ReauthenticateWithGoogle event,
    Emitter<EditProfileState> emit,
  ) async {
    await _handleReauthentication(emit, AuthProvider.google);
  }

  Future<void> _onReauthenticateWithApple(
    ReauthenticateWithApple event,
    Emitter<EditProfileState> emit,
  ) async {
    await _handleReauthentication(emit, AuthProvider.apple);
  }

  Future<void> _onReauthModalDismissed(
    ReauthModalDismissed event,
    Emitter<EditProfileState> emit,
  ) async {
    state.mapOrNull(
      form: (currentState) {
        emit(
          currentState.copyWith(
            isShowReauthModal: false,
            pendingReauthAction: null,
            reauthFailure: null,
            isReauthSubmitting: false,
            reauthAttempts: 0,
            isReauthPasswordVisible: false,
          ),
        );
      },
    );
  }

  Future<void> _handleReauthentication(
    Emitter<EditProfileState> emit,
    AuthProvider provider, {
    String? password,
  }) async {
    _logger.info('Reauth with ${provider.name} initiated');
    await state.mapOrNull(
      form: (currentState) async {
        emit(
          currentState.copyWith(isReauthSubmitting: true, reauthFailure: null),
        );

        final result = await _reauthenticateUseCase(
          ReauthenticateParams(provider: provider, password: password),
        );

        await result.fold((failure) async {
          _logger.severe('${provider.name} re-authentication failed: $failure');

          final newAttempts = currentState.reauthAttempts + 1;
          emit(
            currentState.copyWith(
              isReauthSubmitting: false,
              reauthFailure: failure,
              reauthAttempts: newAttempts,
            ),
          );

          if (newAttempts >= maxReauthAttempts) {
            _logger.warning(
              'Max re-auth attempts reached ($maxReauthAttempts)',
            );

            emit(
              currentState.copyWith(
                isReauthSubmitting: false,
                reauthFailure: null,
                reauthAttempts: newAttempts,
                isShowReauthModal: false,
                pendingReauthAction: null,
              ),
            );
          }
        }, (_) async => await _onReauthSuccess(emit));
      },
    );
  }

  Future<void> _onReauthSuccess(Emitter<EditProfileState> emit) async {
    _logger.info('Reauth Success Handler triggered');
    await state.mapOrNull(
      form: (currentState) async {
        _logger.info(
          'Resuming pending action: ${currentState.pendingReauthAction}',
        );
        var newState = currentState.copyWith(
          isShowReauthModal: false,
          reauthFailure: null,
          reauthAttempts: 0,
          isReauthSubmitting: false,
        );

        emit(newState);

        switch (currentState.pendingReauthAction) {
          case ReauthAction.save:
            await _onSaveRequested(const SaveRequested(), emit);
          case ReauthAction.deleteAccount:
            await _onShowDeleteConfirmation(
              const ShowDeleteConfirmation(),
              emit,
            );
          case null:
            break;
        }
      },
    );
  }

  Future<void> _onShowDeleteConfirmation(
    ShowDeleteConfirmation event,
    Emitter<EditProfileState> emit,
  ) async {
    _logger.info('ShowDeleteConfirmation triggered');
    await state.mapOrNull(
      form: (currentState) async {
        if (currentState.pendingReauthAction == ReauthAction.deleteAccount) {
          emit(
            currentState.copyWith(
              isShowDeleteConfirmation: true,
              pendingReauthAction: null,
            ),
          );
        }
      },
    );
  }
}
