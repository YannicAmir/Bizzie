// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sec_filing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SecFilingDto _$SecFilingDtoFromJson(Map<String, dynamic> json) =>
    _SecFilingDto(
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String,
      filingDate: json['filingDate'] as String,
      formType: json['formType'] as String,
      link: json['link'] as String,
      summary: json['summary'] as String,
      eps: const ForceDoubleNullable().fromJson(json['eps']),
      revenue: const ForceDoubleNullable().fromJson(json['revenue']),
      sentiment: json['sentiment'] as String?,
      topic: json['topic'] as String?,
      isEarnings: json['isEarnings'] as bool? ?? false,
      createdAt: json['createdAt'],
      analyzedAt: json['analyzedAt'],
      deepAnalysisId: json['deepAnalysisId'] as String?,
      deepAnalysisStatus: json['deepAnalysisStatus'] as String?,
    );

Map<String, dynamic> _$SecFilingDtoToJson(_SecFilingDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'filingDate': instance.filingDate,
      'formType': instance.formType,
      'link': instance.link,
      'summary': instance.summary,
      'eps': const ForceDoubleNullable().toJson(instance.eps),
      'revenue': const ForceDoubleNullable().toJson(instance.revenue),
      'sentiment': instance.sentiment,
      'topic': instance.topic,
      'isEarnings': instance.isEarnings,
      'createdAt': instance.createdAt,
      'analyzedAt': instance.analyzedAt,
      'deepAnalysisId': instance.deepAnalysisId,
      'deepAnalysisStatus': instance.deepAnalysisStatus,
    };
