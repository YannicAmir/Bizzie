import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_dto.freezed.dart';
part 'news_dto.g.dart';

@freezed
abstract class NewsDto with _$NewsDto {
  const factory NewsDto({
    required String symbol,
    required String publishedDate,
    required String title,
    String? image,
    required String site,
    required String url,
    String? text,
  }) = _NewsDto;

  factory NewsDto.fromJson(Map<String, dynamic> json) =>
      _$NewsDtoFromJson(json);
}
