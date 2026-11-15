import 'dart:async';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:bizzie/features/user/domain/usecases/get_user_usecase.dart';
import 'package:bizzie/features/user/domain/usecases/watch_user_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

final _logger = BizzieLogger('UserBloc');

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase _getUserUseCase;
  final WatchUserUseCase _watchUserUseCase;

  UserBloc(this._getUserUseCase, this._watchUserUseCase)
    : super(const UserState.initial()) {
    // Reset shares the restartable registration so it cancels the active user stream.
    on<UserEvent>(
      (event, emit) => event.map<Future<void>>(
        loadUser: (e) => _onLoadUser(e, emit),
        reset: (e) => _onReset(e, emit),
      ),
      transformer: restartable(),
    );
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

    await emit.forEach<Either<Failure, UserModel?>>(
      _watchUserUseCase(event.uid),
      onData: (result) => result.fold(
        (failure) => _failureState(failure, event.uid),
        (user) => _userState(user, event.uid),
      ),
      onError: (error, stackTrace) {
        _logger.severe('User stream error', error, stackTrace);
        return _failureState(Failure.server(error.toString()), event.uid);
      },
    );
  }

  UserState _userState(UserModel? user, String uid) {
    if (user == null) {
      _logger.info(
        'User document not found, emitting needsProfile for uid: $uid',
      );
      return const UserState.needsProfile();
    }
    _logger.info('User stream emitted update for uid: ${user.uid}');
    return UserState.loaded(user);
  }

  UserState _failureState(Failure failure, String uid) {
    return UserState.failure(
      failure,
      uid: uid,
      cachedSector: _getUserUseCase.cachedSector,
    );
  }

  Future<void> _onReset(UserReset event, Emitter<UserState> emit) async {
    _logger.info('Resetting UserBloc');
    emit(const UserState.initial());
  }
}
