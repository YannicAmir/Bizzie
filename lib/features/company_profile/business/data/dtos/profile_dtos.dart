import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_dtos.freezed.dart';
part 'profile_dtos.g.dart';

// Profile Endpoint
@freezed
abstract class ProfileDto with _$ProfileDto {
  const factory ProfileDto({
    String? symbol,
    double? price,
    double? changesPercentage,
    double? change,
    double? marketCap,
    double? beta,
    String? description,
    String? sector,
    String? industry,
    String? exchange,
    String? exchangeShortName,
    String? currency,
    bool? isEtf,
    bool? isFund,
    bool? isActivelyTrading,
    String? companyName,
    String? image,
    String? ceo,
    String? website,
    String? address,
    String? city,
    String? state,
    String? zip,
    String? phone,
    String? fullTimeEmployees,
    String? ipoDate,
    String? country,
  }) = _ProfileDto;

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);
}

// Quote Endpoint
@freezed
abstract class QuoteDto with _$QuoteDto {
  const factory QuoteDto({
    required String symbol,
    required String name,
    double? price,
    double? change,
    double? changesPercentage,
    double? marketCap,
    double? pe,
    double? eps,
    double? volume,
    double? sharesOutstanding,
  }) = _QuoteDto;

  factory QuoteDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteDtoFromJson(json);
}
