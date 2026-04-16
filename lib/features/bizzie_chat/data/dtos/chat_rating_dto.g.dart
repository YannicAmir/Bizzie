// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_rating_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatRatingDto _$ChatRatingDtoFromJson(Map<String, dynamic> json) =>
    _ChatRatingDto(
      rating: json['rating'] as String,
      question: json['question'] as String,
      aiResponse: json['ai_response'] as String,
      time: const TimestampConverter().fromJson(json['time']),
      companyName: json['company_name'] as String,
      companyTicker: json['company_ticker'] as String,
    );

Map<String, dynamic> _$ChatRatingDtoToJson(_ChatRatingDto instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'question': instance.question,
      'ai_response': instance.aiResponse,
      'time': const TimestampConverter().toJson(instance.time),
      'company_name': instance.companyName,
      'company_ticker': instance.companyTicker,
    };
