import 'package:bizzie/core/analytics/models/app_rating_prompt_context.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/app_ratings/domain/usecases/track_rating_conditions_usecase.dart';
import 'package:bizzie/features/app_ratings/presentation/analytics/app_ratings_tracker.dart';
import 'package:bizzie/features/auth/domain/usecases/get_current_user.dart';
import 'package:bizzie/features/user/domain/usecases/get_user_usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bizzie/core/interfaces/i_in_app_review_service.dart';
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
  final AppRatingsTracker _tracker;
  final GetCurrentUser _getCurrentUser;
  final GetUserUseCase _getUserUseCase;
  final IConfigService _configService;

  AppRatingsBloc(
    this._trackRatingConditionsUseCase,
    this._reviewService,
    this._tracker,
    this._getCurrentUser,
    this._getUserUseCase,
    this._configService,
  ) : super(const AppRatingsState.initial()) {
    on<_InteractionDetected>(_onInteractionDetected);
  }

  Future<void> _onInteractionDetected(
    _InteractionDetected event,
    Emitter<AppRatingsState> emit,
  ) async {
    final result = await _trackRatingConditionsUseCase(NoParams());

    await result.fold(
      (failure) => _onFailure(failure, emit),
      (conditions) => _onConditionsEvaluated(conditions, event, emit),
    );
  }

  Future<void> _onFailure(
    Failure failure,
    Emitter<AppRatingsState> emit,
  ) async {
    _logger.severe('Failure tracking rating conditions: ${failure.message}');
    emit(const AppRatingsState.idle());
  }

  Future<void> _onConditionsEvaluated(
    RatingConditionsResult conditions,
    _InteractionDetected event,
    Emitter<AppRatingsState> emit,
  ) async {
    _logger.info('Rating conditions evaluation result: $conditions');

    if (conditions == RatingConditionsResult.maxAttemptsReached) {
      return _handleMaxAttemptsReached(emit);
    }

    final context = await _gatherPromptContext(event);
    if (context == null) {
      emit(const AppRatingsState.idle());
      return;
    }

    await _trackInteraction(context, event.company);

    if (conditions == RatingConditionsResult.prompt) {
      await _presentReviewPrompt(context, emit);
    }

    emit(const AppRatingsState.idle());
  }

  Future<void> _handleMaxAttemptsReached(Emitter<AppRatingsState> emit) async {
    _logger.info('Analytics detached: Max attempts already reached.');
    await _tracker.updateStatus(AppRatingStatus.maxAttemptsReached);
    emit(const AppRatingsState.idle());
  }

  Future<void> _trackInteraction(
    AppRatingPromptContext context,
    CompanyProfile company,
  ) async {
    if (context.interactionCount == 1 && context.promptAttempts == 0) {
      await _tracker.updateStatus(AppRatingStatus.inProgress);
    }

    await _tracker.logInteraction(
      ticker: company.symbol,
      count: context.interactionCount,
    );
  }

  Future<void> _presentReviewPrompt(
    AppRatingPromptContext context,
    Emitter<AppRatingsState> emit,
  ) async {
    _logger.info('Rating conditions met. Requesting review via service.');
    await _tracker.logPromptShown(context: context);
    await _tracker.updateStatus(AppRatingStatus.completed);
    await _reviewService.requestReview();
    emit(const AppRatingsState.requestReview());
  }

  Future<AppRatingPromptContext?> _gatherPromptContext(
    _InteractionDetected event,
  ) async {
    final authUser = _getCurrentUser();
    if (authUser == null) return null;

    final userResult = await _getUserUseCase(authUser.id);
    final user = userResult.getOrElse(() => throw Exception('User not found'));

    final interactionCount = await _trackRatingConditionsUseCase
        .getInteractionCount();
    final promptAttempts = await _trackRatingConditionsUseCase
        .getPromptAttempts();

    return AppRatingPromptContext(
      ticker: event.company.symbol,
      companyName: event.company.companyName ?? '',
      sector: event.company.sector ?? '',
      industry: event.company.industry ?? '',
      experienceLevel: user.investingExperience.name,
      favoriteSector: user.favoriteSector,
      isPremium: user.isSubscribed,
      watchlistCount: user.watchlist.length,
      notificationsEnabled: user.notificationsEnabled,
      interactionCount: interactionCount,
      promptAttempts: promptAttempts,
      currentTab: event.currentTab,
      thresholdCount: _configService.reviewPromptEventCount,
    );
  }
}
