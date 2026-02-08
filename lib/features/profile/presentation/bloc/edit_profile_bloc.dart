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

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final GetCurrentUser _getCurrentUser;
  final GetUserUseCase _getUserUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  EditProfileBloc(
    this._getCurrentUser,
    this._getUserUseCase,
    this._updateProfileUseCase,
    this._deleteAccountUseCase,
  ) : super(const EditProfileState.initial()) {
    on<EditProfileEvent>((event, emit) async {
      await event.map(
        started: (e) => _onStarted(e, emit),
        firstNameChanged: (e) => _onFirstNameChanged(e, emit),
        emailChanged: (e) => _onEmailChanged(e, emit),
        saveRequested: (e) => _onSaveRequested(e, emit),
        deleteAccountRequested: (e) => _onDeleteAccountRequested(e, emit),
      );
    }, transformer: restartable());
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
            email: currentState.email != currentState.originalEmail
                ? currentState.email
                : null,
          ),
        );

        result.fold(
          (failure) {
            emit(
              currentState.copyWith(isSubmitting: false, saveFailure: failure),
            );
          },
          (_) {
            emit(const EditProfileState.success());
          },
        );
      },
    );
  }

  Future<void> _onDeleteAccountRequested(
    DeleteAccountRequested event,
    Emitter<EditProfileState> emit,
  ) async {
    final currentSector = state.maybeMap(
      loading: (s) => s.favoriteSector,
      failure: (s) => s.favoriteSector,
      form: (s) => s.favoriteSector,
      orElse: () => null,
    );
    emit(EditProfileState.loading(favoriteSector: currentSector));

    final result = await _deleteAccountUseCase(NoParams());
    result.fold(
      (failure) => emit(
        EditProfileState.failure(failure, favoriteSector: currentSector),
      ),
      (_) => emit(const EditProfileState.success()),
    );
  }
}
