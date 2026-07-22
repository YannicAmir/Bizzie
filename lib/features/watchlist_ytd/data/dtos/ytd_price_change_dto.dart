import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ytd_price_change_dto.freezed.dart';
part 'ytd_price_change_dto.g.dart';

@freezed
abstract class YtdPriceChangeDto with _$YtdPriceChangeDto {
  const factory YtdPriceChangeDto({
    required String ticker,
    required String companyName,
    required int year,
    required String baselineDate,
    required double baselineClose,
    required String latestDate,
    required double latestClose,
    required double ytdChange,
    required double ytdChangePercent,
  }) = _YtdPriceChangeDto;

  const YtdPriceChangeDto._();

  factory YtdPriceChangeDto.fromJson(Map<String, dynamic> json) =>
      _$YtdPriceChangeDtoFromJson(json);

  YtdPriceChange toDomain() {
    return YtdPriceChange(
      ticker: ticker,
      companyName: companyName,
      year: year,
      baselineDate: baselineDate,
      baselineClose: baselineClose,
      latestDate: latestDate,
      latestClose: latestClose,
      ytdChange: ytdChange,
      ytdChangePercent: ytdChangePercent,
    );
  }
}
