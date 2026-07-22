// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketNewsDto _$MarketNewsDtoFromJson(Map<String, dynamic> json) =>
    _MarketNewsDto(
      id: json['newsId'] as String,
      title: json['title'] as String,
      site: json['site'] as String,
      publisher: json['publisher'] as String,
      url: json['url'] as String,
      publishedAt: const TimestampConverter().fromJson(json['publishedAt']),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$MarketNewsDtoToJson(_MarketNewsDto instance) =>
    <String, dynamic>{
      'newsId': instance.id,
      'title': instance.title,
      'site': instance.site,
      'publisher': instance.publisher,
      'url': instance.url,
      'publishedAt': const TimestampConverter().toJson(instance.publishedAt),
      'image': instance.image,
    };
