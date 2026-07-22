// ignore_for_file: invalid_annotation_target
import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_news_dto.freezed.dart';
part 'market_news_dto.g.dart';

@freezed
abstract class MarketNewsDto with _$MarketNewsDto {
  const factory MarketNewsDto({
    @JsonKey(name: 'newsId') required String id,
    required String title,
    required String site,
    required String publisher,
    required String url,
    @TimestampConverter() required DateTime publishedAt,
    String? image,
  }) = _MarketNewsDto;

  const MarketNewsDto._();

  factory MarketNewsDto.fromJson(Map<String, dynamic> json) =>
      _$MarketNewsDtoFromJson(json);

  MarketNewsArticle toDomain() {
    return MarketNewsArticle(
      id: id,
      title: title,
      site: site,
      publisher: publisher,
      url: url,
      publishedAt: publishedAt,
      image: image,
    );
  }
}
