import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_profile_update.dart';
import 'package:bizzie/features/onboarding/domain/services/onboarding_profile_builder.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:flutter_test/flutter_test.dart';

const tUid = 'uid-1';
const tData = OnboardingData(
  firstName: 'Jane',
  selectedSector: Sector.informationTechnology,
  detectedCompanies: [Company(ticker: 'AAPL', name: 'Apple')],
  investingExperience: InvestingExperience.expert,
  notificationsEnabled: true,
  hasDecidedNotifications: true,
);

void main() {
  late OnboardingProfileBuilder sut;

  setUp(() {
    sut = OnboardingProfileBuilder();
  });

  group('OnboardingProfileBuilder', () {
    group('newUser', () {
      test('newUser_fullData_mapsAllFieldsWithSanitizedSector', () {
        // arrange
        const tokens = {'device-1': 'token-1'};

        // act
        final user = sut.newUser(uid: tUid, data: tData, fcmTokens: tokens);

        // assert
        expect(user.uid, tUid);
        expect(user.name, 'Jane');
        expect(user.favoriteSector, 'informationtechnology');
        expect(user.watchlist, const [Company(ticker: 'AAPL', name: 'Apple')]);
        expect(user.investingExperience, InvestingExperience.expert);
        expect(user.isSubscribed, isFalse);
        expect(user.notificationsEnabled, isTrue);
        expect(user.fcmTokens, tokens);
      });

      test('newUser_missingSectorAndExperience_usesEmptySectorAndBeginner', () {
        // arrange
        const data = OnboardingData(firstName: 'Jane');

        // act
        final user = sut.newUser(uid: tUid, data: data, fcmTokens: const {});

        // assert
        expect(user.favoriteSector, isEmpty);
        expect(user.investingExperience, InvestingExperience.beginner);
        expect(user.fcmTokens, isEmpty);
      });
    });

    group('profileUpdate', () {
      test(
        'profileUpdate_decidedFields_includesNameExperienceAndNotifications',
        () {
          // arrange

          // act
          final update = sut.profileUpdate(uid: tUid, data: tData);

          // assert
          expect(
            update,
            const OnboardingProfileUpdate(
              uid: tUid,
              name: 'Jane',
              investingExperience: InvestingExperience.expert,
              notificationsEnabled: true,
            ),
          );
        },
      );

      test('profileUpdate_blankNameAndUndecidedNotifications_omitsThem', () {
        // arrange
        const data = OnboardingData(
          firstName: '   ',
          notificationsEnabled: true,
        );

        // act
        final update = sut.profileUpdate(uid: tUid, data: data);

        // assert
        expect(update, const OnboardingProfileUpdate(uid: tUid));
      });
    });
  });
}
