import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';

extension BusinessProfilePresentationX on BusinessProfile {
  String getSecFilingsModalTitle(FinancialPeriod period) {
    if (isForeignCompany) {
      return switch (period) {
        FinancialPeriod.annual => 'All Annual Filings',
        FinancialPeriod.quarterly => 'All Quarterly Filings',
      };
    }
    return switch (period) {
      FinancialPeriod.annual => 'All 10-K Filings',
      FinancialPeriod.quarterly => 'All 10-Q Filings',
    };
  }

  String getProxyFilingTitle() {
    return isForeignCompany
        ? 'Latest Annual Filing ($proxyFilingFormType)'
        : 'Latest Proxy Filing ($proxyFilingFormType)';
  }
}
