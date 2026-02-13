// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_performance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SectorPerformanceDto _$SectorPerformanceDtoFromJson(
  Map<String, dynamic> json,
) => _SectorPerformanceDto(
  date: json['date'] as String,
  sector: json['sector'] as String,
  exchange: json['exchange'] as String,
  averageChange: (json['averageChange'] as num).toDouble(),
);

Map<String, dynamic> _$SectorPerformanceDtoToJson(
  _SectorPerformanceDto instance,
) => <String, dynamic>{
  'date': instance.date,
  'sector': instance.sector,
  'exchange': instance.exchange,
  'averageChange': instance.averageChange,
};
