import 'package:bizzie/features/company_profile/business/domain/models/sec_filing.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_profile.freezed.dart';

@freezed
abstract class BusinessProfile with _$BusinessProfile {
  const factory BusinessProfile({
    required String symbol,
    required String companyName,
    required String sector,
    required String industry,
    required String description,
    required String ceo,
    required String website,
    required String address,
    required String city,
    required String state,
    required String zip,
    required String phone,
    required String fullTimeEmployees,
    String? def14aUrl,
    @Default(false) bool isForeignCompany,
    @Default('DEF 14A') String proxyFilingFormType,
    @Default([]) List<SecFiling> annualFilings,
    @Default([]) List<SecFiling> quarterlyFilings,
  }) = _BusinessProfile;
}
