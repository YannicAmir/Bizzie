import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/services/onboarding_watchlist_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

const tApple = Company(ticker: 'AAPL', name: 'Apple');
const tTesla = Company(ticker: 'TSLA', name: 'Tesla');
const tMicrosoft = Company(ticker: 'MSFT', name: 'Microsoft');
const tNvidia = Company(ticker: 'NVDA', name: 'Nvidia');
const tDefaultWatchlist = [tApple, tMicrosoft, tNvidia];
const tFiveCompanies = [
  tApple,
  tTesla,
  Company(ticker: 'AMZN', name: 'Amazon'),
  Company(ticker: 'GOOGL', name: 'Alphabet'),
  Company(ticker: 'META', name: 'Meta'),
];

void main() {
  late OnboardingWatchlistResolver sut;

  setUp(() {
    sut = OnboardingWatchlistResolver();
  });

  group('OnboardingWatchlistResolver', () {
    group('needsDefaults', () {
      test('needsDefaults_fewerThanFive_returnsTrue', () {
        // arrange
        const selection = [tApple, tTesla];

        // act
        final result = sut.needsDefaults(selection);

        // assert
        expect(result, isTrue);
      });

      test('needsDefaults_exactlyFive_returnsFalse', () {
        // arrange — tFiveCompanies

        // act
        final result = sut.needsDefaults(tFiveCompanies);

        // assert
        expect(result, isFalse);
      });
    });

    group('resolve', () {
      test('resolve_fewerThanFive_appendsOnlyMissingDefaults', () {
        // arrange
        const selection = [tTesla, tApple];

        // act
        final result = sut.resolve(
          userSelectedCompanies: selection,
          defaultWatchlist: tDefaultWatchlist,
        );

        // assert
        expect(result, [tTesla, tApple, tMicrosoft, tNvidia]);
      });

      test('resolve_emptySelection_returnsDefaults', () {
        // arrange
        const selection = <Company>[];

        // act
        final result = sut.resolve(
          userSelectedCompanies: selection,
          defaultWatchlist: tDefaultWatchlist,
        );

        // assert
        expect(result, tDefaultWatchlist);
      });

      test('resolve_fiveOrMore_returnsSelectionUnchanged', () {
        // arrange — tFiveCompanies

        // act
        final result = sut.resolve(
          userSelectedCompanies: tFiveCompanies,
          defaultWatchlist: tDefaultWatchlist,
        );

        // assert
        expect(result, tFiveCompanies);
      });
    });
  });
}
