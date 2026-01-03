// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_brands_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyBrandsDto _$DailyBrandsDtoFromJson(Map<String, dynamic> json) =>
    _DailyBrandsDto(
      date: const TimestampConverter().fromJson(json['date'] as Object),
      sectors: (json['sectors'] as List<dynamic>)
          .map((e) => DailyBrandSectorDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyBrandsDtoToJson(_DailyBrandsDto instance) =>
    <String, dynamic>{
      'date': const TimestampConverter().toJson(instance.date),
      'sectors': instance.sectors,
    };

_DailyBrandSectorDto _$DailyBrandSectorDtoFromJson(Map<String, dynamic> json) =>
    _DailyBrandSectorDto(
      name: json['name'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => DailyBrandProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyBrandSectorDtoToJson(
  _DailyBrandSectorDto instance,
) => <String, dynamic>{'name': instance.name, 'products': instance.products};

_DailyBrandProductDto _$DailyBrandProductDtoFromJson(
  Map<String, dynamic> json,
) => _DailyBrandProductDto(
  company: json['company'] as String,
  description: json['description'] as String,
  name: json['name'] as String,
  ticker: json['ticker'] as String,
);

Map<String, dynamic> _$DailyBrandProductDtoToJson(
  _DailyBrandProductDto instance,
) => <String, dynamic>{
  'company': instance.company,
  'description': instance.description,
  'name': instance.name,
  'ticker': instance.ticker,
};
