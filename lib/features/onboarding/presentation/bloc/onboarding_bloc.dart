import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/get_sectors_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/get_sp500_history_usecase.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_event.dart';
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
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

export 'onboarding_event.dart';
export 'onboarding_state.dart';

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
  ) : super(const OnboardingState.initial()) {
    on<OnboardingStarted>(_onStarted, transformer: restartable());
    on<OnboardingNameSubmitted>(_onNameSubmitted);
    on<OnboardingSectorSelected>(_onSectorSelected);
    on<OnboardingExperienceSelected>(_onExperienceSelected);
    on<OnboardingCompletionRequested>(
      _onCompletionRequested,
      transformer: droppable(),
    );
    on<OnboardingSp500HistoryRequested>(
      _onSp500HistoryRequested,
      transformer: restartable(),
    );
    on<OnboardingStepViewed>(_onStepViewed);
    on<OnboardingSubscriptionStatusChanged>(_onSubscriptionStatusChanged);
    on<OnboardingBrandToggled>(_onBrandToggled);
    on<OnboardingAnalysisStarted>(_onAnalysisStarted);
    on<OnboardingAnalysisStepUpdated>(_onAnalysisStepUpdated);
    on<OnboardingWatchlistAdditionStarted>(_onWatchlistAdditionStarted);
    on<OnboardingWatchlistStepUpdated>(_onWatchlistStepUpdated);
    on<OnboardingHighlightPageChanged>(_onHighlightPageChanged);
    on<OnboardingHighlightContinuePressed>(_onHighlightContinuePressed);
    on<OnboardingHighlightSkipPressed>(_onHighlightSkipPressed);
    on<OnboardingNotificationsToggled>(_onNotificationsToggled);
    on<OnboardingProfileReadyPageViewed>(_onProfileReadyPageViewed);
    on<OnboardingLandingPageViewed>(_onLandingPageViewed);
    on<OnboardingLoginRequested>(_onLoginRequested);
    on<OnboardingFlowFinished>(_onOnboardingFlowFinished);
    on<OnboardingReset>(_onReset);
  }

  void _onLandingPageViewed(
    OnboardingLandingPageViewed event,
    Emitter<OnboardingState> emit,
  ) {
    add(const OnboardingEvent.stepViewed(OnboardingStep.landing));
  }

  Future<void> _onLoginRequested(
    OnboardingLoginRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    _stepStopwatch.stop();
    _logSessionSummary(exitStep: OnboardingStep.landing.name, didSignup: false);
  }

  void _onProfileReadyPageViewed(
    OnboardingProfileReadyPageViewed event,
    Emitter<OnboardingState> emit,
  ) {
    add(const OnboardingEvent.stepViewed(OnboardingStep.profileReady));
  }

  Future<void> _onNotificationsToggled(
    OnboardingNotificationsToggled event,
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
    OnboardingStepViewed event,
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

    final prevStep = state.lastStep;
    if (_isHighlightStep(prevStep) && _isHighlightStep(step)) {
      emit(state.copyWith(lastStep: step));
      return;
    }

    final prevDurationSec = _restartStepTimer(hadPrevStep: prevStep != null);
    _logStepViewed(
      step: step,
      prevStep: prevStep,
      prevDurationSec: prevDurationSec,
    );

    emit(state.copyWith(lastStep: step));
  }

  int? _restartStepTimer({required bool hadPrevStep}) {
    int? prevDurationSec;
    if (hadPrevStep) {
      _stepStopwatch.stop();
      prevDurationSec = _stepStopwatch.elapsed.inSeconds;
    }
    _stepStopwatch.reset();
    _stepStopwatch.start();
    return prevDurationSec;
  }

  void _logStepViewed({
    required OnboardingStep step,
    required OnboardingStep? prevStep,
    required int? prevDurationSec,
  }) {
    final data = state.onboardingData;
    final isPrevPaywall =
        prevStep == OnboardingStep.paywall ||
        prevStep == OnboardingStep.discountPaywall;
    final isPrevHighlight = _isHighlightStep(prevStep);

    _analytics.logStepViewed(
      step: step,
      prevDurationSec: prevDurationSec,
      selectedSector: prevStep == OnboardingStep.sectorSelection
          ? data.selectedSector?.name
          : null,
      brandsSelectedCount: prevStep == OnboardingStep.brandsSelection
          ? state.selectedBrands.length
          : null,
      experienceSelected: prevStep == OnboardingStep.investingExperience
          ? data.investingExperience?.name
          : null,
      notificationsEnabled: prevStep == OnboardingStep.notificationsPrompt
          ? data.notificationsEnabled
          : null,
      didSubscribe: isPrevPaywall ? state.didSubscribe : null,
      subscriptionType: isPrevPaywall ? state.subscriptionType : null,
      highlightsSkipped: isPrevHighlight ? state.highlightsSkipped : null,
    );
  }

  bool _isHighlightStep(OnboardingStep? step) {
    if (step == null) return false;
    return step == OnboardingStep.featureHighlights ||
        step == OnboardingStep.highlight1 ||
        step == OnboardingStep.highlight2 ||
        step == OnboardingStep.highlight3;
  }

  void _onSubscriptionStatusChanged(
    OnboardingSubscriptionStatusChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(
      state.copyWith(
        didSubscribe: event.didSubscribe,
        subscriptionType: event.subscriptionType,
      ),
    );
  }

  void _onBrandToggled(
    OnboardingBrandToggled event,
    Emitter<OnboardingState> emit,
  ) {
    final currentSelected = List<Brand>.from(state.selectedBrands);
    final index = currentSelected.indexWhere((b) => b.name == event.brand.name);

    if (index != -1) {
      currentSelected.removeAt(index);
    } else {
      currentSelected.add(event.brand);
    }

    emit(state.copyWith(selectedBrands: currentSelected));
  }

  Future<void> _onAnalysisStarted(
    OnboardingAnalysisStarted event,
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
    add(const OnboardingEvent.analysisStepUpdated(1));
    await Future.delayed(const Duration(milliseconds: 1000));
    if (isClosed) return;
    add(const OnboardingEvent.analysisStepUpdated(2));
    await Future.delayed(const Duration(milliseconds: 1000));
    if (isClosed) return;
    add(const OnboardingEvent.analysisStepUpdated(3));
  }

  void _onAnalysisStepUpdated(
    OnboardingAnalysisStepUpdated event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(analysisStep: event.step));
    if (event.step == 3) {
      emit(state.copyWith(isAnalyzingBrands: false));
    }
  }

  Future<void> _onWatchlistAdditionStarted(
    OnboardingWatchlistAdditionStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(watchlistStep: 0, isAnalyzingBrands: true));

    final count = state.onboardingData.detectedCompanies.length;
    for (int i = 0; i <= count; i++) {
      if (isClosed) return;
      add(OnboardingEvent.watchlistStepUpdated(i));
      if (i < count) {
        await Future.delayed(const Duration(milliseconds: 1000));
      }
    }
    await Future.delayed(const Duration(milliseconds: 500));
    if (isClosed) return;
    emit(state.copyWith(isAnalyzingBrands: false));
  }

  void _onWatchlistStepUpdated(
    OnboardingWatchlistStepUpdated event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(watchlistStep: event.step));
  }

  Future<void> _onSp500HistoryRequested(
    OnboardingSp500HistoryRequested event,
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

  Future<void> _onStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    _logger.info('Onboarding started');

    _analytics.resetUserProperties();
    _stepStopwatch.reset();

    emit(
      const OnboardingState.initial().copyWith(
        isLoadingSectors: true,
        sessionEntryTime: DateTime.now(),
        sessionId: IdUtils.generateSessionId(),
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
        emit(
          state.copyWith(
            isLoadingSectors: false,
            availableSectors: _toSectorViewModels(sectors),
          ),
        );
      },
    );

    add(const OnboardingEvent.sp500HistoryRequested());
  }

  List<SectorViewModel> _toSectorViewModels(List<Sector> sectors) {
    return sectors
        .map(
          (s) => SectorViewModel(
            sector: s,
            displayName: _sectorService.getSectorDisplayName(s.name),
            description: _sectorService.getSectorDescription(s.name),
          ),
        )
        .toList();
  }

  Future<void> _onNameSubmitted(
    OnboardingNameSubmitted event,
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
    OnboardingSectorSelected event,
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
    OnboardingExperienceSelected event,
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

  Future<void> _onCompletionRequested(
    OnboardingCompletionRequested event,
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
    Emitter<OnboardingState> emit,
  ) async {
    _logger.severe('Onboarding completion failed: $message');
    emit(
      state.copyWith(
        status: OnboardingStatus.failure,
        isSubmitting: false,
        failureMessage: message,
      ),
    );
    _analytics.logCompletionFailed(errorMessage: message);
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
    OnboardingFlowFinished event,
    Emitter<OnboardingState> emit,
  ) async {
    _logger.info(
      'Onboarding flow completely finished, logging session summary',
    );
    _logSessionSummary(exitStep: 'completed', didSignup: true);
  }

  Future<void> _onHighlightPageChanged(
    OnboardingHighlightPageChanged event,
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
    OnboardingHighlightContinuePressed event,
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
    OnboardingHighlightSkipPressed event,
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
    final sessionEntryTime = state.sessionEntryTime;
    if (state.sessionId.isEmpty || sessionEntryTime == null) return;

    final totalDuration = DateTime.now()
        .difference(sessionEntryTime)
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

  void _onReset(OnboardingReset event, Emitter<OnboardingState> emit) {
    _stepStopwatch.stop();
    _stepStopwatch.reset();
    _analytics.resetUserProperties();
    emit(const OnboardingState.initial());
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
