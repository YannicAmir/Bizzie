import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
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
export 'package:bizzie/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_event.dart';
part 'onboarding_bloc.freezed.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final IAuthRepository _authRepository;
  final CompleteOnboardingUseCase _completeOnboardingUseCase;

  final GetSectorsUseCase _getSectorsUseCase;
  final GetSp500HistoryUseCase _getSp500HistoryUseCase;

  OnboardingBloc(
    this._authRepository,
    this._completeOnboardingUseCase,
    this._getSectorsUseCase,
    this._getSp500HistoryUseCase,
  ) : super(OnboardingState.initial()) {
    on<_Started>(_onStarted);
    on<_NameSubmitted>(_onNameSubmitted);
    on<_SectorSelected>(_onSectorSelected);
    on<_ExperienceSelected>(_onExperienceSelected);
    on<_CompleteOnboarding>(_onCompleteOnboarding);
    on<_LoadSp500History>(_onLoadSp500History);
    on<_ToggleBrand>(_onToggleBrand);
    on<_StartAnalysis>(_onStartAnalysis);
    on<_UpdateAnalysisStep>(_onUpdateAnalysisStep);
    on<_StartWatchlistAddition>(_onStartWatchlistAddition);
    on<_UpdateWatchlistStep>(_onUpdateWatchlistStep);
    on<_HighlightPageChanged>(_onHighlightPageChanged);
    on<_HighlightContinuePressed>(_onHighlightContinuePressed);
    on<_HighlightSkipPressed>(_onHighlightSkipPressed);
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
    emit(state.copyWith(isLoadingHistory: true));
    final result = await _getSp500HistoryUseCase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(isLoadingHistory: false));
      },
      (history) {
        emit(state.copyWith(isLoadingHistory: false, sp500History: history));
      },
    );
  }

  Future<void> _onStarted(_Started event, Emitter<OnboardingState> emit) async {
    add(const OnboardingEvent.loadSp500History());

    emit(state.copyWith(isLoadingSectors: true));
    final result = await _getSectorsUseCase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(isLoadingSectors: false));
      },
      (sectors) {
        emit(
          state.copyWith(isLoadingSectors: false, availableSectors: sectors),
        );
      },
    );
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

    final currentUser = _authRepository.currentUser;
    if (currentUser == null) {
      emit(
        state.copyWith(
          status: OnboardingStatus.failure,
          isSubmitting: false,
          failureMessage: 'User is not authenticated',
        ),
      );
      return;
    }

    final result = await _completeOnboardingUseCase(
      CompleteOnboardingParams(data: state.onboardingData, uid: currentUser.id),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OnboardingStatus.failure,
          isSubmitting: false,
          failureMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(status: OnboardingStatus.success, isSubmitting: false),
      ),
    );
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
