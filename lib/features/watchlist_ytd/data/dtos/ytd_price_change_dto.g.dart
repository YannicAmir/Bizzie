// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ytd_price_change_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YtdPriceChangeDto _$YtdPriceChangeDtoFromJson(Map<String, dynamic> json) =>
    _YtdPriceChangeDto(
      ticker: json['ticker'] as String,
      companyName: json['companyName'] as String,
      year: (json['year'] as num).toInt(),
      baselineDate: json['baselineDate'] as String,
      baselineClose: (json['baselineClose'] as num).toDouble(),
      latestDate: json['latestDate'] as String,
      latestClose: (json['latestClose'] as num).toDouble(),
      ytdChange: (json['ytdChange'] as num).toDouble(),
      ytdChangePercent: (json['ytdChangePercent'] as num).toDouble(),
    );

Map<String, dynamic> _$YtdPriceChangeDtoToJson(_YtdPriceChangeDto instance) =>
    <String, dynamic>{
      'ticker': instance.ticker,
      'companyName': instance.companyName,
      'year': instance.year,
      'baselineDate': instance.baselineDate,
      'baselineClose': instance.baselineClose,
      'latestDate': instance.latestDate,
      'latestClose': instance.latestClose,
      'ytdChange': instance.ytdChange,
      'ytdChangePercent': instance.ytdChangePercent,
    };
