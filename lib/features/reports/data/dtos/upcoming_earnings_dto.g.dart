// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_earnings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpcomingEarningsDto _$UpcomingEarningsDtoFromJson(Map<String, dynamic> json) =>
    _UpcomingEarningsDto(
      id: json['id'] as String?,
      symbol: json['symbol'] as String,
      date: const TimestampConverter().fromJson(json['date']),
      expireAt: const TimestampConverter().fromJson(json['expireAt']),
    );

Map<String, dynamic> _$UpcomingEarningsDtoToJson(
  _UpcomingEarningsDto instance,
) => <String, dynamic>{
  'symbol': instance.symbol,
  'date': const TimestampConverter().toJson(instance.date),
  'expireAt': _$JsonConverterToJson<Object?, DateTime>(
    instance.expireAt,
    const TimestampConverter().toJson,
  ),
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
