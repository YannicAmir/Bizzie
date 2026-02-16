import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/app_ratings/domain/usecases/track_rating_conditions_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_ratings_event.dart';
part 'app_ratings_state.dart';
part 'app_ratings_bloc.freezed.dart';

final _logger = BizzieLogger('AppRatingsBloc');

@injectable
class AppRatingsBloc extends Bloc<AppRatingsEvent, AppRatingsState> {
  final TrackRatingConditionsUseCase _trackRatingConditionsUseCase;

  AppRatingsBloc(this._trackRatingConditionsUseCase)
    : super(const AppRatingsState.initial()) {
    on<_InteractionDetected>(_onInteractionDetected);
  }

  Future<void> _onInteractionDetected(
    _InteractionDetected event,
    Emitter<AppRatingsState> emit,
  ) async {
    try {
      final result = await _trackRatingConditionsUseCase(NoParams());

      result.fold(
        (failure) {
          _logger.severe(
            'Failure tracking rating conditions: ${failure.message}',
          );
          emit(const AppRatingsState.idle());
        },
        (shouldRequestReview) {
          if (shouldRequestReview) {
            _logger.info(
              'Rating conditions met. Emitting requestReview state.',
            );
            emit(const AppRatingsState.requestReview());
            emit(const AppRatingsState.idle());
          } else {
            emit(const AppRatingsState.idle());
          }
        },
      );
    } catch (e, s) {
      _logger.severe('Error tracking rating conditions', e, s);
      emit(const AppRatingsState.idle());
    }
  }
}
