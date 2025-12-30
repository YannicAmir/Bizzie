import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';
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
