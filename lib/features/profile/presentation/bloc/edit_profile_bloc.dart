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
import 'package:bizzie/features/auth/domain/usecases/reauthenticate_with_password_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/reauthenticate_with_google_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/reauthenticate_with_apple_usecase.dart';
import 'package:bizzie/core/utils/retry_util.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/profile/domain/enums/reauth_action.dart';

final _logger = BizzieLogger('EditProfileBloc');

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final GetCurrentUser _getCurrentUser;
  final GetUserUseCase _getUserUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final ReauthenticateWithPasswordUseCase _reauthenticateWithPasswordUseCase;
  final ReauthenticateWithGoogleUseCase _reauthenticateWithGoogleUseCase;
  final ReauthenticateWithAppleUseCase _reauthenticateWithAppleUseCase;

  EditProfileBloc(
    this._getCurrentUser,
    this._getUserUseCase,
    this._updateProfileUseCase,
    this._deleteAccountUseCase,
    this._reauthenticateWithPasswordUseCase,
    this._reauthenticateWithGoogleUseCase,
    this._reauthenticateWithAppleUseCase,
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
    final cachedSector = _getUserUseCase.cachedSector;
    emit(EditProfileState.loading(favoriteSector: cachedSector));

    final currentUser = _getCurrentUser();
    if (currentUser == null) {
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
        emit(EditProfileState.failure(failure, favoriteSector: cachedSector));
      },
      (userModel) {
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
            reauthTitle: 'Confirm Account Deletion',
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

        emit(
          currentState.copyWith(
            isDeleting: true,
            isShowDeleteConfirmation: false,
          ),
        );

        final result = await _deleteAccountUseCase(NoParams());

        result.fold(
          (failure) => emit(
            currentState.copyWith(isDeleting: false, saveFailure: failure),
          ),
          (_) => emit(
            EditProfileState.deleted(
              favoriteSector: currentState.favoriteSector,
            ),
          ),
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
    _logger.info('Reauth with Password initiated');
    await state.mapOrNull(
      form: (currentState) async {
        emit(
          currentState.copyWith(isReauthSubmitting: true, reauthFailure: null),
        );

        try {
          final result = await RetryUtil.retry(
            task: () => _reauthenticateWithPasswordUseCase(
              ReauthenticateWithPasswordParams(password: event.password),
            ),
          );

          await result.fold((failure) async {
            emit(
              currentState.copyWith(
                isReauthSubmitting: false,
                reauthFailure: const Failure.reauthentication(
                  'This password you provided is incorrect',
                ),
                reauthAttempts: currentState.reauthAttempts + 1,
              ),
            );
            _checkRetryLimit(
              emit,
              currentState,
              currentState.reauthAttempts + 1,
            );
          }, (_) async => await _onReauthSuccess(emit, currentState));
        } catch (e) {
          emit(
            currentState.copyWith(
              isReauthSubmitting: false,
              reauthFailure: const Failure.server(
                'Network error. Please try again.',
              ),
            ),
          );
        }
      },
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
    await state.mapOrNull(
      form: (currentState) async {
        emit(
          currentState.copyWith(isReauthSubmitting: true, reauthFailure: null),
        );
        try {
          final result = await RetryUtil.retry(
            task: () => _reauthenticateWithGoogleUseCase(NoParams()),
          );
          await result.fold((failure) async {
            emit(
              currentState.copyWith(
                isReauthSubmitting: false,
                reauthFailure: failure,
                reauthAttempts: currentState.reauthAttempts + 1,
              ),
            );
            _checkRetryLimit(
              emit,
              currentState,
              currentState.reauthAttempts + 1,
            );
          }, (_) async => await _onReauthSuccess(emit, currentState));
        } catch (e) {
          emit(
            currentState.copyWith(
              isReauthSubmitting: false,
              reauthFailure: const Failure.server(
                'Network error. Please try again.',
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _onReauthenticateWithApple(
    ReauthenticateWithApple event,
    Emitter<EditProfileState> emit,
  ) async {
    _logger.info('Reauth with Apple initiated');
    await state.mapOrNull(
      form: (currentState) async {
        emit(
          currentState.copyWith(isReauthSubmitting: true, reauthFailure: null),
        );
        try {
          final result = await RetryUtil.retry(
            task: () => _reauthenticateWithAppleUseCase(NoParams()),
          );
          await result.fold((failure) async {
            emit(
              currentState.copyWith(
                isReauthSubmitting: false,
                reauthFailure: failure,
                reauthAttempts: currentState.reauthAttempts + 1,
              ),
            );
            _checkRetryLimit(
              emit,
              currentState,
              currentState.reauthAttempts + 1,
            );
          }, (_) async => await _onReauthSuccess(emit, currentState));
        } catch (e) {
          emit(
            currentState.copyWith(
              isReauthSubmitting: false,
              reauthFailure: const Failure.server(
                'Network error. Please try again.',
              ),
            ),
          );
        }
      },
    );
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

  void _checkRetryLimit(
    Emitter<EditProfileState> emit,
    EditProfileState formState,
    int attempts,
  ) {
    if (attempts >= 3) {
      formState.mapOrNull(
        form: (currentState) {
          emit(
            currentState.copyWith(
              isShowReauthModal: false,
              reauthFailure: null,
              pendingReauthAction: null,
            ),
          );
        },
      );
    }
  }

  Future<void> _onReauthSuccess(
    Emitter<EditProfileState> emit,
    dynamic _,
  ) async {
    _logger.info('Reauth Success Handler triggered');
    await state.mapOrNull(
      form: (currentState) async {
        _logger.info(
          'Current state pending action: ${currentState.pendingReauthAction}',
        );
        var newState = currentState.copyWith(
          isShowReauthModal: false,
          reauthFailure: null,
          reauthAttempts: 0,
          isReauthSubmitting: false,
        );

        if (currentState.pendingReauthAction == ReauthAction.save) {
          emit(newState);
          add(const EditProfileEvent.saveRequested());
        } else {
          emit(newState);
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
