// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governance_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GovernanceDto _$GovernanceDtoFromJson(Map<String, dynamic> json) =>
    _GovernanceDto(
      symbol: json['symbol'] as String,
      nameAndPosition: json['nameAndPosition'] as String,
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GovernanceDtoToJson(_GovernanceDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'nameAndPosition': instance.nameAndPosition,
      'total': instance.total,
    };

_ExecutiveDto _$ExecutiveDtoFromJson(Map<String, dynamic> json) =>
    _ExecutiveDto(
      name: json['name'] as String,
      title: json['title'] as String,
      pay: (json['pay'] as num?)?.toDouble(),
      currencyPay: json['currencyPay'] as String?,
      gender: json['gender'] as String?,
      yearBorn: (json['yearBorn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExecutiveDtoToJson(_ExecutiveDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'pay': instance.pay,
      'currencyPay': instance.currencyPay,
      'gender': instance.gender,
      'yearBorn': instance.yearBorn,
    };
