import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile.freezed.dart';

@freezed
abstract class CompanyProfile with _$CompanyProfile {
  const factory CompanyProfile({
    required String symbol,
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
  }) = _CompanyProfile;
}
