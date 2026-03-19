// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frankfurter_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FrankfurterResponseDto _$FrankfurterResponseDtoFromJson(
  Map<String, dynamic> json,
) => _FrankfurterResponseDto(
  amount: (json['amount'] as num).toDouble(),
  base: json['base'] as String,
  date: json['date'] as String,
  rates: (json['rates'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
);

Map<String, dynamic> _$FrankfurterResponseDtoToJson(
  _FrankfurterResponseDto instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'base': instance.base,
  'date': instance.date,
  'rates': instance.rates,
};
