import 'package:bizzie/features/company_profile/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/presentation/utils/business_profile_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BusinessProfilePresentationX', () {
    const profile = BusinessProfile(
      symbol: 'AAPL',
      companyName: 'Apple Inc.',
      sector: 'Technology',
      industry: 'Consumer Electronics',
      description: 'Description',
      ceo: 'Tim Cook',
      website: 'https://apple.com',
      address: 'One Apple Park Way',
      city: 'Cupertino',
      state: 'CA',
      zip: '95014',
      phone: '408-996-1010',
      fullTimeEmployees: '161,000',
      executives: [],
    );

    group('getSecFilingsModalTitle', () {
      test('returns 10-K label for domestic annual filings', () {
        const domesticProfile = profile;
        expect(
          domesticProfile.getSecFilingsModalTitle(true),
          'All 10-K Filings',
        );
      });

      test('returns 10-Q label for domestic quarterly filings', () {
        const domesticProfile = profile;
        expect(
          domesticProfile.getSecFilingsModalTitle(false),
          'All 10-Q Filings',
        );
      });

      test('returns Annual label for foreign annual filings', () {
        final foreignProfile = profile.copyWith(isForeignCompany: true);
        expect(
          foreignProfile.getSecFilingsModalTitle(true),
          'All Annual Filings',
        );
      });

      test('returns Quarterly label for foreign quarterly filings', () {
        final foreignProfile = profile.copyWith(isForeignCompany: true);
        expect(
          foreignProfile.getSecFilingsModalTitle(false),
          'All Quarterly Filings',
        );
      });
    });

    group('getProxyFilingTitle', () {
      test('returns Proxy Filing label for domestic companies', () {
        const domesticProfile = profile;
        expect(
          domesticProfile.getProxyFilingTitle(),
          'Latest Proxy Filing (DEF 14A)',
        );
      });

      test('returns Proxy Filing label with custom form type for domestic', () {
        final domesticProfile = profile.copyWith(proxyFilingFormType: 'CUSTOM');
        expect(
          domesticProfile.getProxyFilingTitle(),
          'Latest Proxy Filing (CUSTOM)',
        );
      });

      test('returns Annual Filing label for foreign companies', () {
        final foreignProfile = profile.copyWith(
          isForeignCompany: true,
          proxyFilingFormType: '20-F',
        );
        expect(
          foreignProfile.getProxyFilingTitle(),
          'Latest Annual Filing (20-F)',
        );
      });
    });
  });
}

extension on BusinessProfile {
  BusinessProfile copyWith({
    bool? isForeignCompany,
    String? proxyFilingFormType,
  }) {
    return BusinessProfile(
      symbol: symbol,
      companyName: companyName,
      sector: sector,
      industry: industry,
      description: description,
      ceo: ceo,
      website: website,
      address: address,
      city: city,
      state: state,
      zip: zip,
      phone: phone,
      fullTimeEmployees: fullTimeEmployees,
      executives: executives,
      def14aUrl: def14aUrl,
      isForeignCompany: isForeignCompany ?? this.isForeignCompany,
      proxyFilingFormType: proxyFilingFormType ?? this.proxyFilingFormType,
      annualFilings: annualFilings,
      quarterlyFilings: quarterlyFilings,
    );
  }
}
