import 'dart:async';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/profile/domain/usecases/get_profile_display_data_usecase.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_state.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ProfileBloc');

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileDisplayDataUseCase _getProfileDisplayDataUseCase;
  final IUserRepository _userRepository;
  StreamSubscription? _userSubscription;

  ProfileBloc(this._getProfileDisplayDataUseCase, this._userRepository)
    : super(const ProfileState.initial()) {
    _userSubscription = _userRepository.userStream.listen(
      (_) {
        add(const ProfileEvent.started());
      },
      onError: (Object error, StackTrace stackTrace) {
        _logger.severe('User stream error', error, stackTrace);
      },
    );

    on<Started>(_onStarted, transformer: restartable());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(Started event, Emitter<ProfileState> emit) async {
    _logger.info('Fetching profile display data...');
    emit(const ProfileState.loading());

    final result = await _getProfileDisplayDataUseCase(NoParams());

    result.fold(
      (failure) {
        _logger.severe('Failed to fetch profile data', failure);
        emit(ProfileState.failure(failure));
      },
      (data) {
        _logger.info('Profile data fetched successfully');
        emit(ProfileState.loaded(data));
      },
    );
  }
}
