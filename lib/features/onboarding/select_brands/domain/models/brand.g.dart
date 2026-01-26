// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Brand _$BrandFromJson(Map<String, dynamic> json) => _Brand(
  name: json['name'] as String,
  company: json['company'] as String,
  ticker: json['ticker'] as String,
  description: json['description'] as String,
  sector: json['sector'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$BrandToJson(_Brand instance) => <String, dynamic>{
  'name': instance.name,
  'company': instance.company,
  'ticker': instance.ticker,
  'description': instance.description,
  'sector': instance.sector,
  'imageUrl': instance.imageUrl,
};
