import 'dart:async';
import 'package:bizzie/features/feedback/domain/usecases/submit_feedback_usecase.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_event.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('FeedbackBloc');

@injectable
class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final SubmitFeedbackUseCase _submitFeedbackUseCase;

  Timer? _cooldownTimer;

  FeedbackBloc(this._submitFeedbackUseCase)
    : super(const FeedbackState.initial()) {
    on<Submit>(_onSubmit);
    on<MessageChanged>(_onMessageChanged);
    on<CooldownEnded>(_onCooldownEnded);
  }

  @override
  Future<void> close() {
    _cooldownTimer?.cancel();
    return super.close();
  }

  void _onMessageChanged(MessageChanged event, Emitter<FeedbackState> emit) {
    state.maybeMap(
      failure: (s) =>
          emit(FeedbackState.initial(isCoolingDown: s.isCoolingDown)),
      orElse: () {},
    );
  }

  void _onCooldownEnded(CooldownEnded event, Emitter<FeedbackState> emit) {
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

  Future<void> _onSubmit(Submit event, Emitter<FeedbackState> emit) async {
    _logger.info('Submitting feedback...');
    emit(FeedbackState.loading(isCoolingDown: state.isCoolingDown));

    final result = await _submitFeedbackUseCase(event.message);

    result.fold(
      (failure) {
        _logger.severe('Feedback submission failed: ${failure.message}');
        emit(FeedbackState.failure(failure, isCoolingDown: true));
      },
      (_) {
        _logger.info('Feedback submitted successfully');
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
