// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Company _$CompanyFromJson(Map<String, dynamic> json) => _Company(
  ticker: json['ticker'] as String,
  name: json['name'] as String,
  logoUrl: json['logoUrl'] as String?,
);

Map<String, dynamic> _$CompanyToJson(_Company instance) => <String, dynamic>{
  'ticker': instance.ticker,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
};
