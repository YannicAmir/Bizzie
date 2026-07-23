// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_stock_price_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WatchlistStockPriceDto _$WatchlistStockPriceDtoFromJson(
  Map<String, dynamic> json,
) => _WatchlistStockPriceDto(
  ticker: json['ticker'] as String,
  companyName: json['companyName'] as String,
  price: (json['price'] as num).toDouble(),
  previousClose: (json['previousClose'] as num?)?.toDouble(),
  change: (json['change'] as num?)?.toDouble(),
  changePercent: (json['changePercent'] as num?)?.toDouble(),
  sessionDate: json['sessionDate'] as String,
  series:
      (json['series'] as List<dynamic>?)
          ?.map((e) => StockPricePointDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  closeFinalized: json['closeFinalized'] as bool? ?? false,
);

Map<String, dynamic> _$WatchlistStockPriceDtoToJson(
  _WatchlistStockPriceDto instance,
) => <String, dynamic>{
  'ticker': instance.ticker,
  'companyName': instance.companyName,
  'price': instance.price,
  'previousClose': instance.previousClose,
  'change': instance.change,
  'changePercent': instance.changePercent,
  'sessionDate': instance.sessionDate,
  'series': instance.series,
  'closeFinalized': instance.closeFinalized,
};

_StockPricePointDto _$StockPricePointDtoFromJson(Map<String, dynamic> json) =>
    _StockPricePointDto(
      t: json['t'] as String,
      c: (json['c'] as num).toDouble(),
    );

Map<String, dynamic> _$StockPricePointDtoToJson(_StockPricePointDto instance) =>
    <String, dynamic>{'t': instance.t, 'c': instance.c};
