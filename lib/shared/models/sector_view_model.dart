import 'package:bizzie/core/domain/models/sector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sector_view_model.freezed.dart';

@freezed
abstract class SectorViewModel with _$SectorViewModel {
  const factory SectorViewModel({
    required Sector sector,
    required String displayName,
    required String description,
  }) = _SectorViewModel;
}
