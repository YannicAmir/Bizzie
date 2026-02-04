import 'dart:async';

import 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_event.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_state.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/models/select_brands_view_model.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/get_daily_brands_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

export 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_event.dart';
export 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_state.dart';

import 'package:bizzie/features/onboarding/select_brands/domain/usecases/get_daily_brands_usecase.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand_listing.dart';

@injectable
class SelectBrandsBloc extends Bloc<SelectBrandsEvent, SelectBrandsState> {
  final Set<String> _initialStaticItems = {};

  List<Brand> _masterSectorBrands = [];
  List<Brand> _masterGlobalBrands = [];

  final OnboardingBloc _onboardingBloc;
  final GetDailyBrandsUseCase _getDailyBrandsUseCase;
  StreamSubscription? _onboardingSubscription;

  SelectBrandsBloc(this._onboardingBloc, this._getDailyBrandsUseCase)
    : super(const SelectBrandsState.initial()) {
    on<Started>(_onStarted);
    on<Updated>(_onUpdated);
    on<ToggleBrand>(_onToggleBrand);

    _onboardingSubscription = _onboardingBloc.stream.listen((onboardingState) {
      add(
        SelectBrandsEvent.updated(
          selectedBrands: onboardingState.selectedBrands,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _onboardingSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    Started event,
    Emitter<SelectBrandsState> emit,
  ) async {
    final onboardingState = _onboardingBloc.state;
    final userSector = onboardingState.onboardingData.selectedSector;

    final result = await _getDailyBrandsUseCase(
      GetDailyBrandsParams(sector: userSector),
    );

    result.fold((failure) => emit(SelectBrandsState.error(failure.message)), (
      listing,
    ) {
      _storeMasterData(listing);
      _emitLoadedState(emit);
    });
  }

  void _onUpdated(Updated event, Emitter<SelectBrandsState> emit) {
    state.mapOrNull(
      loaded: (loadedState) {
        final oldSelectedNames = loadedState.selectedBrands
            .map((vm) => vm.brand.name)
            .toSet();
        final newSelectedNames = event.selectedBrands
            .map((b) => b.name)
            .toSet();
        final newlyAddedNames = newSelectedNames.difference(oldSelectedNames);

        _emitLoadedState(emit, newlyAddedNames: newlyAddedNames);
      },
    );
  }

  void _storeMasterData(BrandListing brandListing) {
    _masterGlobalBrands = brandListing.globalBrands;
    _masterSectorBrands = brandListing.sectorBrands;
    _initStaticItems([..._masterSectorBrands, ..._masterGlobalBrands]);
  }

  void _emitLoadedState(
    Emitter<SelectBrandsState> emit, {
    Set<String> newlyAddedNames = const {},
  }) {
    final onboardingState = _onboardingBloc.state;
    final selectedSet = onboardingState.selectedBrands.toSet();

    final sectorViewModels = _buildAvailableViewModels(
      _masterSectorBrands,
      selectedSet,
    );
    final globalViewModels = _buildAvailableViewModels(
      _masterGlobalBrands,
      selectedSet,
    );

    final selectedViewModels = _buildSelectedViewModels(
      onboardingState.selectedBrands,
      newlyAddedNames: newlyAddedNames,
    );

    emit(
      SelectBrandsState.loaded(
        sectorBrands: sectorViewModels,
        globalBrands: globalViewModels,
        selectedBrands: selectedViewModels,
        sectorName:
            onboardingState.onboardingData.selectedSector?.displayName ??
            'Your Sector',
      ),
    );
  }

  void _onToggleBrand(ToggleBrand event, Emitter<SelectBrandsState> emit) {
    _onboardingBloc.add(OnboardingEvent.toggleBrand(event.brand));
    if (_initialStaticItems.contains(event.brand.name)) {
      _initialStaticItems.remove(event.brand.name);
    }
  }

  void _initStaticItems(List<Brand> allBrands) {
    for (var brand in allBrands) {
      _initialStaticItems.add(brand.name);
    }
  }

  List<SelectBrandsViewModel> _buildAvailableViewModels(
    List<Brand> masterBrands,
    Set<Brand> selectedBrands,
  ) {
    final selectedNames = selectedBrands.map((b) => b.name).toSet();
    return masterBrands.where((b) => !selectedNames.contains(b.name)).map((
      brand,
    ) {
      final shouldAnimate = !_initialStaticItems.contains(brand.name);
      return SelectBrandsViewModel(
        brand: brand,
        isSelected: false,
        shouldAnimate: shouldAnimate,
      );
    }).toList();
  }

  List<SelectBrandsViewModel> _buildSelectedViewModels(
    List<Brand> selectedBrands, {
    required Set<String> newlyAddedNames,
  }) {
    return selectedBrands.map((brand) {
      final isNew = newlyAddedNames.contains(brand.name);
      return SelectBrandsViewModel(
        brand: brand,
        isSelected: true,
        shouldAnimate: isNew,
      );
    }).toList();
  }
}
