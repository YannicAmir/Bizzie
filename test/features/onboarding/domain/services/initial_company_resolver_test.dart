import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:bizzie/features/onboarding/domain/models/initial_company_selection.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_skip_defaults.dart';
import 'package:bizzie/features/onboarding/domain/services/initial_company_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

const tDefaultCompanies = [
  Company(ticker: 'NVDA', name: 'NVIDIA'),
  Company(ticker: 'AAPL', name: 'Apple'),
];
const tDefaults = OnboardingSkipDefaults(
  defaultWatchlist: tDefaultCompanies,
  defaultSector: Sector.informationTechnology,
  initialCompanyTicker: 'AAPL',
);
const tUserCompanies = [
  Company(ticker: 'NKE', name: 'Nike'),
  Company(ticker: 'SBUX', name: 'Starbucks'),
];

void main() {
  late InitialCompanyResolver sut;

  setUp(() {
    sut = InitialCompanyResolver();
  });

  group('InitialCompanyResolver', () {
    group('resolve', () {
      test('resolve_userSelectedCompanies_returnsFirstUserTicker', () {
        // arrange
        const tCompanies = tUserCompanies;

        // act
        final result = sut.resolve(
          userSelectedCompanies: tCompanies,
          defaults: tDefaults,
        );

        // assert
        expect(
          result,
          const InitialCompanySelection(
            ticker: 'NKE',
            source: OnboardingValueSource.userSelection,
          ),
        );
      });

      test(
        'resolve_noUserCompaniesAndInitialTickerInDefaultWatchlist_returnsInitialTicker',
        () {
          // arrange
          const tCompanies = <Company>[];

          // act
          final result = sut.resolve(
            userSelectedCompanies: tCompanies,
            defaults: tDefaults,
          );

          // assert
          expect(
            result,
            const InitialCompanySelection(
              ticker: 'AAPL',
              source: OnboardingValueSource.remoteDefault,
            ),
          );
        },
      );

      test(
        'resolve_initialTickerMissingFromDefaultWatchlist_returnsFirstDefaultTicker',
        () {
          // arrange
          const tMismatchedDefaults = OnboardingSkipDefaults(
            defaultWatchlist: tDefaultCompanies,
            initialCompanyTicker: 'TSLA',
          );

          // act
          final result = sut.resolve(
            userSelectedCompanies: const [],
            defaults: tMismatchedDefaults,
          );

          // assert
          expect(
            result,
            const InitialCompanySelection(
              ticker: 'NVDA',
              source: OnboardingValueSource.remoteDefault,
            ),
          );
        },
      );

      test('resolve_emptyDefaultWatchlist_returnsInitialTicker', () {
        // arrange
        const tEmptyWatchlistDefaults = OnboardingSkipDefaults(
          defaultWatchlist: [],
          initialCompanyTicker: 'TSLA',
        );

        // act
        final result = sut.resolve(
          userSelectedCompanies: const [],
          defaults: tEmptyWatchlistDefaults,
        );

        // assert
        expect(
          result,
          const InitialCompanySelection(
            ticker: 'TSLA',
            source: OnboardingValueSource.remoteDefault,
          ),
        );
      });
    });

    group('fromUserSelection', () {
      test(
        'fromUserSelection_userSelectedCompanies_returnsFirstUserTicker',
        () {
          // act
          final result = sut.fromUserSelection(tUserCompanies);

          // assert
          expect(
            result,
            const InitialCompanySelection(
              ticker: 'NKE',
              source: OnboardingValueSource.userSelection,
            ),
          );
        },
      );

      test('fromUserSelection_noUserCompanies_returnsNull', () {
        // act
        final result = sut.fromUserSelection(const []);

        // assert
        expect(result, isNull);
      });
    });

    group('fromDefaults', () {
      test(
        'fromDefaults_initialTickerInDefaultWatchlist_returnsInitialTicker',
        () {
          // act
          final result = sut.fromDefaults(tDefaults);

          // assert
          expect(
            result,
            const InitialCompanySelection(
              ticker: 'AAPL',
              source: OnboardingValueSource.remoteDefault,
            ),
          );
        },
      );
    });
  });
}
