import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_state.dart';
export 'package:bizzie/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_event.dart';
part 'onboarding_bloc.freezed.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final IOnboardingRepository _repository;

  OnboardingBloc(this._repository) : super(OnboardingState.initial()) {
    on<_Started>(_onStarted);
    on<_NameSubmitted>(_onNameSubmitted);
    on<_SectorSelected>(_onSectorSelected);

    on<_UploadBrands>(_onUploadBrands);
    on<_ConfirmWatchlist>(_onConfirmWatchlist);
    on<_ExperienceSelected>(_onExperienceSelected);
    on<_CompleteOnboarding>(_onCompleteOnboarding);
    on<_LoadSp500History>(_onLoadSp500History);
    on<_LoadBrands>(_onLoadBrands);
    on<_ToggleBrand>(_onToggleBrand);
    on<_UpdateCustomBrandInput>(_onUpdateCustomBrandInput);
    on<_StartAnalysis>(_onStartAnalysis);
    on<_UpdateAnalysisStep>(_onUpdateAnalysisStep);
    on<_StartWatchlistAddition>(_onStartWatchlistAddition);
    on<_UpdateWatchlistStep>(_onUpdateWatchlistStep);
  }

  Future<void> _onLoadBrands(
    _LoadBrands event,
    Emitter<OnboardingState> emit,
  ) async {
    // Assuming loading state if needed, or just silent update
    try {
      final (global, sector) = await _repository.getDailyBrands(
        state.onboardingData.selectedSector,
      );
      emit(state.copyWith(globalBrands: global, sectorBrands: sector));
    } catch (e) {
      // Handle error
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

  void _onUpdateCustomBrandInput(
    _UpdateCustomBrandInput event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(customBrandInput: event.input));
  }

  Future<void> _onStartAnalysis(
    _StartAnalysis event,
    Emitter<OnboardingState> emit,
  ) async {
    // Reset simulation
    // Also Populate detected companies from selected brands here to ensure they represent user selection
    final detectedCompanies = state.selectedBrands
        .map((brand) => Company(ticker: brand.ticker, name: brand.company))
        .toList();

    emit(
      state.copyWith(
        analysisStep: 0,
        isAnalyzingBrands: true,
        onboardingData: state.onboardingData.copyWith(
          detectedCompanies: detectedCompanies,
        ),
      ),
    );

    // Simulate Step 1: Gathering brands (1.5s)
    await Future.delayed(const Duration(milliseconds: 1500));
    if (isClosed) return;
    add(const OnboardingEvent.updateAnalysisStep(1));

    // Simulate Step 2: Identifying public companies (1.5s)
    await Future.delayed(const Duration(milliseconds: 1500));
    if (isClosed) return;
    add(const OnboardingEvent.updateAnalysisStep(2));

    // Simulate Step 3: Building watchlist (1.5s)
    await Future.delayed(const Duration(milliseconds: 1500));
    if (isClosed) return;
    add(const OnboardingEvent.updateAnalysisStep(3));
  }

  void _onUpdateAnalysisStep(
    _UpdateAnalysisStep event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(analysisStep: event.step));
    // If we reached step 3, we are effectively done with "Analyzing" visualization
    if (event.step == 3) {
      emit(state.copyWith(isAnalyzingBrands: false));
    }
  }

  Future<void> _onStartWatchlistAddition(
    _StartWatchlistAddition event,
    Emitter<OnboardingState> emit,
  ) async {
    // Reset simulation
    emit(state.copyWith(watchlistStep: 0, isAnalyzingBrands: true));

    final count = state.onboardingData.detectedCompanies.length;
    // Simulate adding each company (one by one)
    // We update step from 0 to count
    for (int i = 0; i <= count; i++) {
      if (isClosed) return;
      add(OnboardingEvent.updateWatchlistStep(i));
      // Calculate delay based on whether it is the last step
      // A bit of delay for simulation effect for each item
      if (i < count) {
        await Future.delayed(const Duration(milliseconds: 1500));
      }
    }
    // Final small delay before completion state if desired, or handled in UI
    await Future.delayed(const Duration(milliseconds: 500));
    // At the end we are done
    if (isClosed) return;
    // The UI will detect completion when watchlistStep == count
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

  Future<void> _onUploadBrands(
    _UploadBrands event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      state.copyWith(
        onboardingData: state.onboardingData.copyWith(
          rawBrandsText: event.brandsText,
        ),
        isAnalyzingBrands: true,
      ),
    );

    try {
      final companies = await _repository.getTickersFromBrands(
        event.brandsText,
      );
      emit(
        state.copyWith(
          isAnalyzingBrands: false,
          onboardingData: state.onboardingData.copyWith(
            detectedCompanies: companies,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isAnalyzingBrands: false));
    }
  }

  Future<void> _onStarted(_Started event, Emitter<OnboardingState> emit) async {
    // Fire S&P 500 load immediately on start as well, or via UI event
    add(const OnboardingEvent.loadSp500History());

    emit(state.copyWith(isLoadingSectors: true));
    try {
      final sectors = await _repository.getSectors();
      emit(state.copyWith(isLoadingSectors: false, availableSectors: sectors));
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingSectors: false,
          // In a real app we might handle error state explicitly,
          // for now just fallback to empty list or retriable state
        ),
      );
    }
  }

  void _onNameSubmitted(_NameSubmitted event, Emitter<OnboardingState> emit) {
    emit(
      state.copyWith(
        onboardingData: state.onboardingData.copyWith(firstName: event.name),
        currentStep: 2, // Move to next step logic could also be in UI router
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

  void _onConfirmWatchlist(
    _ConfirmWatchlist event,
    Emitter<OnboardingState> emit,
  ) {
    emit(
      state.copyWith(
        onboardingData: state.onboardingData.copyWith(
          detectedCompanies: event.confirmedCompanies,
        ),
      ),
    );
  }

  void _onExperienceSelected(
    _ExperienceSelected event,
    Emitter<OnboardingState> emit,
  ) {
    emit(
      state.copyWith(
        onboardingData: state.onboardingData.copyWith(
          investingExperience: event.experience,
        ),
      ),
    );
  }

  Future<void> _onCompleteOnboarding(
    _CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, failureMessage: null));

    try {
      await _repository.completeOnboarding(
        data: state.onboardingData,
        uid: event.uid,
        fcmToken: event.fcmToken,
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
}
