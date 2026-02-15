// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_api_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WatchlistEarningsDto _$WatchlistEarningsDtoFromJson(
  Map<String, dynamic> json,
) => _WatchlistEarningsDto(
  symbol: json['symbol'] as String,
  date: const TimestampConverter().fromJson(json['date']),
  expireAt: const TimestampConverter().fromJson(json['expireAt']),
);

Map<String, dynamic> _$WatchlistEarningsDtoToJson(
  _WatchlistEarningsDto instance,
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

_WatchlistFilingDto _$WatchlistFilingDtoFromJson(Map<String, dynamic> json) =>
    _WatchlistFilingDto(
      symbol: json['symbol'] as String,
      formType: json['formType'] as String,
      filingDate: const TimestampConverter().fromJson(json['filingDate']),
      topic: json['topic'] as String?,
      isEarnings: json['isEarnings'] as bool? ?? false,
    );

Map<String, dynamic> _$WatchlistFilingDtoToJson(_WatchlistFilingDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'formType': instance.formType,
      'filingDate': const TimestampConverter().toJson(instance.filingDate),
      'topic': instance.topic,
      'isEarnings': instance.isEarnings,
    };
