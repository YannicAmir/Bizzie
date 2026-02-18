import 'package:bizzie/core/interfaces/i_in_app_review_service.dart';
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
  final IInAppReviewService _reviewService;

  AppRatingsBloc(this._trackRatingConditionsUseCase, this._reviewService)
    : super(const AppRatingsState.initial()) {
    on<_InteractionDetected>(_onInteractionDetected);
  }

  Future<void> _onInteractionDetected(
    _InteractionDetected event,
    Emitter<AppRatingsState> emit,
  ) async {
    try {
      final result = await _trackRatingConditionsUseCase(NoParams());

      await result.fold(
        (failure) async {
          _logger.severe(
            'Failure tracking rating conditions: ${failure.message}',
          );
          emit(const AppRatingsState.idle());
        },
        (shouldRequestReview) async {
          _logger.info(
            'Rating conditions evaluation result: shouldRequestReview=$shouldRequestReview',
          );
          if (shouldRequestReview) {
            _logger.info(
              'Rating conditions met. Requesting review via service.',
            );
            await _reviewService.requestReview();
            emit(const AppRatingsState.requestReview());
          }
          emit(const AppRatingsState.idle());
        },
      );
    } catch (e, s) {
      _logger.severe('Error tracking rating conditions', e, s);
      emit(const AppRatingsState.idle());
    }
  }
}
