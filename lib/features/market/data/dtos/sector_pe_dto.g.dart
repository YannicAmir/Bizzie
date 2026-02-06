// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_pe_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SectorPeDto _$SectorPeDtoFromJson(Map<String, dynamic> json) => _SectorPeDto(
  date: json['date'] as String,
  sector: json['sector'] as String,
  exchange: json['exchange'] as String,
  pe: (json['pe'] as num).toDouble(),
);

Map<String, dynamic> _$SectorPeDtoToJson(_SectorPeDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'sector': instance.sector,
      'exchange': instance.exchange,
      'pe': instance.pe,
    };
