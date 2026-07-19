import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_stock_price_dto.freezed.dart';
part 'watchlist_stock_price_dto.g.dart';

@freezed
abstract class WatchlistStockPriceDto with _$WatchlistStockPriceDto {
  const factory WatchlistStockPriceDto({
    required String ticker,
    required String companyName,
    required double price,
    double? previousClose,
    double? change,
    double? changePercent,
    required String sessionDate,
    @Default([]) List<StockPricePointDto> series,
    @Default(false) bool closeFinalized,
  }) = _WatchlistStockPriceDto;

  const WatchlistStockPriceDto._();

  factory WatchlistStockPriceDto.fromJson(Map<String, dynamic> json) =>
      _$WatchlistStockPriceDtoFromJson(json);

  WatchlistStockPrice toDomain() {
    return WatchlistStockPrice(
      ticker: ticker,
      companyName: companyName,
      price: price,
      previousClose: previousClose,
      change: change,
      changePercent: changePercent,
      sessionDate: sessionDate,
      series: series.map((point) => point.toDomain()).toList(),
      closeFinalized: closeFinalized,
    );
  }
}

@freezed
abstract class StockPricePointDto with _$StockPricePointDto {
  const factory StockPricePointDto({
    required String t,
    required double c,
  }) = _StockPricePointDto;

  const StockPricePointDto._();

  factory StockPricePointDto.fromJson(Map<String, dynamic> json) =>
      _$StockPricePointDtoFromJson(json);

  WatchlistStockPricePoint toDomain() {
    return WatchlistStockPricePoint(time: t, close: c);
  }
}
