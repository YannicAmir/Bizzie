import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/presentation/analytics/security_tab_analytics.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/extensions/company_security_state_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

const tCompanyDetails = SecurityDetails(
  ticker: 'AAPL',
  name: 'Apple Inc.',
  sector: 'Technology',
  industry: 'Consumer Electronics',
  description: 'Apple designs consumer electronics.',
  currency: 'USD',
  isEtf: false,
  isFund: false,
  isActivelyTrading: true,
);

const tEtfDetails = SecurityDetails(
  ticker: 'SPY',
  name: 'SPDR S&P 500 ETF Trust',
  sector: '',
  industry: '',
  description: 'Tracks the S&P 500 index.',
  currency: 'USD',
  isEtf: true,
  isFund: false,
  isActivelyTrading: true,
);

const tFundDetails = SecurityDetails(
  ticker: 'VFIAX',
  name: 'Vanguard 500 Index Fund',
  sector: '',
  industry: '',
  description: 'Tracks the S&P 500 index.',
  currency: 'USD',
  isEtf: false,
  isFund: true,
  isActivelyTrading: true,
);

const tAnalyticsState = SecurityTabViewState(
  ticker: 'AAPL',
  securityType: 'company',
  timestamp: '2026-11-09T00:00:00.000Z',
);

const tFailure = Failure.server('error');

void main() {
  group('CompanySecurityStateX', () {
    group('isUnsupported', () {
      test('isUnsupported_unsupportedState_returnsTrue', () {
        // arrange
        const state = CompanySecurityState.unsupported(
          tEtfDetails,
          analyticsState: tAnalyticsState,
        );

        // act
        final result = state.isUnsupported;

        // assert
        expect(result, isTrue);
      });

      test('isUnsupported_loadedState_returnsFalse', () {
        // arrange
        const state = CompanySecurityState.loaded(
          tCompanyDetails,
          analyticsState: tAnalyticsState,
        );

        // act
        final result = state.isUnsupported;

        // assert
        expect(result, isFalse);
      });

      test('isUnsupported_initialState_returnsFalse', () {
        // arrange
        const state = CompanySecurityState.initial();

        // act
        final result = state.isUnsupported;

        // assert
        expect(result, isFalse);
      });

      test('isUnsupported_loadingState_returnsFalse', () {
        // arrange
        const state = CompanySecurityState.loading();

        // act
        final result = state.isUnsupported;

        // assert
        expect(result, isFalse);
      });

      test('isUnsupported_failureState_returnsFalse', () {
        // arrange
        const state = CompanySecurityState.failure(tFailure);

        // act
        final result = state.isUnsupported;

        // assert
        expect(result, isFalse);
      });
    });

    group('isCompany', () {
      test('isCompany_loadedCompany_returnsTrue', () {
        // arrange
        const state = CompanySecurityState.loaded(
          tCompanyDetails,
          analyticsState: tAnalyticsState,
        );

        // act
        final result = state.isCompany;

        // assert
        expect(result, isTrue);
      });

      test('isCompany_loadedEtf_returnsFalse', () {
        // arrange
        const state = CompanySecurityState.loaded(
          tEtfDetails,
          analyticsState: tAnalyticsState,
        );

        // act
        final result = state.isCompany;

        // assert
        expect(result, isFalse);
      });

      test('isCompany_loadedFund_returnsFalse', () {
        // arrange
        const state = CompanySecurityState.loaded(
          tFundDetails,
          analyticsState: tAnalyticsState,
        );

        // act
        final result = state.isCompany;

        // assert
        expect(result, isFalse);
      });

      test('isCompany_unsupportedState_returnsFalse', () {
        // arrange
        const state = CompanySecurityState.unsupported(
          tCompanyDetails,
          analyticsState: tAnalyticsState,
        );

        // act
        final result = state.isCompany;

        // assert
        expect(result, isFalse);
      });

      test('isCompany_initialState_returnsFalse', () {
        // arrange
        const state = CompanySecurityState.initial();

        // act
        final result = state.isCompany;

        // assert
        expect(result, isFalse);
      });

      test('isCompany_loadingState_returnsFalse', () {
        // arrange
        const state = CompanySecurityState.loading();

        // act
        final result = state.isCompany;

        // assert
        expect(result, isFalse);
      });

      test('isCompany_failureState_returnsFalse', () {
        // arrange
        const state = CompanySecurityState.failure(tFailure);

        // act
        final result = state.isCompany;

        // assert
        expect(result, isFalse);
      });
    });
  });
}
