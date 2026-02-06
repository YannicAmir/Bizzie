import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sector_pe_dto.freezed.dart';
part 'sector_pe_dto.g.dart';

@freezed
abstract class SectorPeDto with _$SectorPeDto {
  const factory SectorPeDto({
    required String date,
    required String sector,
    required String exchange,
    required double pe,
  }) = _SectorPeDto;

  const SectorPeDto._();

  factory SectorPeDto.fromJson(Map<String, dynamic> json) =>
      _$SectorPeDtoFromJson(json);

  SectorPe toDomain() {
    return SectorPe(date: date, sector: sector, exchange: exchange, pe: pe);
  }
}
