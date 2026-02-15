import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_api_dtos.freezed.dart';
part 'watchlist_api_dtos.g.dart';

@freezed
abstract class WatchlistEarningsDto with _$WatchlistEarningsDto {
  const factory WatchlistEarningsDto({
    required String symbol,
    @TimestampConverter() required DateTime date,
    @TimestampConverter() DateTime? expireAt,
  }) = _WatchlistEarningsDto;

  factory WatchlistEarningsDto.fromJson(Map<String, dynamic> json) =>
      _$WatchlistEarningsDtoFromJson(json);
}

@freezed
abstract class WatchlistFilingDto with _$WatchlistFilingDto {
  const factory WatchlistFilingDto({
    required String symbol,
    required String formType,
    @TimestampConverter() required DateTime filingDate,
    String? topic,
    @Default(false) bool isEarnings,
  }) = _WatchlistFilingDto;

  factory WatchlistFilingDto.fromJson(Map<String, dynamic> json) =>
      _$WatchlistFilingDtoFromJson(json);
}
