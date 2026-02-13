import 'dart:async';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bizzie/features/user/domain/usecases/get_user_usecase.dart';
import 'package:bizzie/features/user/domain/usecases/watch_user_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

final _logger = BizzieLogger('UserBloc');

@lazySingleton
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase _getUserUseCase;
  final WatchUserUseCase _watchUserUseCase;
  final IUserRepository _userRepository;

  UserBloc(this._getUserUseCase, this._watchUserUseCase, this._userRepository)
    : super(const UserState.initial()) {
    on<UserLoadRequested>(_onLoadUser, transformer: restartable());
    on<UserClearRequested>(_onClear);
  }

  /// Starts a persistent Firestore stream for the given [event.uid].
  ///
  /// Uses [emit.forEach] to keep the subscription alive and emit new states
  /// whenever the underlying data changes. The [restartable()] transformer
  /// ensures that if a new [UserLoadRequested] arrives, the previous
  /// stream subscription is cancelled before starting a new one.
  Future<void> _onLoadUser(
    UserLoadRequested event,
    Emitter<UserState> emit,
  ) async {
    if (!event.silent) {
      final cached = _getUserUseCase.cachedSector;
      emit(UserState.loading(cachedSector: cached));
    }
    _logger.info('Starting persistent stream for uid: ${event.uid}');

    await emit.forEach<UserModel>(
      _watchUserUseCase(event.uid),
      onData: (user) {
        _logger.info('User stream emitted update for uid: ${user.uid}');
        return UserState.loaded(user);
      },
      onError: (error, stackTrace) {
        _logger.severe('User stream error', error, stackTrace);
        return UserState.failure(
          Failure.server(error.toString()),
          uid: event.uid,
          cachedSector: _getUserUseCase.cachedSector,
        );
      },
    );
  }

  /// Stops the active Firestore stream and resets the state to [initial].
  ///
  /// Calls [IUserRepository.dispose] which closes the internal
  /// [BehaviorSubject] — this causes [emit.forEach] in [_onLoadUser]
  /// to complete naturally via the stream's `done` event.
  void _onClear(UserClearRequested event, Emitter<UserState> emit) {
    _logger.info('Clearing user profile and stopping stream');
    _userRepository.dispose();
    emit(const UserState.initial());
  }

  @override
  Future<void> close() {
    _userRepository.dispose();
    return super.close();
  }
}
