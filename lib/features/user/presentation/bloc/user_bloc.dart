import 'dart:async';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/user/domain/usecases/get_cached_favorite_sector_usecase.dart';
import 'package:bizzie/features/user/domain/usecases/update_last_viewed_at_usecase.dart';
import 'package:bizzie/features/user/domain/usecases/watch_user_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'user_event.dart';
import 'user_state.dart';

export 'user_event.dart';
export 'user_state.dart';

final _logger = BizzieLogger('UserBloc');

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCachedFavoriteSectorUseCase _getCachedFavoriteSectorUseCase;
  final WatchUserUseCase _watchUserUseCase;
  final UpdateLastViewedAtUseCase _updateLastViewedAtUseCase;

  UserBloc(
    this._getCachedFavoriteSectorUseCase,
    this._watchUserUseCase,
    this._updateLastViewedAtUseCase,
  ) : super(const UserState.initial()) {
    // Reset shares the restartable registration so it cancels the active user stream.
    on<UserEvent>(
      (event, emit) => event.maybeMap<Future<void>>(
        loadUser: (e) => _onLoadUser(e, emit),
        reset: (e) => _onReset(e, emit),
        orElse: () async {},
      ),
      transformer: _restartableSession(),
    );
    on<UserAppForegrounded>(_onAppForegrounded, transformer: droppable());
  }

  EventTransformer<UserEvent> _restartableSession() {
    return (events, mapper) =>
        restartable<UserEvent>()(events.where(_isSessionEvent), mapper);
  }

  bool _isSessionEvent(UserEvent event) =>
      event is UserLoadRequested || event is UserReset;

  Future<void> _onLoadUser(
    UserLoadRequested event,
    Emitter<UserState> emit,
  ) async {
    if (!event.silent) {
      final cached = _getCachedFavoriteSectorUseCase(NoParams());
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
      cachedSector: _getCachedFavoriteSectorUseCase(NoParams()),
    );
  }

  Future<void> _onAppForegrounded(
    UserAppForegrounded event,
    Emitter<UserState> emit,
  ) async {
    if (state is! UserLoaded) return;

    final result = await _updateLastViewedAtUseCase(NoParams());
    result.fold(
      (failure) => _logger.warning(
        'Failed to update lastViewedAt: ${failure.errorMessage}',
      ),
      (_) => null,
    );
  }

  Future<void> _onReset(UserReset event, Emitter<UserState> emit) async {
    _logger.info('Resetting UserBloc');
    emit(const UserState.initial());
  }
}
