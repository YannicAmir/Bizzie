import 'dart:async';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/settings/domain/usecases/update_favorite_sector_usecase.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_state.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:bizzie/shared/models/sector_view_model.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:bizzie/features/settings/presentation/analytics/settings_tracker.dart';

final _logger = BizzieLogger('SelectSectorBloc');

@injectable
class SelectSectorBloc extends Bloc<SelectSectorEvent, SelectSectorState> {
  final UpdateFavoriteSectorUseCase _updateFavoriteSectorUseCase;
  final ISectorService _sectorService;
  final SettingsTracker _tracker;

  SelectSectorBloc(
    @factoryParam Sector? initialSector,
    this._updateFavoriteSectorUseCase,
    this._sectorService,
    this._tracker,
  ) : super(_buildInitialState(initialSector, _sectorService)) {
    _logger.info(
      'Initializing SelectSectorBloc with initialSector: ${initialSector?.name}',
    );

    unawaited(_tracker.logSectorChangeViewed());

    on<SelectSector>(_onSelectSector, transformer: restartable());
    on<SaveChanges>(_onSaveChanges, transformer: droppable());
  }

  static SelectSectorState _buildInitialState(
    Sector? initialSector,
    ISectorService sectorService,
  ) {
    final effectiveInitialSector =
        initialSector ?? Sector.informationTechnology;
    final initialViewModel = _resolveViewModel(
      effectiveInitialSector,
      sectorService,
    );

    final availableSectors =
        Sector.values.map((s) {
          return _resolveViewModel(s, sectorService);
        }).toList()..sort((a, b) {
          if (a.sector == effectiveInitialSector) return -1;
          if (b.sector == effectiveInitialSector) return 1;
          return a.displayName.compareTo(b.displayName);
        });

    return SelectSectorState.initial(
      initialSector: initialViewModel,
      selectedSector: initialViewModel,
      availableSectors: availableSectors,
    );
  }

  static SectorViewModel _resolveViewModel(
    Sector sector,
    ISectorService sectorService,
  ) {
    return SectorViewModel(
      sector: sector,
      displayName: sectorService.getSectorDisplayName(sector.name),
      description: sectorService.getSectorDescription(sector.name),
    );
  }

  void _onSelectSector(SelectSector event, Emitter<SelectSectorState> emit) {
    _logger.info('User selected sector: ${event.sector.name}');
    unawaited(_tracker.logSectorSelected(sector: event.sector.name));

    emit(
      state.copyWith(
        selectedSector: _resolveViewModel(event.sector, _sectorService),
        availableSectors: state.availableSectors,
      ),
    );
  }

  Future<void> _onSaveChanges(
    SaveChanges event,
    Emitter<SelectSectorState> emit,
  ) async {
    if (state.initialSector == state.selectedSector) {
      _logger.info('Save requested but no sector change detected. Skipping.');
      return;
    }

    _logger.info(
      'Starting SaveChanges workflow. From: ${state.initialSector.sector.name} To: ${state.selectedSector.sector.name}',
    );

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
      (failure) {
        _logger.severe(
          'Failed to update favorite sector to ${state.selectedSector.sector.name}',
          failure,
        );
        unawaited(
          _tracker.logSectorUpdateFailure(
            sector: state.selectedSector.sector.name,
            error: failure.errorMessage,
          ),
        );

        emit(
          SelectSectorState.failure(
            initialSector: state.initialSector,
            selectedSector: state.selectedSector,
            availableSectors: state.availableSectors,
            failure: failure,
          ),
        );
      },
      (_) {
        _logger.info(
          'Successfully updated favorite sector to ${state.selectedSector.sector.name}',
        );
        unawaited(
          _tracker.logSectorUpdateSuccess(
            sector: state.selectedSector.sector.name,
          ),
        );

        emit(
          SelectSectorState.success(
            initialSector: state.initialSector,
            selectedSector: state.selectedSector,
            availableSectors: state.availableSectors,
          ),
        );
      },
    );
  }
}
