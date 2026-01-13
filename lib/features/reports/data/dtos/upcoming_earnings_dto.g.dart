// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_earnings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpcomingEarningsDto _$UpcomingEarningsDtoFromJson(Map<String, dynamic> json) =>
    _UpcomingEarningsDto(
      symbol: json['symbol'] as String,
      date: json['date'] as String,
      expireAt: json['expireAt'] as String?,
    );

Map<String, dynamic> _$UpcomingEarningsDtoToJson(
  _UpcomingEarningsDto instance,
) => <String, dynamic>{
  'symbol': instance.symbol,
  'date': instance.date,
  'expireAt': instance.expireAt,
};
