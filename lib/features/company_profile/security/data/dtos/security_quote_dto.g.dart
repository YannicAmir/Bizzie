// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_quote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SecurityQuoteDto _$SecurityQuoteDtoFromJson(Map<String, dynamic> json) =>
    _SecurityQuoteDto(
      ticker: json['ticker'] as String,
      price: (json['price'] as num).toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      changePercent: (json['changePercent'] as num?)?.toDouble(),
      sessionDate: json['sessionDate'] as String,
    );

Map<String, dynamic> _$SecurityQuoteDtoToJson(_SecurityQuoteDto instance) =>
    <String, dynamic>{
      'ticker': instance.ticker,
      'price': instance.price,
      'change': instance.change,
      'changePercent': instance.changePercent,
      'sessionDate': instance.sessionDate,
    };
