// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WatchlistItemDto _$WatchlistItemDtoFromJson(Map<String, dynamic> json) =>
    _WatchlistItemDto(
      ticker: json['ticker'] as String,
      companyName: json['companyName'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      logoUrl: json['logoUrl'] as String?,
    );

Map<String, dynamic> _$WatchlistItemDtoToJson(_WatchlistItemDto instance) =>
    <String, dynamic>{
      'ticker': instance.ticker,
      'companyName': instance.companyName,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'logoUrl': instance.logoUrl,
    };
