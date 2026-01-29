// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fmp_sec_filing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FmpSecFilingDto _$FmpSecFilingDtoFromJson(Map<String, dynamic> json) =>
    _FmpSecFilingDto(
      symbol: json['symbol'] as String?,
      filingDate: json['filingDate'] as String?,
      acceptedDate: json['acceptedDate'] as String?,
      period: json['period'] as String?,
      formType: json['formType'] as String?,
      link: json['link'] as String?,
      finalLink: json['finalLink'] as String?,
    );

Map<String, dynamic> _$FmpSecFilingDtoToJson(_FmpSecFilingDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'filingDate': instance.filingDate,
      'acceptedDate': instance.acceptedDate,
      'period': instance.period,
      'formType': instance.formType,
      'link': instance.link,
      'finalLink': instance.finalLink,
    };
