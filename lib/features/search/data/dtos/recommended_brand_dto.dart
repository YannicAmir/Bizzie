import 'package:bizzie/core/domain/models/company.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommended_brand_dto.g.dart';

@JsonSerializable(createToJson: false)
class RecommendedBrandDto {
  final String ticker;
  @JsonKey(name: 'company')
  final String name;

  RecommendedBrandDto({required this.ticker, required this.name});

  factory RecommendedBrandDto.fromJson(Map<String, dynamic> json) =>
      _$RecommendedBrandDtoFromJson(json);

  Company toDomain() {
    return Company(ticker: ticker, name: name);
  }
}
