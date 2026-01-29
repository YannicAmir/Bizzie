import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
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

  const ProfileDto._();

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  CompanyProfile toDomain() {
    return CompanyProfile(
      symbol: symbol ?? '',
      price: price,
      changesPercentage: changesPercentage,
      change: change,
      marketCap: marketCap,
      beta: beta,
      description: description,
      sector: sector,
      industry: industry,
      exchange: exchange,
      exchangeShortName: exchangeShortName,
      currency: currency,
      isEtf: isEtf,
      isFund: isFund,
      isActivelyTrading: isActivelyTrading,
      companyName: companyName,
      image: image,
      ceo: ceo,
      website: website,
      address: address,
      city: city,
      state: state,
      zip: zip,
      phone: phone,
      fullTimeEmployees: fullTimeEmployees,
      ipoDate: ipoDate,
      country: country,
    );
  }
}
