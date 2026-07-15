import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';

extension SecurityDetailsX on SecurityDetails {
  CompanyProfile toCompanyProfile() => CompanyProfile(
    symbol: ticker,
    companyName: name,
    sector: sector,
    industry: industry,
  );
}
