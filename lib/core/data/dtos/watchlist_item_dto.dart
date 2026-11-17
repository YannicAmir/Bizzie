import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_item_dto.freezed.dart';
part 'watchlist_item_dto.g.dart';

@freezed
abstract class WatchlistItemDto with _$WatchlistItemDto {
  const WatchlistItemDto._();

  const factory WatchlistItemDto({
    required String ticker,
    required String companyName,
    @TimestampConverter() required DateTime createdAt,
    String? logoUrl,
  }) = _WatchlistItemDto;

  factory WatchlistItemDto.fromJson(Map<String, dynamic> json) =>
      _$WatchlistItemDtoFromJson(json);

  factory WatchlistItemDto.fromDomain(Company company) {
    return WatchlistItemDto(
      ticker: company.ticker,
      companyName: company.name,
      createdAt: DateTime.now(),
      logoUrl: company.logoUrl,
    );
  }

  Company toDomain() {
    return Company(ticker: ticker, name: companyName, logoUrl: logoUrl);
  }
}
