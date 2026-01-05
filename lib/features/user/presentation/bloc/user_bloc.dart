import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/onboarding/domain/models/user_model.dart';
import 'package:bizzie/features/user/domain/usecases/get_user_usecase.dart';
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

  UserBloc(this._getUserUseCase) : super(const UserState.initial()) {
    on<_LoadUser>(_onLoadUser);
    on<_Clear>(_onClear);
  }

  Future<void> _onLoadUser(_LoadUser event, Emitter<UserState> emit) async {
    emit(UserState.loading(cachedSector: _getUserUseCase.cachedSector));
    _logger.info('Loading user profile for uid: ${event.uid}');

    final result = await _getUserUseCase(event.uid);

    result.fold(
      (failure) {
        _logger.severe('Failed to load user profile', failure.message);
        emit(
          UserState.failure(
            failure.message,
            cachedSector: _getUserUseCase.cachedSector,
          ),
        );
      },
      (user) {
        _logger.info('User profile loaded successfully');
        emit(UserState.loaded(user));
      },
    );
  }

  void _onClear(_Clear event, Emitter<UserState> emit) {
    _logger.info('Clearing user profile');
    emit(const UserState.initial());
  }
}
