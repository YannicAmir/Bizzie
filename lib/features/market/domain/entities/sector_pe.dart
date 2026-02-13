import 'package:freezed_annotation/freezed_annotation.dart';

part 'sector_pe.freezed.dart';

@freezed
abstract class SectorPe with _$SectorPe {
  const factory SectorPe({
    required String date,
    required String sector,
    required String exchange,
    required double pe,
  }) = _SectorPe;
}
