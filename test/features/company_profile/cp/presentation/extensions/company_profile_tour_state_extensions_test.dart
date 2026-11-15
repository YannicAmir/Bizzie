import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/cp/presentation/extensions/company_profile_tour_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/growth_band.dart';
import 'package:flutter_test/flutter_test.dart';

const tActive = CompanyProfileTourActive(
  ticker: 'AAPL',
  companyName: 'Apple',
  shouldPromptNotifications: false,
  step: CompanyProfileTourStep.revenueGrowth,
);

String? tGrowthCopy(GrowthBand band, int years) => tActive
    .copyWith(revenueGrowth: (band: band, years: years))
    .describe(CompanyProfileTourStep.revenueGrowth);

void main() {
  group('CompanyProfileTourStateX', () {
    test('descriptionFor_initial_returnsNull', () {
      // arrange
      const sut = CompanyProfileTourState.initial();

      // act
      final result = sut.descriptionFor(CompanyProfileTourStep.tabs);

      // assert
      expect(result, isNull);
    });

    test('visibleStep_awaitingRevenueData_returnsNull', () {
      // arrange
      final sut = tActive.copyWith(isAwaitingRevenueData: true);

      // act
      final result = sut.visibleStep;

      // assert
      expect(result, isNull);
      expect(sut.isAwaitingRevenue, isTrue);
      expect(sut.isTourActive, isTrue);
    });

    test('canGoBackFrom_currentStepWithCompletedPrevious_returnsTrue', () {
      // arrange
      final sut = tActive.copyWith(
        step: CompanyProfileTourStep.tabs,
        completedSteps: {CompanyProfileTourStep.companyOverview},
      );

      // act
      final result = sut.canGoBackFrom(CompanyProfileTourStep.tabs);

      // assert
      expect(result, isTrue);
    });

    test('canGoBackFrom_otherStep_returnsFalse', () {
      // arrange
      final sut = tActive.copyWith(
        step: CompanyProfileTourStep.tabs,
        completedSteps: {CompanyProfileTourStep.companyOverview},
      );

      // act
      final result = sut.canGoBackFrom(CompanyProfileTourStep.revenueTab);

      // assert
      expect(result, isFalse);
    });

    test('canGoBackFrom_initial_returnsFalse', () {
      // arrange
      const sut = CompanyProfileTourState.initial();

      // act
      final result = sut.canGoBackFrom(CompanyProfileTourStep.tabs);

      // assert
      expect(result, isFalse);
    });
  });

  group('CompanyProfileTourActiveX', () {
    test('previousStep_perStep_followsTourBackNavigationRules', () {
      // arrange
      const tAllCompleted = {...CompanyProfileTourStep.values};
      const tExpected = {
        CompanyProfileTourStep.companyOverview: null,
        CompanyProfileTourStep.tabs: CompanyProfileTourStep.companyOverview,
        CompanyProfileTourStep.revenueTab: CompanyProfileTourStep.tabs,
        CompanyProfileTourStep.revenueGrowth: null,
        CompanyProfileTourStep.stayUpdated:
            CompanyProfileTourStep.revenueGrowth,
      };

      for (final entry in tExpected.entries) {
        // act
        final result = tActive
            .copyWith(step: entry.key, completedSteps: tAllCompleted)
            .previousStep;

        // assert
        expect(result, entry.value, reason: entry.key.name);
      }
    });

    test('previousStep_previousStepNotCompleted_returnsNull', () {
      // arrange
      final sut = tActive.copyWith(
        step: CompanyProfileTourStep.stayUpdated,
        completedSteps: {
          CompanyProfileTourStep.companyOverview,
          CompanyProfileTourStep.tabs,
          CompanyProfileTourStep.revenueTab,
        },
      );

      // act
      final result = sut.previousStep;

      // assert
      expect(result, isNull);
    });

    test('describe_staticSteps_returnsFinalCopy', () {
      // arrange
      const sut = tActive;

      // act
      final overview = sut.describe(CompanyProfileTourStep.companyOverview);
      final tabs = sut.describe(CompanyProfileTourStep.tabs);
      final revenueTab = sut.describe(CompanyProfileTourStep.revenueTab);
      final stayUpdated = sut.describe(CompanyProfileTourStep.stayUpdated);

      // assert
      expect(
        overview,
        'You are currently in the Company Profile of Apple (AAPL). '
        "Here's where you'll get the most value in Bizzie.",
      );
      expect(
        tabs,
        'Use the tabs to get an in-depth look at the business, get company '
        'news, and information about the stock.',
      );
      expect(
        revenueTab,
        "Let's check out Apple's revenue!\n"
        'Tap "Revenue" to continue.',
      );
      expect(
        stayUpdated,
        'Add companies to your watchlist and turn on your notifications to '
        "stay updated on news and AI Reports as soon as they're released. "
        'Happy investing!',
      );
    });

    test('describe_revenueGrowthBands_returnsBandCopyWithPeriod', () {
      // arrange
      const tExpected = {
        (GrowthBand.negative, 3):
            "It looks like Apple's revenue has declined over the past 3 years. "
            "This is something you'll want to investigate in Apple's reports "
            'and news.',
        (
          GrowthBand.low,
          5,
        ): "It looks like Apple's revenue growth has been slow and steady over "
            'the past 5 years.',
        (
          GrowthBand.moderate,
          2,
        ): "It looks like Apple's revenue growth has been moderate, not flashy "
            'over the past 2 years.',
        (GrowthBand.high, 1):
            "It looks like Apple's revenue growth has been impressive over the "
            'past year!',
        (
          GrowthBand.turnedNegative,
          1,
        ): "It looks like Apple's revenue has declined over the past year. This "
            "is something you'll want to investigate in Apple's reports and "
            'news.',
        (GrowthBand.turnedPositive, 1):
            "It looks like Apple's revenue has turned positive over the past "
            'year!',
      };

      for (final entry in tExpected.entries) {
        // act
        final result = tGrowthCopy(entry.key.$1, entry.key.$2);

        // assert
        expect(result, entry.value);
      }
    });

    test('describe_revenueGrowthUnresolved_returnsNull', () {
      // arrange
      const sut = tActive;

      // act
      final result = sut.describe(CompanyProfileTourStep.revenueGrowth);

      // assert
      expect(result, isNull);
    });
  });
}
