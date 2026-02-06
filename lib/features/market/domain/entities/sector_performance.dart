import 'package:freezed_annotation/freezed_annotation.dart';

part 'sector_performance.freezed.dart';

@freezed
abstract class SectorPerformance with _$SectorPerformance {
  const factory SectorPerformance({
    required String date,
    required String sector,
    required String exchange,
    required double averageChange,
  }) = _SectorPerformance;
}
