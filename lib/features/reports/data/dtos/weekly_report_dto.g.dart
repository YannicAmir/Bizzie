// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeeklyReportDto _$WeeklyReportDtoFromJson(Map<String, dynamic> json) =>
    _WeeklyReportDto(
      id: json['id'] as String?,
      ticker: json['ticker'] as String?,
      companyName: json['companyName'] as String?,
      messageTitle: json['messageTitle'] as String?,
      messageShortSummary: json['messageShortSummary'] as String?,
      messageLongSummary: json['messageLongSummary'] as String?,
      newsLinks: (json['newsLinks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      eightKLinks: (json['eightKLinks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      priceMovement: json['priceMovement'] as Map<String, dynamic>?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$WeeklyReportDtoToJson(_WeeklyReportDto instance) =>
    <String, dynamic>{
      'ticker': instance.ticker,
      'companyName': instance.companyName,
      'messageTitle': instance.messageTitle,
      'messageShortSummary': instance.messageShortSummary,
      'messageLongSummary': instance.messageLongSummary,
      'newsLinks': instance.newsLinks,
      'eightKLinks': instance.eightKLinks,
      'priceMovement': instance.priceMovement,
      'createdAt': _$JsonConverterToJson<Object?, DateTime>(
        instance.createdAt,
        const TimestampConverter().toJson,
      ),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
