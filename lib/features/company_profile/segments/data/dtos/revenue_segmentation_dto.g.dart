// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revenue_segmentation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RevenueSegmentationDto _$RevenueSegmentationDtoFromJson(
  Map<String, dynamic> json,
) => _RevenueSegmentationDto(
  symbol: json['symbol'] as String?,
  fiscalYear: (json['fiscalYear'] as num?)?.toInt(),
  period: json['period'] as String?,
  reportedCurrency: json['reportedCurrency'] as String?,
  date: json['date'] as String?,
  data: (json['data'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
);

Map<String, dynamic> _$RevenueSegmentationDtoToJson(
  _RevenueSegmentationDto instance,
) => <String, dynamic>{
  'symbol': instance.symbol,
  'fiscalYear': instance.fiscalYear,
  'period': instance.period,
  'reportedCurrency': instance.reportedCurrency,
  'date': instance.date,
  'data': instance.data,
};
