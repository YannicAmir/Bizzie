import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/shared/models/sector_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_sector_state.freezed.dart';

@freezed
abstract class SelectSectorState with _$SelectSectorState {
  const SelectSectorState._();

  const factory SelectSectorState.initial({
    required SectorViewModel initialSector,
    required SectorViewModel selectedSector,
    required List<SectorViewModel> availableSectors,
  }) = _Initial;
  const factory SelectSectorState.loading({
    required SectorViewModel initialSector,
    required SectorViewModel selectedSector,
    required List<SectorViewModel> availableSectors,
  }) = _Loading;
  const factory SelectSectorState.success({
    required SectorViewModel initialSector,
    required SectorViewModel selectedSector,
    required List<SectorViewModel> availableSectors,
  }) = _Success;
  const factory SelectSectorState.failure({
    required SectorViewModel initialSector,
    required SectorViewModel selectedSector,
    required List<SectorViewModel> availableSectors,
    required Failure failure,
  }) = _Failure;
}
