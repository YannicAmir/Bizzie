import 'package:bizzie/features/market/data/dtos/sector_pe_dto.dart';
import 'package:bizzie/features/market/data/dtos/sector_performance_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_data_snapshot.freezed.dart';
part 'market_data_snapshot.g.dart';

@freezed
abstract class MarketDataSnapshot with _$MarketDataSnapshot {
  const factory MarketDataSnapshot({
    required String date,
    required List<SectorPeDto> peList,
    required List<SectorPerformanceDto> performanceList,
    required int cacheTimestamp,
  }) = _MarketDataSnapshot;

  factory MarketDataSnapshot.fromJson(Map<String, dynamic> json) =>
      _$MarketDataSnapshotFromJson(json);
}
