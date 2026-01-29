// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dividend_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DividendDto _$DividendDtoFromJson(Map<String, dynamic> json) => _DividendDto(
  date: json['date'] as String,
  dividend: (json['dividend'] as num?)?.toDouble(),
  adjDividend: (json['adjDividend'] as num?)?.toDouble(),
  recordDate: json['recordDate'] as String?,
  paymentDate: json['paymentDate'] as String?,
  declarationDate: json['declarationDate'] as String?,
  yield: (json['yield'] as num?)?.toDouble(),
  frequency: json['frequency'] as String?,
);

Map<String, dynamic> _$DividendDtoToJson(_DividendDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'dividend': instance.dividend,
      'adjDividend': instance.adjDividend,
      'recordDate': instance.recordDate,
      'paymentDate': instance.paymentDate,
      'declarationDate': instance.declarationDate,
      'yield': instance.yield,
      'frequency': instance.frequency,
    };
