import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile_dto.freezed.dart';
part 'company_profile_dto.g.dart';

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
