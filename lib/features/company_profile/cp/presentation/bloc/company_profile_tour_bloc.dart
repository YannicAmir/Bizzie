import 'dart:async';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream_usecase.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_analytics.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/cp/presentation/extensions/company_profile_tour_state_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyProfileTourBloc');

@injectable
class CompanyProfileTourBloc
    extends Bloc<CompanyProfileTourEvent, CompanyProfileTourState>
    with
        AuthSessionResetMixin<
          CompanyProfileTourEvent,
          CompanyProfileTourState
        > {
  static const revenueDataTimeout = Duration(seconds: 10);

  final CompanyProfileAnalytics _analytics;
  final _closing = Completer<void>();

  CompanyProfileTourBloc(this._analytics, GetAuthStreamUseCase getAuthStream)
    : super(const CompanyProfileTourState.initial()) {
    on<TourStarted>(_onStarted);
    on<TourStepCompleted>(_onStepCompleted);
    on<TourPreviousRequested>(_onPreviousRequested);
    on<TourRevenueTabSelected>(_onRevenueTabSelected, transformer: droppable());
    on<TourRevenueGrowthResolved>(_onRevenueGrowthResolved);
    on<TourTargetUnavailableReported>(_onTargetUnavailableReported);
    on<TourSkipRequested>(_onSkipRequested);
    on<TourReset>(_onReset);
    resetOnSessionEnd(getAuthStream, const CompanyProfileTourEvent.reset());
  }

  CompanyProfileTourActive? get _active => state.mapOrNull(active: (s) => s);

  void _onStarted(TourStarted event, Emitter<CompanyProfileTourState> emit) {
    final hasStarted = state.maybeMap(
      initial: (_) => false,
      orElse: () => true,
    );
    if (hasStarted) {
      _logger.info('Tour start ignored for ${event.ticker}, state: $state');
      return;
    }

    _logger.info('Tour started for ${event.ticker}');
    emit(
      CompanyProfileTourState.active(
        ticker: event.ticker,
        companyName: event.companyName,
        shouldPromptNotifications: event.shouldPromptNotifications,
        step: CompanyProfileTourStep.companyOverview,
      ),
    );
    unawaited(_analytics.logTourStarted(ticker: event.ticker));
    _logStepViewed(CompanyProfileTourStep.companyOverview);
  }

  void _onStepCompleted(
    TourStepCompleted event,
    Emitter<CompanyProfileTourState> emit,
  ) {
    final active = _active;
    if (active == null || active.isAwaitingRevenueData) return;
    if (active.step == CompanyProfileTourStep.revenueTab) return;

    _advance(emit, _withCurrentStepCompleted(active), active.step.next);
  }

  void _onPreviousRequested(
    TourPreviousRequested event,
    Emitter<CompanyProfileTourState> emit,
  ) {
    final active = _active;
    if (active == null || active.isAwaitingRevenueData) return;
    final previous = active.previousStep;
    if (previous == null) return;

    _logger.info('Tour stepped back from ${active.step.name}');
    emit(active.copyWith(step: previous));
    _logStepViewed(previous);
  }

  Future<void> _onRevenueTabSelected(
    TourRevenueTabSelected event,
    Emitter<CompanyProfileTourState> emit,
  ) async {
    final active = _active;
    if (active == null || active.step != CompanyProfileTourStep.revenueTab) {
      return;
    }

    emit(
      _withCurrentStepCompleted(active).copyWith(
        step: CompanyProfileTourStep.revenueGrowth,
        isAwaitingRevenueData: true,
      ),
    );

    await Future.any([
      Future<void>.delayed(revenueDataTimeout),
      _closing.future,
    ]);
    if (_closing.isCompleted) return;

    final current = _active;
    if (current == null || !current.isAwaitingRevenueData) return;
    _logger.info('Revenue data timed out, skipping revenue growth step');
    _advance(emit, current, CompanyProfileTourStep.stayUpdated);
  }

  void _onRevenueGrowthResolved(
    TourRevenueGrowthResolved event,
    Emitter<CompanyProfileTourState> emit,
  ) {
    final active = _active;
    if (active == null || !active.isAwaitingRevenueData) return;

    final growth = event.growth;
    if (growth == null) {
      _advance(emit, active, CompanyProfileTourStep.stayUpdated);
      return;
    }

    emit(active.copyWith(isAwaitingRevenueData: false, revenueGrowth: growth));
    _logStepViewed(CompanyProfileTourStep.revenueGrowth);
    unawaited(
      _analytics.logTourRevenueGrowthBandShown(
        band: growth.band,
        years: growth.years,
      ),
    );
  }

  void _onTargetUnavailableReported(
    TourTargetUnavailableReported event,
    Emitter<CompanyProfileTourState> emit,
  ) {
    final active = _active;
    if (active == null || active.isAwaitingRevenueData) return;

    final next = active.step == CompanyProfileTourStep.revenueTab
        ? CompanyProfileTourStep.stayUpdated
        : active.step.next;
    _logger.info('Tour step ${active.step.name} skipped, target unavailable');
    _advance(emit, active, next);
  }

  void _onSkipRequested(
    TourSkipRequested event,
    Emitter<CompanyProfileTourState> emit,
  ) {
    final active = _active;
    if (active == null) return;

    _logger.info('Tour skipped by user at step ${active.step.name}');
    emit(
      CompanyProfileTourState.finished(
        shouldPromptNotifications: active.shouldPromptNotifications,
        wasSkipped: true,
      ),
    );
    unawaited(_analytics.logTourSkipped(step: active.step));
  }

  void _onReset(TourReset event, Emitter<CompanyProfileTourState> emit) {
    _logger.info('Tour reset');
    emit(const CompanyProfileTourState.initial());
  }

  void _advance(
    Emitter<CompanyProfileTourState> emit,
    CompanyProfileTourActive active,
    CompanyProfileTourStep? next,
  ) {
    if (next == null) {
      _logger.info('Tour finished for ${active.ticker}');
      emit(
        CompanyProfileTourState.finished(
          shouldPromptNotifications: active.shouldPromptNotifications,
        ),
      );
      unawaited(_analytics.logTourCompleted(ticker: active.ticker));
      return;
    }

    emit(active.copyWith(step: next, isAwaitingRevenueData: false));
    _logStepViewed(next);
  }

  CompanyProfileTourActive _withCurrentStepCompleted(
    CompanyProfileTourActive active,
  ) => active.copyWith(completedSteps: {...active.completedSteps, active.step});

  void _logStepViewed(CompanyProfileTourStep step) {
    unawaited(_analytics.logTourStepViewed(step: step));
  }

  @override
  Future<void> close() {
    if (!_closing.isCompleted) _closing.complete();
    return super.close();
  }
}
