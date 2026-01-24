import 'package:bizzie/features/company_profile/domain/models/business_profile.dart';

extension BusinessProfilePresentationX on BusinessProfile {
  String getSecFilingsModalTitle(bool isAnnual) {
    if (isForeignCompany) {
      return isAnnual ? 'All Annual Filings' : 'All Quarterly Filings';
    }
    return isAnnual ? 'All 10-K Filings' : 'All 10-Q Filings';
  }

  String getProxyFilingTitle() {
    return isForeignCompany
        ? 'Latest Annual Filing ($proxyFilingFormType)'
        : 'Latest Proxy Filing ($proxyFilingFormType)';
  }
}
