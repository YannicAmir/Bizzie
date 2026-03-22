import 'dart:async';
import 'package:bizzie/features/feedback/domain/usecases/submit_feedback_usecase.dart';
import 'package:bizzie/features/feedback/presentation/analytics/feedback_tracker.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_event.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('FeedbackBloc');

@injectable
class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final SubmitFeedbackUseCase _submitFeedbackUseCase;
  final FeedbackTracker _tracker;

  Timer? _cooldownTimer;
  bool _hasTyped = false;
  int _messageLength = 0;

  FeedbackBloc(this._submitFeedbackUseCase, this._tracker)
    : super(const FeedbackState.initial()) {
    on<FeedbackViewed>(_onViewed);
    on<FeedbackSubmit>(_onSubmit);
    on<FeedbackMessageChanged>(_onMessageChanged);
    on<FeedbackCooldownEnded>(_onCooldownEnded);
  }

  @override
  Future<void> close() async {
    if (state is! Success && (state is! Loading || _hasTyped)) {
      await _tracker.logFeedbackAbandoned(
        hasTyped: _hasTyped,
        messageLength: _messageLength,
      );
    }
    _cooldownTimer?.cancel();
    return super.close();
  }

  Future<void> _onViewed(
    FeedbackViewed event,
    Emitter<FeedbackState> emit,
  ) async {
    await _tracker.logFeedbackViewed(intentSource: event.intentSource);
  }

  void _onMessageChanged(
    FeedbackMessageChanged event,
    Emitter<FeedbackState> emit,
  ) {
    _hasTyped = event.message.trim().isNotEmpty;
    _messageLength = event.message.length;

    state.maybeMap(
      failure: (s) =>
          emit(FeedbackState.initial(isCoolingDown: s.isCoolingDown)),
      orElse: () {},
    );
  }

  void _onCooldownEnded(
    FeedbackCooldownEnded event,
    Emitter<FeedbackState> emit,
  ) {
    _logger.info('Cooldown ended for feedback submission');
    emit(
      state.map(
        initial: (s) => s.copyWith(isCoolingDown: false),
        loading: (s) => s.copyWith(isCoolingDown: false),
        success: (s) => s.copyWith(isCoolingDown: false),
        failure: (s) => s.copyWith(isCoolingDown: false),
      ),
    );
  }

  Future<void> _onSubmit(
    FeedbackSubmit event,
    Emitter<FeedbackState> emit,
  ) async {
    if (state.isCoolingDown) {
      await _tracker.logFeedbackCooldownHit();
      return;
    }

    _logger.info('Submitting feedback...');
    emit(FeedbackState.loading(isCoolingDown: state.isCoolingDown));

    final result = await _submitFeedbackUseCase(event.message);

    await result.fold(
      (failure) async {
        _logger.severe('Feedback submission failed: ${failure.errorMessage}');
        await _tracker.logFeedbackFailed(error: failure.errorMessage);
        emit(FeedbackState.failure(failure, isCoolingDown: true));
      },
      (_) async {
        _logger.info('Feedback submitted successfully');
        await _tracker.logFeedbackSubmitted(
          messageLength: event.message.length,
        );

        //TODO: Implement actual user profile integration
        await _tracker.setTotalFeedbackCount(1);

        emit(const FeedbackState.success(isCoolingDown: true));
        _startCooldownTimer();
      },
    );
  }

  void _startCooldownTimer() {
    _logger.info('Starting 5-second cooldown timer');
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer(const Duration(seconds: 5), () {
      add(const FeedbackEvent.cooldownEnded());
    });
  }
}
