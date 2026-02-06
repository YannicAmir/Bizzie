import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/profile/domain/usecases/get_profile_display_data_usecase.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ProfileBloc');

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileDisplayDataUseCase _getProfileDisplayDataUseCase;

  ProfileBloc(this._getProfileDisplayDataUseCase)
    : super(const ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      await event.map(started: (_) => _onStarted(emit));
    });
  }

  Future<void> _onStarted(Emitter<ProfileState> emit) async {
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
