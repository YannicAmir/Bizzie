import 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_event.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_state.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/models/select_brands_view_model.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/get_daily_brands_params.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream_usecase.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

export 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_event.dart';
export 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_state.dart';

import 'package:bizzie/features/onboarding/select_brands/domain/usecases/get_daily_brands_usecase.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand_listing.dart';

import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('SelectBrandsBloc');

@injectable
class SelectBrandsBloc extends Bloc<SelectBrandsEvent, SelectBrandsState>
    with AuthSessionResetMixin<SelectBrandsEvent, SelectBrandsState> {
  List<Brand> _masterSectorBrands = [];
  List<Brand> _masterGlobalBrands = [];

  List<Brand> _selectedBrands = const [];
  String _sectorName = '';

  final GetDailyBrandsUseCase _getDailyBrandsUseCase;

  SelectBrandsBloc(
    this._getDailyBrandsUseCase,
    GetAuthStreamUseCase getAuthStream,
  ) : super(const SelectBrandsState.initial()) {
    _logger.info('Initializing SelectBrandsBloc');
    on<Started>(_onStarted, transformer: restartable());
    on<Updated>(_onUpdated);
    on<Reset>(_onReset);
    resetOnSessionEnd(getAuthStream, const SelectBrandsEvent.reset());
  }

  @override
  Future<void> close() {
    _logger.info('Closing SelectBrandsBloc');
    return super.close();
  }

  Future<void> _onStarted(
    Started event,
    Emitter<SelectBrandsState> emit,
  ) async {
    _selectedBrands = event.selectedBrands;
    _sectorName = event.sectorName;
    final userSector = event.sector;

    _logger.info(
      'Fetching daily brands for sector: ${userSector?.name ?? 'Global'}',
    );

    final result = await _getDailyBrandsUseCase(
      GetDailyBrandsParams(sector: userSector),
    );

    result.fold(
      (failure) {
        _logger.severe('Failed to fetch daily brands: ${failure.errorMessage}');
        emit(SelectBrandsState.error(failure.errorMessage));
      },
      (listing) {
        _logger.info(
          'Successfully fetched brands. Sector brands: ${listing.sectorBrands.length}, Global brands: ${listing.globalBrands.length}',
        );
        _storeMasterData(listing);
        _emitLoadedState(emit);
      },
    );
  }

  void _onUpdated(Updated event, Emitter<SelectBrandsState> emit) {
    _selectedBrands = event.selectedBrands;
    state.mapOrNull(
      loaded: (loadedState) {
        final oldSelectedNames = loadedState.selectedBrands
            .map((vm) => vm.brand.name)
            .toSet();
        final newSelectedNames = event.selectedBrands
            .map((b) => b.name)
            .toSet();

        if (oldSelectedNames.length != newSelectedNames.length) {
          _logger.info(
            'Brands updated. Selected count: ${newSelectedNames.length}',
          );
        }

        final newlyAddedNames = newSelectedNames.difference(oldSelectedNames);

        _emitLoadedState(emit, newlyAddedNames: newlyAddedNames);
      },
    );
  }

  void _onReset(Reset event, Emitter<SelectBrandsState> emit) {
    _logger.info('Resetting SelectBrandsBloc');
    _masterSectorBrands = [];
    _masterGlobalBrands = [];
    _selectedBrands = const [];
    _sectorName = '';
    emit(const SelectBrandsState.initial());
  }

  void _storeMasterData(BrandListing brandListing) {
    _masterGlobalBrands = brandListing.globalBrands;
    _masterSectorBrands = brandListing.sectorBrands;
  }

  void _emitLoadedState(
    Emitter<SelectBrandsState> emit, {
    Set<String> newlyAddedNames = const {},
  }) {
    final selectedSet = _selectedBrands.toSet();

    final sectorViewModels = _buildAvailableViewModels(
      _masterSectorBrands,
      selectedSet,
    );
    final globalViewModels = _buildAvailableViewModels(
      _masterGlobalBrands,
      selectedSet,
    );

    final selectedViewModels = _buildSelectedViewModels(
      _selectedBrands,
      newlyAddedNames: newlyAddedNames,
    );

    emit(
      SelectBrandsState.loaded(
        sectorBrands: sectorViewModels,
        globalBrands: globalViewModels,
        selectedBrands: selectedViewModels,
        sectorName: _sectorName,
      ),
    );
  }

  List<SelectBrandsViewModel> _buildAvailableViewModels(
    List<Brand> masterBrands,
    Set<Brand> selectedBrands,
  ) {
    final selectedNames = selectedBrands.map((b) => b.name).toSet();
    return masterBrands.where((b) => !selectedNames.contains(b.name)).map((
      brand,
    ) {
      return SelectBrandsViewModel(
        brand: brand,
        isSelected: false,
        shouldAnimate: false,
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
