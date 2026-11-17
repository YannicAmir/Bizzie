import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_anonymously_usecase.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_save_outcome.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/save_onboarding_progress_result.dart';
import 'package:bizzie/features/onboarding/domain/models/skip_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/skip_onboarding_result.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/get_daily_brands_params.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/usecases/get_daily_brands_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/get_sectors_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/get_sp500_history_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/persist_notification_grant_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/save_onboarding_progress_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/skip_onboarding_usecase.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:bizzie/features/onboarding/presentation/models/feature_highlight_item.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_analytics.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_session_summary.dart';
import 'package:bizzie/features/onboarding/presentation/extensions/onboarding_state_x.dart';
import 'package:bizzie/features/onboarding/presentation/extensions/onboarding_step_x.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/core/enums/day_of_week.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/utils/id_utils.dart';
import 'package:bizzie/shared/models/sector_view_model.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

export 'onboarding_event.dart';
export 'onboarding_state.dart';

final _logger = BizzieLogger('OnboardingBloc');

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetCurrentUserUseCase _getCurrentUser;
  final GetAuthStreamUseCase _getAuthStream;
  final CompleteOnboardingUseCase _completeOnboardingUseCase;
  final SkipOnboardingUseCase _skipOnboardingUseCase;
  final SaveOnboardingProgressUseCase _saveOnboardingProgressUseCase;
  final SignInAnonymouslyUseCase _signInAnonymously;
  final PersistNotificationGrantUseCase _persistNotificationGrantUseCase;

  final GetSectorsUseCase _getSectorsUseCase;
  final GetSp500HistoryUseCase _getSp500HistoryUseCase;
  final GetDailyBrandsUseCase _getDailyBrandsUseCase;
  final ISectorService _sectorService;
  final OnboardingAnalytics _analytics;
  final Stopwatch _stepStopwatch = Stopwatch();
  Future<Either<Failure, UserModel>>? _pendingGuestSignIn;
  Future<bool>? _pendingProgressSave;

  OnboardingBloc(
    this._getCurrentUser,
    this._getAuthStream,
    this._completeOnboardingUseCase,
    this._skipOnboardingUseCase,
    this._saveOnboardingProgressUseCase,
    this._signInAnonymously,
    this._persistNotificationGrantUseCase,
    this._getSectorsUseCase,
    this._getSp500HistoryUseCase,
    this._getDailyBrandsUseCase,
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
    on<OnboardingBuildingProfileStarted>(
      _onBuildingProfileStarted,
      transformer: droppable(),
    );
    on<OnboardingSkipRequested>(_onSkipRequested, transformer: droppable());
    on<OnboardingNotificationGrantPersistRequested>(
      _onNotificationGrantPersistRequested,
      transformer: droppable(),
    );
    on<OnboardingSp500HistoryRequested>(
      _onSp500HistoryRequested,
      transformer: restartable(),
    );
    on<OnboardingInitialCompanyShown>(_onInitialCompanyShown);
    on<OnboardingStepViewed>(_onStepViewed);
    on<OnboardingSubscriptionStatusChanged>(_onSubscriptionStatusChanged);
    on<OnboardingBrandToggled>(_onBrandToggled);
    on<OnboardingGuestSessionRequested>(
      _onGuestSessionRequested,
      transformer: droppable(),
    );
    on<OnboardingBrandsConfirmed>(_onBrandsConfirmed, transformer: droppable());
    on<OnboardingBrandsPrefetchRequested>(
      _onBrandsPrefetchRequested,
      transformer: restartable(),
    );
    on<OnboardingHighlightPageChanged>(_onHighlightPageChanged);
    on<OnboardingHighlightContinuePressed>(_onHighlightContinuePressed);
    on<OnboardingNotificationsToggled>(_onNotificationsToggled);
    on<OnboardingLoginRequested>(_onLoginRequested);
    on<OnboardingFlowFinished>(_onOnboardingFlowFinished);
    on<OnboardingReset>(_onReset);
  }

  Future<void> _onLoginRequested(
    OnboardingLoginRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    _stepStopwatch.stop();
    _logSessionSummary(
      exitStep: OnboardingStep.landing.analyticsName,
      didSignup: false,
    );
  }

  Future<void> _onNotificationsToggled(
    OnboardingNotificationsToggled event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      state.copyWith(
        onboardingData: state.onboardingData.copyWith(
          notificationsEnabled: event.enabled,
          hasDecidedNotifications: true,
        ),
      ),
    );
  }

  Future<void> _onStepViewed(
    OnboardingStepViewed event,
    Emitter<OnboardingState> emit,
  ) async {
    _ensureSessionStarted();
    final step = event.step;
    final prevStep = state.lastStep;

    if (step == prevStep) {
      _logger.info('Skipping duration log for duplicate step: $step');
      return;
    }

    if (_isHighlightTransition(prevStep, step)) {
      emit(state.copyWith(lastStep: step));
      return;
    }

    _trackStepTransition(step: step, prevStep: prevStep);
    emit(
      state.copyWith(
        lastStep: step,
        hasViewedCompanyProfile:
            state.hasViewedCompanyProfile ||
            step == OnboardingStep.companyProfile,
      ),
    );
  }

  void _ensureSessionStarted() {
    if (state.sessionId.isEmpty) add(const OnboardingEvent.started());
  }

  bool _isHighlightTransition(OnboardingStep? prevStep, OnboardingStep step) =>
      _isHighlightStep(prevStep) && _isHighlightStep(step);

  void _trackStepTransition({
    required OnboardingStep step,
    required OnboardingStep? prevStep,
  }) {
    final prevDurationSec = _restartStepTimer(hadPrevStep: prevStep != null);
    _logStepViewed(
      step: step,
      prevStep: prevStep,
      prevDurationSec: prevDurationSec,
    );
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

  Future<void> _onGuestSessionRequested(
    OnboardingGuestSessionRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    if (_getCurrentUser() != null) return;

    final signIn = _signInAnonymously(NoParams());
    _pendingGuestSignIn = signIn;
    final result = await signIn;
    result.fold(
      (failure) => _logger.warning(
        'Background guest sign-in failed: ${failure.errorMessage}',
      ),
      (user) => _logger.info('Background guest sign-in succeeded'),
    );
  }

  Future<void> _awaitPendingGuestSignIn() async {
    final pendingSignIn = _pendingGuestSignIn;
    if (pendingSignIn != null) await pendingSignIn;
  }

  Future<void> _onBrandsConfirmed(
    OnboardingBrandsConfirmed event,
    Emitter<OnboardingState> emit,
  ) async {
    final data = _withSelectedBrandCompanies(state.onboardingData);
    emit(
      state.copyWith(
        onboardingData: data,
        featureHighlights: _calculateFeatureHighlights(data),
      ),
    );

    await _awaitPendingGuestSignIn();
    final progressSave = _saveProgress(data, emit);
    _pendingProgressSave = progressSave;
    final isSaved = await progressSave;
    if (isSaved) await _persistNotificationGrant();
  }

  Future<bool> _saveProgress(
    OnboardingData data,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await _saveOnboardingProgressUseCase(data);
    return result.fold(
      (failure) {
        _logger.warning(
          'Failed to save onboarding progress: ${failure.errorMessage}',
        );
        return false;
      },
      (progress) {
        switch (progress) {
          case SaveOnboardingProgressSaved(:final uid):
            _logger.info('Onboarding progress saved');
            emit(state.copyWith(savedProfileUid: uid));
            return true;
          case SaveOnboardingProgressExistingProfile():
            _logger.info(
              'Existing profile found; onboarding progress not saved',
            );
            return false;
        }
      },
    );
  }

  Future<void> _awaitPendingProgressSave() async {
    final pendingSave = _pendingProgressSave;
    if (pendingSave != null) await pendingSave;
  }

  bool _hasSavedProfileFor(String? uid) =>
      uid != null && uid == state.savedProfileUid;

  List<Company> _companiesFromBrands(List<Brand> brands) {
    return brands
        .map((brand) => Company(ticker: brand.ticker, name: brand.company))
        .toSet()
        .toList();
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
        _logger.warning(
          'Failed to load S&P 500 history: ${failure.errorMessage}',
        );
        emit(state.copyWith(isLoadingHistory: false));
      },
      (history) {
        _logger.info('Successfully loaded S&P 500 history');
        emit(state.copyWith(isLoadingHistory: false, sp500History: history));
      },
    );
  }

  Future<void> _onBrandsPrefetchRequested(
    OnboardingBrandsPrefetchRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await _getDailyBrandsUseCase(
      GetDailyBrandsParams(sector: state.onboardingData.selectedSector),
    );
    result.fold(
      (failure) => _logger.warning(
        'Failed to prefetch daily brands: ${failure.errorMessage}',
      ),
      (_) => _logger.info('Prefetched daily brands'),
    );
  }

  Future<void> _onStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    _startSession(emit);

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

  void _startSession(Emitter<OnboardingState> emit) {
    _logger.info('Onboarding started');
    _analytics.resetUserProperties();
    _stepStopwatch.reset();
    emit(
      const OnboardingState.initial().copyWith(
        lastStep: state.lastStep,
        hasViewedCompanyProfile: state.hasViewedCompanyProfile,
        isLoadingSectors: true,
        sessionEntryTime: DateTime.now(),
        sessionId: IdUtils.generateSessionId(),
      ),
    );
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
  ) => _completeOnboarding(emit);

  Future<void> _onBuildingProfileStarted(
    OnboardingBuildingProfileStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    final isAuthenticated = await _awaitAuthenticatedUser();
    if (!isAuthenticated) return;
    await _completeOnboarding(emit);
  }

  Future<bool> _awaitAuthenticatedUser() async {
    if (_getCurrentUser() != null) return true;
    try {
      final user = await _getAuthStream(
        NoParams(),
      ).firstWhere((user) => user != null, orElse: () => null);
      return user != null;
    } on ServerException catch (error) {
      _logger.warning('Auth stream failed awaiting sign-in: ${error.message}');
      return false;
    }
  }

  Future<void> _completeOnboarding(Emitter<OnboardingState> emit) async {
    emit(state.copyWith(isSubmitting: true, failureMessage: null));

    await _awaitPendingProgressSave();
    final currentUser = _getCurrentUser();
    if (currentUser == null) {
      return _handleCompletionError('User is not authenticated', emit);
    }

    final result = await _completeOnboardingUseCase(
      CompleteOnboardingParams(
        data: state.onboardingData,
        uid: currentUser.id,
        hasExistingProfile: _hasSavedProfileFor(currentUser.id),
      ),
    );

    await result.fold(
      (failure) => _handleCompletionError(failure.errorMessage, emit),
      (outcome) => switch (outcome) {
        OnboardingSaveOutcome.saved => _handleCompletionSuccess(emit),
        OnboardingSaveOutcome.existingProfile => _handleExistingProfile(emit),
      },
    );
  }

  Future<void> _handleExistingProfile(Emitter<OnboardingState> emit) async {
    _logger.info('Existing profile found; leaving onboarding without saving');
    emit(
      state.copyWith(
        status: OnboardingStatus.existingProfile,
        isSubmitting: false,
      ),
    );
    _logSessionSummary(exitStep: OnboardingStep.buildingProfile.analyticsName);
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

    _logSignUpForRegisteredUser();

    if (data.investingExperience != null && data.selectedSector != null) {
      _analytics.setUserProperties(
        experience: data.investingExperience!.name,
        sector: data.selectedSector!.name,
      );
    }

    emit(state.copyWith(status: OnboardingStatus.success, isSubmitting: false));
  }

  void _logSignUpForRegisteredUser() {
    final user = _getCurrentUser();
    if (user != null && user.isAnonymous) return;
    _analytics.logSignUp(method: _signUpMethod(user));
  }

  String _signUpMethod(UserModel? user) {
    if (user == null || user.providers.isEmpty) return 'email';
    final provider = user.providers.first.toLowerCase();
    if (provider.contains('google')) return 'google';
    if (provider.contains('apple')) return 'apple';
    return 'email';
  }

  Future<void> _onSkipRequested(
    OnboardingSkipRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    final data = _withSelectedBrandCompanies(state.onboardingData);
    final hadAccount = _getCurrentUser() != null;
    emit(
      state.copyWith(
        onboardingData: data,
        skipStatus: OnboardingSkipStatus.inProgress,
        failureMessage: null,
      ),
    );

    final result = await _skipOnboarding(data);
    result.fold(
      (failure) => _handleSkipError(failure.errorMessage, emit),
      (skipResult) => switch (skipResult) {
        SkipOnboardingCompleted() => _handleSkipSuccess(
          event,
          skipResult,
          hadAccount,
          emit,
        ),
        SkipOnboardingExistingProfile() => _handleSkipExistingProfile(
          event.step,
          emit,
        ),
      },
    );
  }

  Future<Either<Failure, SkipOnboardingResult>> _skipOnboarding(
    OnboardingData data,
  ) async {
    await _awaitPendingGuestSignIn();
    await _awaitPendingProgressSave();
    return _skipOnboardingUseCase(
      SkipOnboardingParams(
        data: data,
        hasExistingProfile: _hasSavedProfileFor(_getCurrentUser()?.id),
      ),
    );
  }

  void _handleSkipExistingProfile(
    OnboardingStep step,
    Emitter<OnboardingState> emit,
  ) {
    _logger.info(
      'Existing profile found; skipping at ${step.name} without saving',
    );
    emit(state.copyWith(skipStatus: OnboardingSkipStatus.existingProfile));
    _logSessionSummary(exitStep: step.analyticsName);
  }

  OnboardingData _withSelectedBrandCompanies(OnboardingData data) {
    if (state.selectedBrands.isEmpty) return data;
    return data.copyWith(
      detectedCompanies: _companiesFromBrands(state.selectedBrands),
    );
  }

  void _handleSkipError(String message, Emitter<OnboardingState> emit) {
    _logger.severe('Onboarding skip failed: $message');
    emit(
      state.copyWith(
        skipStatus: OnboardingSkipStatus.failure,
        failureMessage: message,
      ),
    );
  }

  void _handleSkipSuccess(
    OnboardingSkipRequested event,
    SkipOnboardingCompleted result,
    bool hadAccount,
    Emitter<OnboardingState> emit,
  ) {
    final step = event.step;
    _logger.info('Onboarding skipped at step: ${step.name}');
    emit(
      state.copyWith(
        skipStatus: OnboardingSkipStatus.success,
        skippedAtStep: step,
        skipFieldSources: result.fieldSources,
        postOnboardingDestination: result.destination,
      ),
    );
    emit(state.copyWith(postOnboardingDestination: null));
    _logSkipped(event, result, hadAccount);
  }

  void _logSkipped(
    OnboardingSkipRequested event,
    SkipOnboardingCompleted result,
    bool hadAccount,
  ) {
    final step = event.step;
    _analytics.logSkipped(
      step: step,
      reason: event.reason,
      sessionId: state.sessionId,
      hadAccount: hadAccount,
      brandsSelectedCount: state.selectedBrands.length,
      fieldSources: result.fieldSources,
      notificationsDecided: state.onboardingData.hasDecidedNotifications,
    );
    final user = _getCurrentUser();
    _logSessionSummary(
      exitStep: step.analyticsName,
      didSignup: user != null && !user.isAnonymous,
    );
  }

  void _onInitialCompanyShown(
    OnboardingInitialCompanyShown event,
    Emitter<OnboardingState> emit,
  ) {
    _analytics.logInitialCompanyShown(
      ticker: event.destination.ticker,
      tickerSource: event.destination.tickerSource,
      isSkipped: state.skippedAtStep != null,
      isGuest: _getCurrentUser()?.isAnonymous ?? false,
    );
  }

  Future<void> _onNotificationGrantPersistRequested(
    OnboardingNotificationGrantPersistRequested event,
    Emitter<OnboardingState> emit,
  ) => _persistNotificationGrant();

  Future<void> _persistNotificationGrant() async {
    final result = await _persistNotificationGrantUseCase(NoParams());
    result.fold(
      (failure) => _logger.warning(
        'Failed to persist notification grant: ${failure.errorMessage}',
      ),
      (isPersisted) =>
          _logger.info('Notification grant persisted: $isPersisted'),
    );
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
    if (!state.isOnLastHighlight) {
      emit(
        state.copyWith(currentHighlightIndex: state.currentHighlightIndex + 1),
      );
    } else {
      if (_isRegisteredUser()) {
        emit(state.copyWith(shouldNavigateToBuildingProfile: true));
        emit(state.copyWith(shouldNavigateToBuildingProfile: false));
      } else {
        emit(state.copyWith(shouldNavigateToCreateAccount: true));
        emit(state.copyWith(shouldNavigateToCreateAccount: false));
      }
    }
  }

  bool _isRegisteredUser() {
    final user = _getCurrentUser();
    return user != null && !user.isAnonymous;
  }

  void _logSessionSummary({required String exitStep, bool didSignup = false}) {
    final sessionEntryTime = state.sessionEntryTime;
    if (state.sessionId.isEmpty || sessionEntryTime == null) return;
    final skippedAtStep = state.skippedAtStep;

    final totalDuration = DateTime.now().difference(sessionEntryTime).inSeconds;

    _analytics.logSessionSummary(
      OnboardingSessionSummary(
        sessionId: state.sessionId,
        exitStep: skippedAtStep != null
            ? 'skipped_${skippedAtStep.analyticsName}'
            : exitStep,
        totalDurationSeconds: totalDuration,
        addedBrandsCount: state.selectedBrands.length,
        notificationsEnabled: state.onboardingData.notificationsEnabled,
        didSignup: didSignup,
        didSkip: skippedAtStep != null,
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
    _pendingGuestSignIn = null;
    _pendingProgressSave = null;
    emit(const OnboardingState.initial());
  }

  @override
  Future<void> close() {
    const terminalStatuses = {
      OnboardingStatus.success,
      OnboardingStatus.existingProfile,
    };
    const terminalSkipStatuses = {
      OnboardingSkipStatus.success,
      OnboardingSkipStatus.existingProfile,
    };
    if (!terminalStatuses.contains(state.status) &&
        !terminalSkipStatuses.contains(state.skipStatus)) {
      _logSessionSummary(
        exitStep: state.lastStep?.analyticsName ?? 'unknown',
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
                'Visualize $company and other company financials at a glance',
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
                'Visualize $company and other company financials at a glance',
            type: FeatureHighlightType.visualFinancials,
          ),
        ];
        break;
    }
    return items;
  }
}
