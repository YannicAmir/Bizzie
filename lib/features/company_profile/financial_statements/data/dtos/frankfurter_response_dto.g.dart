// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frankfurter_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FrankfurterResponseDto _$FrankfurterResponseDtoFromJson(
  Map<String, dynamic> json,
) => _FrankfurterResponseDto(
  date: json['date'] as String,
  base: json['base'] as String,
  quote: json['quote'] as String,
  rate: (json['rate'] as num).toDouble(),
);

Map<String, dynamic> _$FrankfurterResponseDtoToJson(
  _FrankfurterResponseDto instance,
) => <String, dynamic>{
  'date': instance.date,
  'base': instance.base,
  'quote': instance.quote,
  'rate': instance.rate,
};
