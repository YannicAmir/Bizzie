import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/settings/domain/usecases/update_favorite_sector_usecase.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_state.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/shared/models/sector_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectSectorBloc extends Bloc<SelectSectorEvent, SelectSectorState> {
  final UpdateFavoriteSectorUseCase _updateFavoriteSectorUseCase;
  final ConfigService _configService;

  SelectSectorBloc(
    @factoryParam Sector? initialSector,
    this._updateFavoriteSectorUseCase,
    this._configService,
  ) : super(
        SelectSectorState.initial(
          initialSector: _resolveViewModel(
            initialSector ?? Sector.informationTechnology,
            _configService,
          ),
          selectedSector: _resolveViewModel(
            initialSector ?? Sector.informationTechnology,
            _configService,
          ),
          availableSectors: Sector.values
              .map((s) => _resolveViewModel(s, _configService))
              .toList(),
        ),
      ) {
    on<SelectSector>(_onSelectSector);
    on<SaveChanges>(_onSaveChanges);
  }

  static SectorViewModel _resolveViewModel(
    Sector sector,
    ConfigService configService,
  ) {
    return SectorViewModel(
      sector: sector,
      displayName: configService.getSectorDisplayName(sector.name),
      description: configService.getSectorDescription(sector.name),
    );
  }

  void _onSelectSector(SelectSector event, Emitter<SelectSectorState> emit) {
    emit(
      state.copyWith(
        selectedSector: _resolveViewModel(event.sector, _configService),
        availableSectors: state.availableSectors,
      ),
    );
  }

  Future<void> _onSaveChanges(
    SaveChanges event,
    Emitter<SelectSectorState> emit,
  ) async {
    if (state.initialSector == state.selectedSector) return;

    emit(
      SelectSectorState.loading(
        initialSector: state.initialSector,
        selectedSector: state.selectedSector,
        availableSectors: state.availableSectors,
      ),
    );

    final result = await _updateFavoriteSectorUseCase(
      state.selectedSector.sector,
    );

    result.fold(
      (failure) => emit(
        SelectSectorState.failure(
          initialSector: state.initialSector,
          selectedSector: state.selectedSector,
          availableSectors: state.availableSectors,
          failure: failure,
        ),
      ),
      (_) => emit(
        SelectSectorState.success(
          initialSector: state.initialSector,
          selectedSector: state.selectedSector,
          availableSectors: state.availableSectors,
        ),
      ),
    );
  }
}
