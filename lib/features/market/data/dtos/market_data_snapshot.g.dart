// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_data_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketDataSnapshot _$MarketDataSnapshotFromJson(Map<String, dynamic> json) =>
    _MarketDataSnapshot(
      date: json['date'] as String,
      peList: (json['peList'] as List<dynamic>)
          .map((e) => SectorPeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      performanceList: (json['performanceList'] as List<dynamic>)
          .map((e) => SectorPerformanceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      cacheTimestamp: (json['cacheTimestamp'] as num).toInt(),
    );

Map<String, dynamic> _$MarketDataSnapshotToJson(_MarketDataSnapshot instance) =>
    <String, dynamic>{
      'date': instance.date,
      'peList': instance.peList,
      'performanceList': instance.performanceList,
      'cacheTimestamp': instance.cacheTimestamp,
    };
