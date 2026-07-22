// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WatchlistNewsDto _$WatchlistNewsDtoFromJson(Map<String, dynamic> json) =>
    _WatchlistNewsDto(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      title: json['title'] as String,
      site: json['site'] as String,
      url: json['url'] as String,
      publishedAt: const TimestampConverter().fromJson(json['publishedAt']),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$WatchlistNewsDtoToJson(_WatchlistNewsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'title': instance.title,
      'site': instance.site,
      'url': instance.url,
      'publishedAt': const TimestampConverter().toJson(instance.publishedAt),
      'image': instance.image,
    };
