import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_news_dto.freezed.dart';
part 'watchlist_news_dto.g.dart';

@freezed
abstract class WatchlistNewsDto with _$WatchlistNewsDto {
  const factory WatchlistNewsDto({
    required String symbol,
    required String title,
    required String site,
    required String url,
    @TimestampConverter() required DateTime publishedAt,
    String? image,
  }) = _WatchlistNewsDto;

  const WatchlistNewsDto._();

  factory WatchlistNewsDto.fromJson(Map<String, dynamic> json) =>
      _$WatchlistNewsDtoFromJson(json);

  WatchlistNewsArticle toDomain() {
    return WatchlistNewsArticle(
      symbol: symbol,
      title: title,
      site: site,
      url: url,
      publishedAt: publishedAt,
      image: image,
    );
  }
}
