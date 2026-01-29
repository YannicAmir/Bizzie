// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
