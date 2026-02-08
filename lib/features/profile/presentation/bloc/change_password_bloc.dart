import 'package:bizzie/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:bizzie/features/profile/presentation/bloc/change_password_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/change_password_state.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordBloc(this._changePasswordUseCase)
    : super(const ChangePasswordState.initial()) {
    on<ChangePasswordEvent>((event, emit) async {
      await event.map(
        started: (e) => _onStarted(e, emit),
        oldPasswordChanged: (e) => _onOldPasswordChanged(e, emit),
        newPasswordChanged: (e) => _onNewPasswordChanged(e, emit),
        confirmPasswordChanged: (e) => _onConfirmPasswordChanged(e, emit),
        saveRequested: (e) => _onSaveRequested(e, emit),
      );
    }, transformer: restartable());
  }

  Future<void> _onStarted(
    Started event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(const ChangePasswordState.form());
  }

  Future<void> _onOldPasswordChanged(
    OldPasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) async {
    state.mapOrNull(
      form: (currentState) {
        emit(currentState.copyWith(oldPassword: event.password, failure: null));
      },
    );
  }

  Future<void> _onNewPasswordChanged(
    NewPasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) async {
    state.mapOrNull(
      form: (currentState) {
        emit(currentState.copyWith(newPassword: event.password, failure: null));
      },
    );
  }

  Future<void> _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) async {
    state.mapOrNull(
      form: (currentState) {
        emit(
          currentState.copyWith(confirmPassword: event.password, failure: null),
        );
      },
    );
  }

  Future<void> _onSaveRequested(
    SaveRequested event,
    Emitter<ChangePasswordState> emit,
  ) async {
    await state.mapOrNull(
      form: (currentState) async {
        if (currentState.isSubmitting) return;

        if (currentState.newPassword != currentState.confirmPassword) {
          emit(
            currentState.copyWith(failure: const Failure.passwordMismatch()),
          );
          return;
        }

        emit(currentState.copyWith(isSubmitting: true, failure: null));

        final result = await _changePasswordUseCase(
          ChangePasswordParams(
            oldPassword: currentState.oldPassword,
            newPassword: currentState.newPassword,
          ),
        );

        result.fold(
          (failure) {
            emit(currentState.copyWith(isSubmitting: false, failure: failure));
          },
          (_) {
            emit(const ChangePasswordState.success());
          },
        );
      },
    );
  }
}
