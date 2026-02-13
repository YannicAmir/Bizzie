import 'package:bizzie/core/domain/models/sector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_sector_event.freezed.dart';

@freezed
class SelectSectorEvent with _$SelectSectorEvent {
  const factory SelectSectorEvent.selectSector(Sector sector) = SelectSector;
  const factory SelectSectorEvent.saveChanges() = SaveChanges;
}
