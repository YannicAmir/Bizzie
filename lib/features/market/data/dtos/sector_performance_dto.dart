import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sector_performance_dto.freezed.dart';
part 'sector_performance_dto.g.dart';

@freezed
abstract class SectorPerformanceDto with _$SectorPerformanceDto {
  const factory SectorPerformanceDto({
    required String date,
    required String sector,
    required String exchange,
    required double averageChange,
  }) = _SectorPerformanceDto;

  const SectorPerformanceDto._();

  factory SectorPerformanceDto.fromJson(Map<String, dynamic> json) =>
      _$SectorPerformanceDtoFromJson(json);

  SectorPerformance toDomain() {
    return SectorPerformance(
      date: date,
      sector: sector,
      exchange: exchange,
      averageChange: averageChange,
    );
  }
}
