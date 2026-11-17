import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_field_sources.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_skip_defaults.dart';
import 'package:bizzie/features/onboarding/domain/services/guest_username_generator.dart';
import 'package:bizzie/features/onboarding/domain/services/skipped_onboarding_data_resolver.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGuestUsernameGenerator extends Mock
    implements GuestUsernameGenerator {}

const tGuestName = 'userabc123xyz0';
const tDefaultCompanies = [
  Company(ticker: 'AAPL', name: 'Apple'),
  Company(ticker: 'MSFT', name: 'Microsoft'),
];
const tDefaults = OnboardingSkipDefaults(
  defaultWatchlist: tDefaultCompanies,
  defaultSector: Sector.informationTechnology,
  initialCompanyTicker: 'AAPL',
);
const tUserCompanies = [Company(ticker: 'NKE', name: 'Nike')];
const tUserData = OnboardingData(
  firstName: 'Jane',
  selectedSector: Sector.healthCare,
  detectedCompanies: tUserCompanies,
  investingExperience: InvestingExperience.expert,
  notificationsEnabled: true,
  hasDecidedNotifications: true,
);

void main() {
  late SkippedOnboardingDataResolver sut;
  late MockGuestUsernameGenerator mockUsernameGenerator;

  setUp(() {
    mockUsernameGenerator = MockGuestUsernameGenerator();
    when(() => mockUsernameGenerator.resolveName('')).thenReturn(tGuestName);
    when(() => mockUsernameGenerator.resolveName('   ')).thenReturn(tGuestName);
    when(() => mockUsernameGenerator.resolveName('Jane')).thenReturn('Jane');
    sut = SkippedOnboardingDataResolver(mockUsernameGenerator);
  });

  group('SkippedOnboardingDataResolver', () {
    group('resolve', () {
      test('resolve_emptyData_appliesAllDefaults', () {
        // arrange
        const tData = OnboardingData();

        // act
        final result = sut.resolve(data: tData, defaults: tDefaults);

        // assert
        expect(
          result.data,
          const OnboardingData(
            firstName: tGuestName,
            selectedSector: Sector.informationTechnology,
            detectedCompanies: tDefaultCompanies,
            investingExperience: InvestingExperience.beginner,
          ),
        );
        expect(
          result.sources,
          const OnboardingFieldSources(
            name: OnboardingValueSource.localDefault,
            sector: OnboardingValueSource.remoteDefault,
            companies: OnboardingValueSource.remoteDefault,
            experience: OnboardingValueSource.localDefault,
            notifications: OnboardingValueSource.localDefault,
          ),
        );
      });

      test('resolve_fullUserData_keepsUserValues', () {
        // arrange
        const tData = tUserData;

        // act
        final result = sut.resolve(data: tData, defaults: tDefaults);

        // assert
        expect(result.data, tUserData);
        expect(
          result.sources,
          const OnboardingFieldSources(
            name: OnboardingValueSource.userSelection,
            sector: OnboardingValueSource.userSelection,
            companies: OnboardingValueSource.userSelection,
            experience: OnboardingValueSource.userSelection,
            notifications: OnboardingValueSource.userSelection,
          ),
        );
        verify(() => mockUsernameGenerator.resolveName('Jane')).called(1);
      });

      test('resolve_userSelectedCompanies_replacesDefaultWatchlist', () {
        // arrange
        const tData = OnboardingData(detectedCompanies: tUserCompanies);

        // act
        final result = sut.resolve(data: tData, defaults: tDefaults);

        // assert
        expect(result.data.detectedCompanies, tUserCompanies);
      });

      test('resolve_whitespaceName_generatesGuestUsername', () {
        // arrange
        const tData = OnboardingData(firstName: '   ');

        // act
        final result = sut.resolve(data: tData, defaults: tDefaults);

        // assert
        expect(result.data.firstName, tGuestName);
        expect(result.sources.name, OnboardingValueSource.localDefault);
      });

      test('resolve_declinedNotifications_keepsDeclinedAsUserSelection', () {
        // arrange
        const tData = OnboardingData(hasDecidedNotifications: true);

        // act
        final result = sut.resolve(data: tData, defaults: tDefaults);

        // assert
        expect(result.data.notificationsEnabled, isFalse);
        expect(result.data.hasDecidedNotifications, isTrue);
        expect(
          result.sources.notifications,
          OnboardingValueSource.userSelection,
        );
      });

      test('resolve_noDefaultSector_leavesSectorNullWithNoneSource', () {
        // arrange
        const tData = OnboardingData();
        final tDefaultsWithoutSector = tDefaults.copyWith(defaultSector: null);

        // act
        final result = sut.resolve(
          data: tData,
          defaults: tDefaultsWithoutSector,
        );

        // assert
        expect(result.data.selectedSector, isNull);
        expect(result.sources.sector, OnboardingValueSource.none);
      });

      test('resolve_userSelectedSectorWithoutDefault_reportsUserSelection', () {
        // arrange
        const tData = OnboardingData(selectedSector: Sector.healthCare);
        final tDefaultsWithoutSector = tDefaults.copyWith(defaultSector: null);

        // act
        final result = sut.resolve(
          data: tData,
          defaults: tDefaultsWithoutSector,
        );

        // assert
        expect(result.data.selectedSector, Sector.healthCare);
        expect(result.sources.sector, OnboardingValueSource.userSelection);
      });

      test(
        'resolve_emptyDefaultWatchlist_leavesCompaniesEmptyWithNoneSource',
        () {
          // arrange
          const tData = OnboardingData();
          final tDefaultsWithoutWatchlist = tDefaults.copyWith(
            defaultWatchlist: [],
          );

          // act
          final result = sut.resolve(
            data: tData,
            defaults: tDefaultsWithoutWatchlist,
          );

          // assert
          expect(result.data.detectedCompanies, isEmpty);
          expect(result.sources.companies, OnboardingValueSource.none);
        },
      );
    });

    group('resolve skip-step matrix', () {
      const tUser = OnboardingValueSource.userSelection;
      const tRemote = OnboardingValueSource.remoteDefault;
      const tLocal = OnboardingValueSource.localDefault;

      const tAfterName = OnboardingData(firstName: 'Jane');
      const tAfterSector = OnboardingData(
        firstName: 'Jane',
        selectedSector: Sector.healthCare,
      );
      const tAfterBrands = OnboardingData(
        firstName: 'Jane',
        selectedSector: Sector.healthCare,
        rawBrandsText: 'Nike',
        detectedCompanies: tUserCompanies,
      );
      const tAfterNoMatchingBrands = OnboardingData(
        firstName: 'Jane',
        selectedSector: Sector.healthCare,
        rawBrandsText: 'Unknown Brand',
      );
      final tAfterNotificationsEnabled = tAfterBrands.copyWith(
        notificationsEnabled: true,
        hasDecidedNotifications: true,
      );
      final tAfterNotificationsDeclined = tAfterBrands.copyWith(
        hasDecidedNotifications: true,
      );
      final tAfterExperience = tAfterNotificationsDeclined.copyWith(
        investingExperience: InvestingExperience.intermediate,
      );

      final tCases =
          <
            ({
              String step,
              OnboardingData input,
              OnboardingData expected,
              OnboardingFieldSources sources,
            })
          >[
            (
              step: 'afterName',
              input: tAfterName,
              expected: const OnboardingData(
                firstName: 'Jane',
                selectedSector: Sector.informationTechnology,
                detectedCompanies: tDefaultCompanies,
                investingExperience: InvestingExperience.beginner,
              ),
              sources: const OnboardingFieldSources(
                name: tUser,
                sector: tRemote,
                companies: tRemote,
                experience: tLocal,
                notifications: tLocal,
              ),
            ),
            (
              step: 'afterSector',
              input: tAfterSector,
              expected: const OnboardingData(
                firstName: 'Jane',
                selectedSector: Sector.healthCare,
                detectedCompanies: tDefaultCompanies,
                investingExperience: InvestingExperience.beginner,
              ),
              sources: const OnboardingFieldSources(
                name: tUser,
                sector: tUser,
                companies: tRemote,
                experience: tLocal,
                notifications: tLocal,
              ),
            ),
            (
              step: 'afterBrandsWithMatches',
              input: tAfterBrands,
              expected: tAfterBrands.copyWith(
                investingExperience: InvestingExperience.beginner,
              ),
              sources: const OnboardingFieldSources(
                name: tUser,
                sector: tUser,
                companies: tUser,
                experience: tLocal,
                notifications: tLocal,
              ),
            ),
            (
              step: 'afterBrandsWithoutMatches',
              input: tAfterNoMatchingBrands,
              expected: tAfterNoMatchingBrands.copyWith(
                detectedCompanies: tDefaultCompanies,
                investingExperience: InvestingExperience.beginner,
              ),
              sources: const OnboardingFieldSources(
                name: tUser,
                sector: tUser,
                companies: tRemote,
                experience: tLocal,
                notifications: tLocal,
              ),
            ),
            (
              step: 'afterNotificationsEnabled',
              input: tAfterNotificationsEnabled,
              expected: tAfterNotificationsEnabled.copyWith(
                investingExperience: InvestingExperience.beginner,
              ),
              sources: const OnboardingFieldSources(
                name: tUser,
                sector: tUser,
                companies: tUser,
                experience: tLocal,
                notifications: tUser,
              ),
            ),
            (
              step: 'afterNotificationsDeclined',
              input: tAfterNotificationsDeclined,
              expected: tAfterNotificationsDeclined.copyWith(
                investingExperience: InvestingExperience.beginner,
              ),
              sources: const OnboardingFieldSources(
                name: tUser,
                sector: tUser,
                companies: tUser,
                experience: tLocal,
                notifications: tUser,
              ),
            ),
            (
              step: 'afterExperience',
              input: tAfterExperience,
              expected: tAfterExperience,
              sources: const OnboardingFieldSources(
                name: tUser,
                sector: tUser,
                companies: tUser,
                experience: tUser,
                notifications: tUser,
              ),
            ),
          ];

      for (final tCase in tCases) {
        test('resolve_${tCase.step}_mergesDataAndReportsSources', () {
          // arrange
          final tData = tCase.input;

          // act
          final result = sut.resolve(data: tData, defaults: tDefaults);

          // assert
          expect(result.data, tCase.expected);
          expect(result.sources, tCase.sources);
        });
      }
    });

    group('unresolved', () {
      test('unresolved_emptyData_keepsDataAndReportsNoneSources', () {
        // arrange
        const tData = OnboardingData();

        // act
        final result = sut.unresolved(tData);

        // assert
        expect(result.data, tData);
        expect(
          result.sources,
          const OnboardingFieldSources(
            name: OnboardingValueSource.none,
            sector: OnboardingValueSource.none,
            companies: OnboardingValueSource.none,
            experience: OnboardingValueSource.none,
            notifications: OnboardingValueSource.none,
          ),
        );
        verifyNever(() => mockUsernameGenerator.resolveName(any()));
      });

      test('unresolved_fullUserData_reportsUserSelectionSources', () {
        // act
        final result = sut.unresolved(tUserData);

        // assert
        expect(result.data, tUserData);
        expect(
          result.sources,
          const OnboardingFieldSources(
            name: OnboardingValueSource.userSelection,
            sector: OnboardingValueSource.userSelection,
            companies: OnboardingValueSource.userSelection,
            experience: OnboardingValueSource.userSelection,
            notifications: OnboardingValueSource.userSelection,
          ),
        );
      });
    });
  });
}
