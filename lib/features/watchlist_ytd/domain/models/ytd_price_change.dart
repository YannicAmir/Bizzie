import 'package:freezed_annotation/freezed_annotation.dart';

part 'ytd_price_change.freezed.dart';

@freezed
abstract class YtdPriceChange with _$YtdPriceChange {
  const factory YtdPriceChange({
    required String ticker,
    required String companyName,
    required int year,
    required String baselineDate,
    required double baselineClose,
    required String latestDate,
    required double latestClose,
    required double ytdChange,
    required double ytdChangePercent,
  }) = _YtdPriceChange;
}
