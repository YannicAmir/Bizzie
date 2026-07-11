import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';

import 'package:bizzie/features/onboarding/domain/usecases/get_sectors_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/get_sp500_history_usecase.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:bizzie/features/onboarding/presentation/models/feature_highlight_item.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_analytics.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_session_summary.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/core/enums/day_of_week.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/utils/id_utils.dart';
import 'package:bizzie/shared/models/sector_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

export 'onboarding_state.dart';

part 'onboarding_event.dart';
part 'onboarding_bloc.freezed.dart';

final _logger = BizzieLogger('OnboardingBloc');

@lazySingleton
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final IAuthRepository _authRepository;
  final CompleteOnboardingUseCase _completeOnboardingUseCase;

  final GetSectorsUseCase _getSectorsUseCase;
  final GetSp500HistoryUseCase _getSp500HistoryUseCase;
  final ISectorService _sectorService;
  final OnboardingAnalytics _analytics;
  final Stopwatch _stepStopwatch = Stopwatch();

  OnboardingBloc(
    this._authRepository,
    this._completeOnboardingUseCase,
    this._getSectorsUseCase,
    this._getSp500HistoryUseCase,
    this._sectorService,
    this._analytics,
  ) : super(OnboardingState.initial()) {
    on<_Started>(_onStarted);
    on<_NameSubmitted>(_onNameSubmitted);
    on<_SectorSelected>(_onSectorSelected);
    on<_ExperienceSelected>(_onExperienceSelected);
    on<_CompleteOnboarding>(_onCompleteOnboarding);
    on<_LoadSp500History>(_onLoadSp500History);
    on<_StepViewed>(_onStepViewed);
    on<SubscriptionStatusChanged>(_onSubscriptionStatusChanged);
    on<_ToggleBrand>(_onToggleBrand);
    on<_StartAnalysis>(_onStartAnalysis);
    on<_UpdateAnalysisStep>(_onUpdateAnalysisStep);
    on<_StartWatchlistAddition>(_onStartWatchlistAddition);
    on<_UpdateWatchlistStep>(_onUpdateWatchlistStep);
    on<_HighlightPageChanged>(_onHighlightPageChanged);
    on<_HighlightContinuePressed>(_onHighlightContinuePressed);
    on<_HighlightSkipPressed>(_onHighlightSkipPressed);
    on<_NotificationsToggled>(_onNotificationsToggled);
    on<_ProfileReadyPageViewed>(_onProfileReadyPageViewed);
    on<_ProfileReadyContinuePressed>(_onProfileReadyContinuePressed);
    on<_LandingPageViewed>(_onLandingPageViewed);
    on<_LoginRequested>(_onLoginRequested);
    on<_OnboardingFlowFinished>(_onOnboardingFlowFinished);
    on<_Reset>(_onReset);
  }

  void _onLandingPageViewed(
    _LandingPageViewed event,
    Emitter<OnboardingState> emit,
  ) {
    add(const OnboardingEvent.stepViewed(OnboardingStep.landing));
  }

  Future<void> _onLoginRequested(
    _LoginRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    _stepStopwatch.stop();
    _analytics.logStep(
      stepName: OnboardingStep.landing.name,
      durationSec: _stepStopwatch.elapsed.inSeconds,
    );

    _logSessionSummary(exitStep: OnboardingStep.landing.name, didSignup: false);
  }

  void _onProfileReadyPageViewed(
    _ProfileReadyPageViewed event,
    Emitter<OnboardingState> emit,
  ) {
    add(const OnboardingEvent.stepViewed(OnboardingStep.profileReady));
  }

  Future<void> _onProfileReadyContinuePressed(
    _ProfileReadyContinuePressed event,
    Emitter<OnboardingState> emit,
  ) async {
    _stepStopwatch.stop();
    _analytics.logStep(
      stepName: OnboardingStep.profileReady.name,
      durationSec: _stepStopwatch.elapsed.inSeconds,
    );
    _stepStopwatch.reset();
    _stepStopwatch.start();
  }

  Future<void> _onNotificationsToggled(
    _NotificationsToggled event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      state.copyWith(
        onboardingData: state.onboardingData.copyWith(
          notificationsEnabled: event.enabled,
        ),
      ),
    );
  }

  Future<void> _onStepViewed(
    _StepViewed event,
    Emitter<OnboardingState> emit,
  ) async {
    if (state.sessionId.isEmpty) {
      add(const OnboardingEvent.started());
    }
    final step = event.step;

    if (step == state.lastStep) {
      _logger.info('Skipping duration log for duplicate step: $step');
      return;
    }

    final isPrevHighlight = _isHighlightStep(state.lastStep);
    final isNewHighlight = _isHighlightStep(step);

    if (state.lastStep != null && !(isPrevHighlight && isNewHighlight)) {
      _stepStopwatch.stop();

      final extraParams = _getExtraParamsForStep(state.lastStep!);
      if (isPrevHighlight) {
        extraParams['skipped'] = state.highlightsSkipped;
      }

      _analytics.logStep(
        stepName: state.lastStep!.name,
        durationSec: _stepStopwatch.elapsed.inSeconds,
        extraParams: extraParams,
      );

      _stepStopwatch.reset();
      _stepStopwatch.start();
    } else if (state.lastStep == null) {
      _stepStopwatch.reset();
      _stepStopwatch.start();
    }

    emit(state.copyWith(lastStep: step));
  }

  bool _isHighlightStep(OnboardingStep? step) {
    if (step == null) return false;
    return step == OnboardingStep.highlight1 ||
        step == OnboardingStep.highlight2 ||
        step == OnboardingStep.highlight3;
  }

  void _onSubscriptionStatusChanged(
    SubscriptionStatusChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(
      state.copyWith(
        didSubscribe: event.didSubscribe,
        subscriptionType: event.subscriptionType,
      ),
    );
  }

  Map<String, Object> _getExtraParamsForStep(OnboardingStep step) {
    final params = <String, Object>{};
    final data = state.onboardingData;

    switch (step) {
      case OnboardingStep.sectorSelection:
        if (data.selectedSector != null) {
          params['selected_sector'] = data.selectedSector!.name;
        }
        break;
      case OnboardingStep.brandsSelection:
        params['brands_selected_count'] = state.selectedBrands.length;
        break;
      case OnboardingStep.investingExperience:
        if (data.investingExperience != null) {
          params['experience_selected'] = data.investingExperience!.name;
        }
        break;
      case OnboardingStep.notificationsPrompt:
        params['enabled_notifications'] = data.notificationsEnabled;
        break;
      case OnboardingStep.paywall:
      case OnboardingStep.discountPaywall:
        params['did_subscribe'] = state.didSubscribe;
        params['subscription_type'] = state.subscriptionType;
        break;
      default:
        break;
    }
    return params;
  }

  void _onToggleBrand(_ToggleBrand event, Emitter<OnboardingState> emit) {
    final currentSelected = List<Brand>.from(state.selectedBrands);
    final index = currentSelected.indexWhere((b) => b.name == event.brand.name);

    if (index != -1) {
      currentSelected.removeAt(index);
    } else {
      currentSelected.add(event.brand);
    }

    emit(state.copyWith(selectedBrands: currentSelected));
  }

  Future<void> _onStartAnalysis(
    _StartAnalysis event,
    Emitter<OnboardingState> emit,
  ) async {
    final detectedCompanies = state.selectedBrands
        .map((brand) => Company(ticker: brand.ticker, name: brand.company))
        .toSet()
        .toList();

    final newData = state.onboardingData.copyWith(
      detectedCompanies: detectedCompanies,
    );

    emit(
      state.copyWith(
        analysisStep: 0,
        isAnalyzingBrands: true,
        onboardingData: newData,
        featureHighlights: _calculateFeatureHighlights(newData),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 1000));
    if (isClosed) return;
    add(const OnboardingEvent.updateAnalysisStep(1));
    await Future.delayed(const Duration(milliseconds: 1000));
    if (isClosed) return;
    add(const OnboardingEvent.updateAnalysisStep(2));
    await Future.delayed(const Duration(milliseconds: 1000));
    if (isClosed) return;
    add(const OnboardingEvent.updateAnalysisStep(3));
  }

  void _onUpdateAnalysisStep(
    _UpdateAnalysisStep event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(analysisStep: event.step));
    if (event.step == 3) {
      emit(state.copyWith(isAnalyzingBrands: false));
    }
  }

  Future<void> _onStartWatchlistAddition(
    _StartWatchlistAddition event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(watchlistStep: 0, isAnalyzingBrands: true));

    final count = state.onboardingData.detectedCompanies.length;
    for (int i = 0; i <= count; i++) {
      if (isClosed) return;
      add(OnboardingEvent.updateWatchlistStep(i));
      if (i < count) {
        await Future.delayed(const Duration(milliseconds: 1000));
      }
    }
    await Future.delayed(const Duration(milliseconds: 500));
    if (isClosed) return;
    emit(state.copyWith(isAnalyzingBrands: false));
  }

  void _onUpdateWatchlistStep(
    _UpdateWatchlistStep event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(watchlistStep: event.step));
  }

  Future<void> _onLoadSp500History(
    _LoadSp500History event,
    Emitter<OnboardingState> emit,
  ) async {
    _logger.info('Loading S&P 500 history');
    emit(state.copyWith(isLoadingHistory: true));
    final result = await _getSp500HistoryUseCase(NoParams());
    result.fold(
      (failure) {
        _logger.warning('Failed to load S&P 500 history: ${failure.errorMessage}');
        emit(state.copyWith(isLoadingHistory: false));
      },
      (history) {
        _logger.info('Successfully loaded S&P 500 history');
        emit(state.copyWith(isLoadingHistory: false, sp500History: history));
      },
    );
  }

  Future<void> _onStarted(_Started event, Emitter<OnboardingState> emit) async {
    _logger.info('Onboarding started');

    _analytics.resetUserProperties();
    _stepStopwatch.reset();

    final sessionId = IdUtils.generateSessionId();
    final now = DateTime.now();

    emit(
      OnboardingState.initial().copyWith(
        isLoadingSectors: true,
        sessionEntryTime: now,
        sessionId: sessionId,
      ),
    );

    final result = await _getSectorsUseCase(NoParams());
    result.fold(
      (failure) {
        _logger.warning(
          'Failed to fetch available sectors: ${failure.errorMessage}',
        );
        emit(state.copyWith(isLoadingSectors: false));
      },
      (sectors) {
        _logger.info('Fetched ${sectors.length} sectors');
        final sectorViewModels = sectors
            .map(
              (s) => SectorViewModel(
                sector: s,
                displayName: _sectorService.getSectorDisplayName(s.name),
                description: _sectorService.getSectorDescription(s.name),
              ),
            )
            .toList();

        emit(
          state.copyWith(
            isLoadingSectors: false,
            availableSectors: sectorViewModels,
          ),
        );
      },
    );

    add(const OnboardingEvent.loadSp500History());
  }

  Future<void> _onNameSubmitted(
    _NameSubmitted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      state.copyWith(
        onboardingData: state.onboardingData.copyWith(firstName: event.name),
        currentStep: 2,
      ),
    );
  }

  Future<void> _onSectorSelected(
    _SectorSelected event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      state.copyWith(
        onboardingData: state.onboardingData.copyWith(
          selectedSector: event.sector,
        ),
      ),
    );
  }

  Future<void> _onExperienceSelected(
    _ExperienceSelected event,
    Emitter<OnboardingState> emit,
  ) async {
    final newData = state.onboardingData.copyWith(
      investingExperience: event.experience,
    );
    emit(
      state.copyWith(
        onboardingData: newData,
        featureHighlights: _calculateFeatureHighlights(newData),
        currentHighlightIndex: 0,
      ),
    );
  }

  Future<void> _onCompleteOnboarding(
    _CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, failureMessage: null));

    final currentUser = _authRepository.currentUser;
    if (currentUser == null) {
      return _handleCompletionError('User is not authenticated', emit);
    }

    final result = await _completeOnboardingUseCase(
      CompleteOnboardingParams(data: state.onboardingData, uid: currentUser.id),
    );

    await result.fold(
      (failure) => _handleCompletionError(failure.errorMessage, emit),
      (_) => _handleCompletionSuccess(emit),
    );
  }

  Future<void> _handleCompletionError(
    String message,
    Emitter<OnboardingState> emit, {
    String stepName = 'complete_onboarding',
  }) async {
    _logger.severe('Onboarding completion failed: $message');
    emit(
      state.copyWith(
        status: OnboardingStatus.failure,
        isSubmitting: false,
        failureMessage: message,
      ),
    );
    _analytics.logStep(stepName: stepName, errorMessage: message);
  }

  Future<void> _handleCompletionSuccess(Emitter<OnboardingState> emit) async {
    _logger.info('Onboarding completion successful');
    final data = state.onboardingData;

    final user = _authRepository.currentUser;
    String method = 'email';
    if (user != null && user.providers.isNotEmpty) {
      final provider = user.providers.first.toLowerCase();
      if (provider.contains('google')) {
        method = 'google';
      } else if (provider.contains('apple')) {
        method = 'apple';
      }
    }
    _analytics.logSignUp(method: method);

    if (data.investingExperience != null && data.selectedSector != null) {
      _analytics.setUserProperties(
        experience: data.investingExperience!.name,
        sector: data.selectedSector!.name,
      );
    }

    emit(state.copyWith(status: OnboardingStatus.success, isSubmitting: false));
  }

  Future<void> _onOnboardingFlowFinished(
    _OnboardingFlowFinished event,
    Emitter<OnboardingState> emit,
  ) async {
    _logger.info(
      'Onboarding flow completely finished, logging session summary',
    );
    _logSessionSummary(exitStep: 'completed', didSignup: true);
  }

  Future<void> _onHighlightPageChanged(
    _HighlightPageChanged event,
    Emitter<OnboardingState> emit,
  ) async {
    final nextHighlightStep = _getHighlightStep(event.index);

    emit(
      state.copyWith(
        currentHighlightIndex: event.index,
        lastStep: nextHighlightStep,
      ),
    );
  }

  OnboardingStep _getHighlightStep(int index) {
    switch (index) {
      case 0:
        return OnboardingStep.highlight1;
      case 1:
        return OnboardingStep.highlight2;
      case 2:
        return OnboardingStep.highlight3;
      default:
        return OnboardingStep.highlight1;
    }
  }

  void _onHighlightContinuePressed(
    _HighlightContinuePressed event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.currentHighlightIndex < state.featureHighlights.length - 1) {
      emit(
        state.copyWith(currentHighlightIndex: state.currentHighlightIndex + 1),
      );
    } else {
      emit(state.copyWith(highlightsSkipped: false));
      final hasUser = _authRepository.currentUser != null;

      if (hasUser) {
        emit(state.copyWith(shouldNavigateToBuildingProfile: true));
        emit(state.copyWith(shouldNavigateToBuildingProfile: false));
      } else {
        emit(state.copyWith(shouldNavigateToCreateAccount: true));
        emit(state.copyWith(shouldNavigateToCreateAccount: false));
      }
    }
  }

  Future<void> _onHighlightSkipPressed(
    _HighlightSkipPressed event,
    Emitter<OnboardingState> emit,
  ) async {
    final hasUser = _authRepository.currentUser != null;
    emit(
      state.copyWith(
        highlightsSkipped: true,
        shouldNavigateToBuildingProfile: hasUser,
      ),
    );

    if (hasUser) {
      emit(state.copyWith(shouldNavigateToBuildingProfile: false));
    } else {
      emit(state.copyWith(shouldNavigateToCreateAccount: true));
      emit(state.copyWith(shouldNavigateToCreateAccount: false));
    }
  }

  void _logSessionSummary({required String exitStep, bool didSignup = false}) {
    if (state.sessionId.isEmpty) return;

    final totalDuration = DateTime.now()
        .difference(state.sessionEntryTime)
        .inSeconds;

    _analytics.logSessionSummary(
      OnboardingSessionSummary(
        sessionId: state.sessionId,
        exitStep: exitStep,
        totalDurationSeconds: totalDuration,
        addedBrandsCount: state.selectedBrands.length,
        notificationsEnabled: state.onboardingData.notificationsEnabled,
        highlightsSkipped: state.highlightsSkipped,
        didSignup: didSignup,
        sector: state.onboardingData.selectedSector?.name,
        experience: state.onboardingData.investingExperience?.name,
        dayOfWeek: DayOfWeek.fromDateTime(DateTime.now()),
      ),
    );
  }

  void _onReset(_Reset event, Emitter<OnboardingState> emit) {
    _stepStopwatch.stop();
    _stepStopwatch.reset();
    _analytics.resetUserProperties();
    emit(OnboardingState.initial());
  }

  @override
  Future<void> close() {
    if (state.status != OnboardingStatus.success) {
      _logSessionSummary(
        exitStep: state.lastStep?.name ?? 'unknown',
        didSignup: false,
      );
    }
    return super.close();
  }

  List<FeatureHighlightItem> _calculateFeatureHighlights(OnboardingData data) {
    final experience = data.investingExperience;
    final company = data.detectedCompanies.firstOrNull?.name ?? 'Apple';

    List<FeatureHighlightItem> items;
    switch (experience) {
      case InvestingExperience.expert:
        items = [
          FeatureHighlightItem(
            title: 'Expert investors will love',
            description:
                'View the full financial history of $company and other companies',
            type: FeatureHighlightType.historicalData,
          ),
          FeatureHighlightItem(
            title: 'Expert investors will love',
            description:
                'Never miss quarterly or annual report releases from your watchlist',
            type: FeatureHighlightType.financialReportAlerts,
          ),
          FeatureHighlightItem(
            title: 'Expert investors will love',
            description:
                'Deep dive into 10-K and 10-Q reports with AI-powered summaries',
            type: FeatureHighlightType.summaryIllustration,
          ),
        ];
        break;
      case InvestingExperience.intermediate:
        items = [
          FeatureHighlightItem(
            title: 'Experienced investors will love',
            description:
                'Visualize Apple and other company financials at a glance',
            type: FeatureHighlightType.visualFinancials,
          ),
          FeatureHighlightItem(
            title: 'Experienced investors will love',
            description:
                'Easily find stocks by searching for your favorite brands',
            type: FeatureHighlightType.brandSearch,
          ),
          FeatureHighlightItem(
            title: 'Experienced investors will love',
            description:
                'Bizzie analyzes full reports and summarizes with quick insights',
            type: FeatureHighlightType.summaryIllustration,
          ),
        ];
        break;
      case InvestingExperience.beginner:
      default:
        items = [
          FeatureHighlightItem(
            title: 'Beginners will love',
            description: 'Bizzie makes complex topics easy to understand',
            type: FeatureHighlightType.easyToUnderstand,
          ),
          FeatureHighlightItem(
            title: 'Beginners will love',
            description:
                'Easily find stocks by searching for your favorite brands & products',
            type: FeatureHighlightType.brandSearch,
          ),
          FeatureHighlightItem(
            title: 'Beginners will love',
            description:
                'Visualize Apple and other company financials at a glance',
            type: FeatureHighlightType.visualFinancials,
          ),
        ];
        break;
    }
    return items;
  }
}
