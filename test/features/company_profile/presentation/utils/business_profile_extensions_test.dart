import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/business/presentation/utils/business_profile_extensions.dart';
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
      test('getSecFilingsModalTitle_domesticAnnual_returns10KLabel', () {
        // arrange
        const domesticProfile = profile;

        // act
        final result = domesticProfile.getSecFilingsModalTitle(true);

        // assert
        expect(result, 'All 10-K Filings');
      });

      test('getSecFilingsModalTitle_domesticQuarterly_returns10QLabel', () {
        // arrange
        const domesticProfile = profile;

        // act
        final result = domesticProfile.getSecFilingsModalTitle(false);

        // assert
        expect(result, 'All 10-Q Filings');
      });

      test('getSecFilingsModalTitle_foreignAnnual_returnsAnnualLabel', () {
        // arrange
        final foreignProfile = profile.copyWith(isForeignCompany: true);

        // act
        final result = foreignProfile.getSecFilingsModalTitle(true);

        // assert
        expect(result, 'All Annual Filings');
      });

      test(
        'getSecFilingsModalTitle_foreignQuarterly_returnsQuarterlyLabel',
        () {
          // arrange
          final foreignProfile = profile.copyWith(isForeignCompany: true);

          // act
          final result = foreignProfile.getSecFilingsModalTitle(false);

          // assert
          expect(result, 'All Quarterly Filings');
        },
      );
    });

    group('getProxyFilingTitle', () {
      test('getProxyFilingTitle_domestic_returnsProxyFilingLabel', () {
        // arrange
        const domesticProfile = profile;

        // act
        final result = domesticProfile.getProxyFilingTitle();

        // assert
        expect(result, 'Latest Proxy Filing (DEF 14A)');
      });

      test('getProxyFilingTitle_domesticCustomForm_returnsCustomLabel', () {
        // arrange
        final domesticProfile = profile.copyWith(proxyFilingFormType: 'CUSTOM');

        // act
        final result = domesticProfile.getProxyFilingTitle();

        // assert
        expect(result, 'Latest Proxy Filing (CUSTOM)');
      });

      test('getProxyFilingTitle_foreign_returnsAnnualFilingLabel', () {
        // arrange
        final foreignProfile = profile.copyWith(
          isForeignCompany: true,
          proxyFilingFormType: '20-F',
        );

        // act
        final result = foreignProfile.getProxyFilingTitle();

        // assert
        expect(result, 'Latest Annual Filing (20-F)');
      });
    });
  });
}
