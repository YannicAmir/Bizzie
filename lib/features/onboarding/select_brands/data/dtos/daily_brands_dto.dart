import 'package:bizzie/shared/utils/json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_brands_dto.freezed.dart';
part 'daily_brands_dto.g.dart';

@freezed
abstract class DailyBrandsDto with _$DailyBrandsDto {
  const factory DailyBrandsDto({
    @TimestampConverter() required DateTime date,
    required List<DailyBrandSectorDto> sectors,
  }) = _DailyBrandsDto;

  factory DailyBrandsDto.fromJson(Map<String, dynamic> json) =>
      _$DailyBrandsDtoFromJson(json);
}

@freezed
abstract class DailyBrandSectorDto with _$DailyBrandSectorDto {
  const factory DailyBrandSectorDto({
    required String name,
    required List<DailyBrandProductDto> products,
  }) = _DailyBrandSectorDto;

  factory DailyBrandSectorDto.fromJson(Map<String, dynamic> json) =>
      _$DailyBrandSectorDtoFromJson(json);
}

@freezed
abstract class DailyBrandProductDto with _$DailyBrandProductDto {
  const factory DailyBrandProductDto({
    required String company,
    required String description,
    required String name,
    required String ticker,
  }) = _DailyBrandProductDto;

  factory DailyBrandProductDto.fromJson(Map<String, dynamic> json) =>
      _$DailyBrandProductDtoFromJson(json);
}
