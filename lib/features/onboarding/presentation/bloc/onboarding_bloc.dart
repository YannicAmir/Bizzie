import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:bizzie/features/onboarding/presentation/models/feature_highlight_item.dart';
export 'package:bizzie/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_event.dart';
part 'onboarding_bloc.freezed.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final IOnboardingRepository _repository;
  final IAuthRepository _authRepository;
  final _logger = BizzieLogger('OnboardingBloc');

  OnboardingBloc(this._repository, this._authRepository)
    : super(OnboardingState.initial()) {
    on<_Started>(_onStarted);
    on<_NameSubmitted>(_onNameSubmitted);
    on<_SectorSelected>(_onSectorSelected);
    on<_ExperienceSelected>(_onExperienceSelected);
    on<_CompleteOnboarding>(_onCompleteOnboarding);
    on<_LoadSp500History>(_onLoadSp500History);
    on<_LoadBrands>(_onLoadBrands);
    on<_ToggleBrand>(_onToggleBrand);
    on<_StartAnalysis>(_onStartAnalysis);
    on<_UpdateAnalysisStep>(_onUpdateAnalysisStep);
    on<_StartWatchlistAddition>(_onStartWatchlistAddition);
    on<_UpdateWatchlistStep>(_onUpdateWatchlistStep);
    on<_HighlightPageChanged>(_onHighlightPageChanged);
    on<_HighlightContinuePressed>(_onHighlightContinuePressed);
    on<_HighlightSkipPressed>(_onHighlightSkipPressed);
  }

  Future<void> _onLoadBrands(
    _LoadBrands event,
    Emitter<OnboardingState> emit,
  ) async {
    _logger.info('DEBUG: OnboardingBloc _onLoadBrands STARTED');
    try {
      final (global, sector) = await _repository.getDailyBrands(
        state.onboardingData.selectedSector,
      );
      _logger.info(
        'DEBUG: Bloc loadBrands result - Global: ${global.length}, Sector: ${sector.length}',
      );
      emit(state.copyWith(globalBrands: global, sectorBrands: sector));
    } catch (e, stack) {
      _logger.severe('DEBUG: OnboardingBloc _onLoadBrands ERROR', e, stack);
    }
  }

  void _onToggleBrand(_ToggleBrand event, Emitter<OnboardingState> emit) {
    final currentSelected = List<Brand>.from(state.selectedBrands);
    if (currentSelected.contains(event.brand)) {
      currentSelected.remove(event.brand);
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

    await Future.delayed(const Duration(milliseconds: 1500));
    if (isClosed) return;
    add(const OnboardingEvent.updateAnalysisStep(1));
    await Future.delayed(const Duration(milliseconds: 1500));
    if (isClosed) return;
    add(const OnboardingEvent.updateAnalysisStep(2));
    await Future.delayed(const Duration(milliseconds: 1500));
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
        await Future.delayed(const Duration(milliseconds: 1500));
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
    emit(state.copyWith(isLoadingHistory: true));
    try {
      final history = await _repository.getSp500History();
      emit(state.copyWith(isLoadingHistory: false, sp500History: history));
    } catch (e) {
      // Handle error gracefully, maybe show a snackbar or retry button
      // For now, just stop loading
      emit(state.copyWith(isLoadingHistory: false));
    }
  }

  Future<void> _onStarted(_Started event, Emitter<OnboardingState> emit) async {
    add(const OnboardingEvent.loadSp500History());

    emit(state.copyWith(isLoadingSectors: true));
    try {
      final sectors = await _repository.getSectors();
      emit(state.copyWith(isLoadingSectors: false, availableSectors: sectors));
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingSectors: false,
          // In prod, might handle error state explicitly,
          // for now just fallback to empty list or retriable state
        ),
      );
    }
  }

  void _onNameSubmitted(_NameSubmitted event, Emitter<OnboardingState> emit) {
    emit(
      state.copyWith(
        onboardingData: state.onboardingData.copyWith(firstName: event.name),
        currentStep: 2,
      ),
    );
  }

  void _onSectorSelected(_SectorSelected event, Emitter<OnboardingState> emit) {
    emit(
      state.copyWith(
        onboardingData: state.onboardingData.copyWith(
          selectedSector: event.sector,
        ),
      ),
    );
  }

  void _onExperienceSelected(
    _ExperienceSelected event,
    Emitter<OnboardingState> emit,
  ) {
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

    try {
      final currentUser = _authRepository.currentUser;
      if (currentUser == null) {
        throw Exception('User is not authenticated');
      }

      await _repository.completeOnboarding(
        data: state.onboardingData,
        uid: currentUser.id,
      );
      emit(
        state.copyWith(status: OnboardingStatus.success, isSubmitting: false),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OnboardingStatus.failure,
          isSubmitting: false,
          failureMessage: e.toString(),
        ),
      );
    }
  }

  void _onHighlightPageChanged(
    _HighlightPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(currentHighlightIndex: event.index));
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
      final hasUser = _authRepository.currentUser != null;

      if (hasUser) {
        add(const OnboardingEvent.completeOnboarding());
        emit(state.copyWith(shouldNavigateToBuildingProfile: true));
        emit(state.copyWith(shouldNavigateToBuildingProfile: false));
      } else {
        emit(state.copyWith(shouldNavigateToCreateAccount: true));
        emit(state.copyWith(shouldNavigateToCreateAccount: false));
      }
    }
  }

  void _onHighlightSkipPressed(
    _HighlightSkipPressed event,
    Emitter<OnboardingState> emit,
  ) {
    if (_authRepository.currentUser != null) {
      add(const OnboardingEvent.completeOnboarding());
      emit(state.copyWith(shouldNavigateToBuildingProfile: true));
      emit(state.copyWith(shouldNavigateToBuildingProfile: false));
    } else {
      emit(state.copyWith(shouldNavigateToCreateAccount: true));
      emit(state.copyWith(shouldNavigateToCreateAccount: false));
    }
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
                'Get a daily list of stocks to explore--personalized just for you',
            type: FeatureHighlightType.dailyPicks,
          ),
        ];
        break;
    }
    return items;
  }
}
