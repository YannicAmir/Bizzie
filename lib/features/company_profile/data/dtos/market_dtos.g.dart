// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_dtos.dart';

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

_NewsDto _$NewsDtoFromJson(Map<String, dynamic> json) => _NewsDto(
  symbol: json['symbol'] as String,
  publishedDate: json['publishedDate'] as String,
  title: json['title'] as String,
  image: json['image'] as String?,
  site: json['site'] as String,
  url: json['url'] as String,
  text: json['text'] as String?,
);

Map<String, dynamic> _$NewsDtoToJson(_NewsDto instance) => <String, dynamic>{
  'symbol': instance.symbol,
  'publishedDate': instance.publishedDate,
  'title': instance.title,
  'image': instance.image,
  'site': instance.site,
  'url': instance.url,
  'text': instance.text,
};

_HistoricalPriceDto _$HistoricalPriceDtoFromJson(Map<String, dynamic> json) =>
    _HistoricalPriceDto(
      date: json['date'] as String,
      price: (json['price'] as num?)?.toDouble(),
      close: (json['close'] as num?)?.toDouble(),
      volume: (json['volume'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HistoricalPriceDtoToJson(_HistoricalPriceDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'price': instance.price,
      'close': instance.close,
      'volume': instance.volume,
    };
